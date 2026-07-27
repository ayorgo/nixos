# FZF keybindings
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# More lsd integration
alias ld='lsd -lAN --group-directories-first'

# Neovim aliases
alias vi='nvim'
alias vim='nvim'
alias vmi='nvim'

# Set it via `security add-generic-password -a "$USER" -s "ANTHROPIC_AUTH_TOKEN" -w` first.
export ANTHROPIC_AUTH_TOKEN=$(security find-generic-password -a $USER -s ANTHROPIC_AUTH_TOKEN -w 2>/dev/null)
# Set it via `security add-generic-password -a "$USER" -s "ANTHROPIC_BASE_URL" -w` first.
export ANTHROPIC_BASE_URL=$(security find-generic-password -a $USER -s ANTHROPIC_BASE_URL -w 2>/dev/null)
export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1
export CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1
