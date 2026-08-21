-- Expand a repository permalink into the code it points at.
--
-- A paragraph consisting of nothing but a blob URL carrying a line fragment,
--
--   https://gitlab.example.com/grp/proj/-/blob/<sha>/src/thing.py#L33-40
--
-- is replaced by those lines as a numbered code block, captioned with a link
-- back to the original. Numbering starts at the file's own line number, so
-- "line 37" in the prose means line 37 in the repository.
--
-- Anything that is not a recognised blob link with a line fragment is left
-- alone, so ordinary links pass through untouched and an unknown forge costs
-- a warning on stderr rather than a broken build.
--
-- Needs curl on PATH. Private repositories need a token, looked up first as
-- PANDOC_SNIPPET_TOKEN_<HOST> (non-alphanumerics become underscores, so
-- gitlab.kfplc.com reads PANDOC_SNIPPET_TOKEN_GITLAB_KFPLC_COM) and then
-- under the forge's conventional name. Responses are cached under
-- PANDOC_SNIPPET_CACHE (default ./.snippet-cache) so rebuilds work offline
-- and a document with twenty references makes twenty requests once, not once
-- per compile.

local cache_dir = os.getenv("PANDOC_SNIPPET_CACHE") or ".snippet-cache"

-- Forges are matched on URL shape rather than hostname wherever the shape is
-- distinctive. That way a self-hosted GitLab or Forgejo needs no new entry.
local forges = {
  {
    name = "gitlab",
    matches = function (url) return url:find("/%-/blob/", 1, false) end,
    raw = function (url) return (url:gsub("/%-/blob/", "/-/raw/", 1)) end,
    path = function (url) return url:match("/%-/blob/[^/]+/(.+)$") end,
    header = function (tok) return "PRIVATE-TOKEN: " .. tok end,
    env = "GITLAB_TOKEN",
  },
  {
    -- Anchored on github.com because the raw content lives on a different
    -- host. GitHub Enterprise uses <host>/<o>/<r>/raw/<ref>/<path> instead
    -- and would need its own entry.
    name = "github",
    matches = function (url)
      return url:match("^https://github%.com/[^/]+/[^/]+/blob/")
    end,
    raw = function (url)
      return (url:gsub("^https://github%.com/([^/]+)/([^/]+)/blob/",
                       "https://raw.githubusercontent.com/%1/%2/", 1))
    end,
    path = function (url)
      return url:match("^https://github%.com/[^/]+/[^/]+/blob/[^/]+/(.+)$")
    end,
    header = function (tok) return "Authorization: Bearer " .. tok end,
    env = "GITHUB_TOKEN",
  },
  {
    -- Codeberg, and any other Forgejo or Gitea instance.
    name = "forgejo",
    matches = function (url)
      return url:find("/src/commit/") or url:find("/src/branch/")
          or url:find("/src/tag/")
    end,
    raw = function (url) return (url:gsub("/src/", "/raw/", 1)) end,
    path = function (url) return url:match("/src/%w+/[^/]+/(.+)$") end,
    header = function (tok) return "Authorization: token " .. tok end,
    env = "CODEBERG_TOKEN",
  },
}

local extensions = {
  py = "python", lua = "lua", nix = "nix", sh = "bash", bash = "bash",
  js = "javascript", ts = "typescript", hs = "haskell", rs = "rust",
  go = "go", sql = "sql", yaml = "yaml", yml = "yaml", json = "json",
  toml = "toml", tex = "latex", c = "c", h = "c", cpp = "cpp", java = "java",
  el = "commonlisp", org = "org", md = "markdown",
}

-- GitLab writes #L33-40, GitHub and Forgejo write #L33-L40, all three write
-- #L33 for a single line.
local function line_range (fragment)
  local first, last = fragment:match("^L(%d+)%-L?(%d+)$")
  if first then return tonumber(first), tonumber(last) end
  first = fragment:match("^L(%d+)$")
  if first then return tonumber(first), tonumber(first) end
  return nil
end

local function identify (url)
  local base, fragment = url:match("^([^#]+)#(.+)$")
  if not base then return nil end

  local first, last = line_range(fragment)
  if not first or last < first then return nil end

  for _, forge in ipairs(forges) do
    if forge.matches(base) then
      return forge, forge.raw(base), first, last, forge.path(base) or base
    end
  end
  return nil
end

local function token_for (url, forge)
  local host = url:match("^https?://([^/]+)")
  if host then
    local key = host:upper():gsub("[^%w]", "_")
    local scoped = os.getenv("PANDOC_SNIPPET_TOKEN_" .. key)
    if scoped then return scoped end
  end
  return forge.env and os.getenv(forge.env) or nil
end

local function cache_path (raw)
  return cache_dir .. "/" .. raw:gsub("[^%w%.]", "_")
end

local function read_file (path)
  local handle = io.open(path, "r")
  if not handle then return nil end
  local content = handle:read("a")
  handle:close()
  return content
end

local function fetch (raw, forge, url)
  local cached = read_file(cache_path(raw))
  if cached then return cached end

  -- --netrc-optional lets hosts already configured in ~/.netrc work with no
  -- environment variable at all.
  local args = { "-sSfL", "--netrc-optional" }
  local token = token_for(url, forge)
  if token then
    args[#args + 1] = "-H"
    args[#args + 1] = forge.header(token)
  end
  args[#args + 1] = raw

  local ok, body = pcall(pandoc.pipe, "curl", args, "")
  if not ok then return nil, tostring(body) end

  pandoc.system.make_directory(cache_dir, true)
  local out = io.open(cache_path(raw), "w")
  if out then
    out:write(body)
    out:close()
  end
  return body
end

local function slice (text, first, last)
  local lines, n = {}, 0
  for line in (text .. "\n"):gmatch("([^\n]*)\n") do
    n = n + 1
    if n > last then break end
    if n >= first then lines[#lines + 1] = line end
  end
  return table.concat(lines, "\n")
end

function Para (el)
  if #el.content ~= 1 then return nil end
  local node = el.content[1]
  local url = (node.t == "Link" and node.target)
           or (node.t == "Str" and node.text)
  if not url then return nil end

  local forge, raw, first, last, path = identify(url)
  if not forge then return nil end

  local body, err = fetch(raw, forge, url)
  if not body then
    io.stderr:write(("git-snippet: %s fetch failed for %s (%s)\n")
      :format(forge.name, raw, err))
    return nil
  end

  local code = slice(body, first, last)
  if code == "" then
    io.stderr:write(("git-snippet: %s has no lines %d-%d\n")
      :format(path, first, last))
    return nil
  end

  local classes = { "numberLines" }
  local lang = extensions[(path:match("%.([%w]+)$") or ""):lower()]
  if lang then table.insert(classes, 1, lang) end

  local block = pandoc.CodeBlock(
    code,
    pandoc.Attr("", classes, { { "startFrom", tostring(first) } })
  )

  -- The caption is a real Link so pandoc handles URL and text escaping; the
  -- RawInlines carry styling only and are dropped for non-LaTeX output.
  local label = first == last
    and ("%s:%d"):format(path, first)
    or ("%s:%d–%d"):format(path, first, last)
  local caption = pandoc.Plain {
    pandoc.RawInline("latex", "{\\footnotesize\\sffamily\\color{black!55}"),
    pandoc.Link({ pandoc.Str(label) }, url),
    pandoc.RawInline("latex", "}"),
  }

  return { caption, block }
end
