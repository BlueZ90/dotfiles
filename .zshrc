# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand prefix
# zstyle ':completion:*' menu select=3
zstyle :compinstall filename '/home/mephory/.zshrc'

autoload -Uz compinit
autoload -U colors
compinit
colors
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.history
HISTSIZE=1000000
SAVEHIST=1000000
# End of lines configured by zsh-newuser-install

## With version control information
setopt prompt_subst
PROMPT='%{$fg[yellow]%}%n %{$fg[blue]%}%~ %{$fg[magenta]%}$(gitprompt)%(1j.%{$fg[green]|%j| .)%{$reset_color%}$ ' 
# PROMPT='%{$fg[yellow]%}atr %{$fg[blue]%}%~ %{$fg[magenta]%}$(gitprompt)%{$reset_color%}$ ' 

## Without version control information
# PROMPT='%{$fg[yellow]%}%n %{$fg[blue]%}%~ %{$reset_color%}$ ' 

bindkey -e
bindkey "^[[H"  beginning-of-line 
bindkey "\e[1~" beginning-of-line

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export EDITOR="vim"

fpath=(~/.zsh-completions $fpath)

source ~/.alias

# PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"
PATH="$PATH:$HOME/.gem/ruby/2.1.0/bin"
PATH="$PATH:$HOME/.cabal/bin"
PATH="$PATH:$HOME/bin"
export GOPATH="$GOPATH:$HOME/.go"

if [[ ! -f /tmp/todoread ]]; then
    todo
    touch /tmp/todoread
    ((sleep 3600 && rm /tmp/todoread) &)
fi
