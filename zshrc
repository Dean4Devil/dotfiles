
# Hit Ctrl-Z again to return to suspended programs
# Note: Make this a tiny plugin?
ctrl-z-toggler() {
	if [[ $#BUFFERS -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}
zle -N ctrl-z-toggler
bindkey '^Z' ctrl-z-toggler

fpath+=~/.zsh/zfunc

autoload -Uz compinit promptinit
promptinit
compinit

setopt COMPLETE_ALIASES

HISTFILE=~/.zsh_history
SAVEHIST=1000
HISTSIZE=1000
setopt INC_APPEND_HISTORY

# Rehash all binaries on every complete. This may be slow.
zstyle ':completion:*' rehash true

alias vim='nvim'
source /etc/profile.d/alias.sh

source ~/.zsh/antigen-hs/init.zsh

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[5~" up-line-or-beginning-search
bindkey "^[[6~" down-line-or-beginning-search
bindkey "^[0A" up-line-or-beginning-search
bindkey "^[0B" down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

export PATH=$PATH:~/.local/bin
export EDITOR=nvim
export MANPAGER="nvim -c 'set filetype=man' -"

alias snd-mtrx='nc -u 151.217.1.45 12345'
source ~/.zsh/antigen-hs/init.zsh
