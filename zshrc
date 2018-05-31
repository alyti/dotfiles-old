SAVEHIST=5000
HISTFILE=~/.zsh_history

# no c-s/c-q output freezing
setopt noflowcontrol
# allow expansion in prompts
setopt prompt_subst
# this is default, but set for share_history
setopt append_history
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
setopt nonomatch
# report the status of backgrounds jobs immediately
setopt notify
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
# not just at the end
setopt completeinword
# use zsh style word splitting
setopt noshwordsplit
# allow use of comments in interactive code
setopt interactivecomments

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# don't error out when unset parameters are used
setopt unset

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# import new commands from the history file also in other zsh-session
setopt share_history
# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups
# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace
# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup
# make cd push the old directory onto the directory stack.
#setopt auto_pushd
# avoid "beep"ing
setopt nobeep
# don't push the same dir twice.
setopt pushd_ignore_dups
# * shouldn't match dotfiles. ever.
setopt noglobdots

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

path+=("$HOME/.bin")
if [ -d $HOME/.yarn/bin ]; then
	path+=("$HOME/.yarn/bin")
fi
if [ -d $HOME//bin ]; then
	path+=("$HOME/bin")
fi
export PATH

if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
fi

export EDITOR=nvim
alias vi=nvim
alias vim=nvim
alias nmux="nvim -c terminal"
alias nve="nvr --remote"
alias nvt="nvr --remote-tab"
alias nvsh="nvr -c tabe\\|terminal"

source ~/.zgen/zgen.zsh
if ! zgen saved; then
	echo Creating zgen startup file

	# 256 colors??
	zgen load chrissicool/zsh-256color

	# async command execution, used by pure
	zgen load mafredri/zsh-async

	# custom theme
	zgen load sindresorhus/pure

	zgen load oknowton/zsh-dwim
	zgen load RobSis/zsh-reentry-hook
	zgen load denolfe/zsh-travis
	zgen load djui/alias-tips
	zgen load supercrabtree/k
	zgen load jreese/zsh-titles
	zgen load b4b4r07/enhancd
	zgen load b4b4r07/emoji-cli
	zgen load zsh-users/zsh-completions

	# programmin language version managers
	zgen load cswl/zsh-rbenv
	zgen load lukechilds/zsh-nvm
	zgen load twang817/zsh-gvm


	# command highlighting
	zgen load zsh-users/zsh-syntax-highlighting

	zgen save
fi

if [ -f $HOME/.localzshrc ]; then
	source $HOME/.localzshrc
fi
