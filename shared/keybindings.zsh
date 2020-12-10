# Fix home/end keys.
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Enable history search with up and down arrows
# once you've typed something.
autoload -U up-line-or-beginning-search	
autoload -U down-line-or-beginning-search	
zle -N up-line-or-beginning-search	
zle -N down-line-or-beginning-search	
bindkey "^[[A" up-line-or-beginning-search # Up	
bindkey "^[[B" down-line-or-beginning-search # Down
