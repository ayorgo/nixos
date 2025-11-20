# FZF config
export FZF_DEFAULT_OPTS='--height 40% --border --color=gutter:-1'
export FZF_DEFAULT_COMMAND='find'

# FZF keybindings
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# More lsd integration
alias ld='lsd -laN --group-directories-first'

# Neovim aliases
alias vi='nvim'
alias vim='nvim'
alias vmi='nvim'
