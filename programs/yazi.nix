{
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      mgr = {
        ratio = [
          0
          4
          4
        ];
        show_hidden = true;
        sort_dir_first = true;
        linemode = "size";
        show_symlink = true;
      };
      preview = {
        max_width = 3000;
        max_height = 3000;
      };
    };

    # theme.mgr.border_style.fg = "cyan";

    plugins = {
      toggle-pane = pkgs.yaziPlugins.toggle-pane;

      # `setup = true` generates `require("full-border"):setup(...)` in init.lua.
      # full-border = {
      #   package = pkgs.yaziPlugins.full-border;
      #   setup = true;
      #   # Optional; the default is ui.Border.PLAIN
      #   settings.type = lib.generators.mkLuaInline "ui.Border.ROUNDED";
      # };

      # Right/Left behave like vanilla yazi on directories, but on a file Right
      # maximizes the preview and Left restores the panes. While the preview is
      # maximized, j/k/Up/Down keep moving the cursor as usual.
      enter-or-preview = pkgs.writeTextDir "main.lua" ''
        --- @sync entry
        local function maximized()
          return rt.mgr.ratio[3] == 9999
        end

        local function entry(_, job)
          if job.args[1] == "right" then
            if maximized() then
              return
            end
            local hovered = cx.active.current.hovered
            if hovered and hovered.cha.is_dir then
              ya.emit("enter", {})
            elseif hovered then
              ya.emit("plugin", { "toggle-pane", "max-preview" })
            end
          elseif maximized() then
            ya.emit("plugin", { "toggle-pane", "max-preview" })
          else
            ya.emit("leave", {})
          end
        end

        return { entry = entry }
      '';
    };

    keymap.mgr.prepend_keymap = [
      {
        on = "<Right>";
        run = "plugin enter-or-preview right";
        desc = "Enter directory or maximize preview";
      }
      {
        on = "l";
        run = "plugin enter-or-preview right";
        desc = "Enter directory or maximize preview";
      }
      {
        on = "<Left>";
        run = "plugin enter-or-preview left";
        desc = "Restore panes or leave directory";
      }
      {
        on = "h";
        run = "plugin enter-or-preview left";
        desc = "Restore panes or leave directory";
      }
    ];
  };
}
