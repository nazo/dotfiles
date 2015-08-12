# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
setopt print_eight_bit

autoload -U compinit
compinit

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="# %{${reset_color}%}"
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}root%B${PROMPT}"
    ;;
*)
    PROMPT="%% %{${reset_color}%}"
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}%n%B${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
# bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^y" redo
bindkey "^j" reverse-menu-complete


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias l="ls -l"
alias sl="ls"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias gs="git svn"
alias gsup="git stash;git svn rebase;git stash pop;"

alias svn_add_all="svn st | grep '^\?' | sed -e 's/\?[ ]*/svn add /g' | sh"

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports()
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-256color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;32;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

export TERM=xterm-256color

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*|screen)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}\007"
      psvar=()
      LANG=en_US.UTF-8 vcs_info
      [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=32:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=32' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr           # new
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r' # new
zstyle ':vcs_info:bzr:*' use-simple true             # new
RPROMPT="[%~]%1(v|%F{green}%1v%f|)"

function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

if [ "$TERM" = "screen" ]; then
    # chpwd () { echo -n "#_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
            if (( $#cmd == 1 )); then
                cmd=(builtin jobs -l %+)
            else
                cmd=(builtin jobs -l $cmd[2])
            fi
            ;;
            %*)
            cmd=(builtin jobs -l $cmd[1])
            ;;
            cd)
            if (( $#cmd == 2)); then
                cmd[1]=$cmd[2]
            fi
            ;&
            *)
            echo -n "k$cmd[1]:t\\"
            return
            ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
        cmd=(${(z)${(e):-\$jt$num}})
        echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    # chpwd
fi

function ssh_screen(){
 eval server=\${$#}
  screen -t $server ssh "$@"
}
#if [ x$TERM = xscreen ]; then
#  alias ssh=ssh_screen
#fi

if [ $TERM = screen ]; then
#    function mosh_tmux() {
#        tmux new-window -n $@ "exec mosh $@"
#    }
#    alias mosh=mosh_tmux
#    function ssh_tmux() {
#        tmux new-window -n $@ "exec ssh $@"
#    }
#    alias ssh=ssh_tmux
fi

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# git completion
# autoload bashcompinit
# bashcompinit
# source $HOME/dotfiles/git-completion.bash

# bindkey -v
stty stop undef


export JAVA_HOME=/usr/lib/jvm/java-6-sun
export JRUBY_HOME=/opt/gae-j
export PATH=$HOME/.nimble/bin:/usr/local/heroku/bin:$HOME/bin:$HOME/flex_sdk/bin:$HOME/opt/tig:$HOME/app/termtter/bin:$HOME/.cabal/bin:$HOME/.composer/vendor/bin:$JRUBY_HOME/bin:$JAVA_HOME/bin:/opt/local/bin:/opt/bin:/opt/screen/bin:/opt/zsh/bin:/opt/gae-j/bin:/usr/local/google_appengine:/opt/ctags/bin:/usr/gnu/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

export EDITOR=/usr/bin/vim
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}


#if ! is_screen_or_tmux_running && shell_has_started_interactively; then
#    for cmd in tmux tscreen screen; do
#        if whence $cmd >/dev/null 2>/dev/null; then
#            $(resolve_alias "$cmd")
#            break
#        fi
#    done
#fi

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

if [ `uname` = "Darwin" ]; then
    export __CF_USER_TEXT_ENCODING="0x1F5:0x08000100:14"

    EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
    export EDITOR
    alias vim=/Applications/MacVim.app/Contents/MacOS/Vim

    export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
fi

function tmux_set_color {
    if [ -z "$SSH_CONNECTION" ]; then
        tmux set -t: status-bg                colour64
        tmux set -t: pane-active-border-fg    colour64
        tmux set -t: pane-border-fg           colour238
        tmux set -t: window-status-current-bg colour22
    else
        tmux set -t: status-bg                colour30
        tmux set -t: pane-active-border-fg    colour30
        tmux set -t: pane-border-fg           colour238
        tmux set -t: window-status-current-bg colour18
    fi
}

function tmux_on_login {
    # NOTE:
    # Redirecting output of tmux to somewhere,
    # such as "tmux ls > /dev/null", will never return on some system!
    # You can use "| true" instead of "> /dev/null" to discard output.
    tmux_set_color | true
}

#if [[ -n "$TMUX" ]]; then
#    tmux_on_login
#fi

alias tmux='TERM=xterm-256color tmuxx'

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
