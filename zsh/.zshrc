setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY 
setopt sharehistory
setopt extendedhistory
setopt appendhistory 
setopt autocd 
setopt extendedglob 
setopt prompt_subst

# Check if zplug is installed
[[ -d ~/.zplug ]] || {
  curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
  source ~/.zplug/zplug && zplug update --self
}


autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"



# Source 
source ~/.zplug/zplug




# Zplug
zplug "zsh-users/zsh-completions"
zplug "plugins/gitgastgit-extra", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh, ignore:oh-my-zsh.sh, nice:10
zplug "lib/directories", from:oh-my-zsh, ignore:oh-my-zsh.sh, nice:10
zplug "lib/git", from:oh-my-zsh, ignore:oh-my-zsh.sh, nice:10

zplug load

stty ixany
stty ixoff -ixon


 function zle-line-init zle-keymap-select {
	VIM_PROMPT="%{$fg_bold[red]%} [% %{$fg_bold[green]%}NORMAL%{$fg_bo    ld[red]%}]%  %{$reset_color%}"
	RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1



ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[red]%} → %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{$fg_bold[green]%}%c %{$fg_bold[red]%}» $(git_prompt_info)%{$reset_color%}'


##ALIAS
alias G="| grep "
alias L="| less "
alias ls="ls --color=tty"
alias la="ls -lah"
alias ..="cd .."


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
