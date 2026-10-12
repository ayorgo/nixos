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
