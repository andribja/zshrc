
# Autoload zsh modules when they are referenced
zmodload -a zsh/zpty zpty

# Autoload functions
autoload compinit && compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=vim
export PATH=$HOME/bin:$PATH

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Incrementally add to history
export HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt inc_append_history
setopt share_history

# History search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Autocompletion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion, history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Function path
fpath=(~/.zsh-fns $fpath)

# Autoload zsh modules when they are referenced
zmodload -a zsh/zpty zpty

# Autoload functions
autoload compinit && compinit
# Autocompletion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# g4d autocomplete
source /etc/bash_completion.d/g4d
# blaze autocomplete
fpath=(/google/src/files/head/depot/google3/devtools/blaze/scripts/zsh_completion $fpath)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# fig status
source ~/.zsh/fig_status/fig_prompt

# Template Arguments:
#   FIG_PROMPT_MODIFIED: Replaced with $modified
#   FIG_PROMPT_ADDED: Replaced with $added
#   FIG_PROMPT_DELETED: Replaced with $deleted
#   FIG_PROMPT_UNKNOWN: Replaced with $unknown
#   FIG_PROMPT_UNEXPORTED: Replaced with $unexported
#   FIG_PROMPT_OBSOLETE: Replaced with $obsolete
#   FIG_PROMPT_CL: Replaced with $cl
#   FIG_PROMPT_DESCRIPTION: Replaced with $description
#   FIG_PROMPT_CHANGENAME: Replaced with $changename
#   FIG_PROMPT_HAS_SHELVE: Replaced with $has_shelve
function get_fig_prompt_template() {
  echo -n '%F{yellow}FIG_PROMPT_MODIFIED %F{green}FIG_PROMPT_ADDED'
  echo -n ' %F{red}FIG_PROMPT_DELETED %F{magenta}FIG_PROMPT_UNKNOWN'
  echo -n ' %F{magenta}FIG_PROMPT_HAS_SHELVE %F{white}FIG_PROMPT_DESCRIPTION '
  echo -n ' %F{blue}FIG_PROMPT_UNEXPORTED %F{red}FIG_PROMPT_OBSOLETE'
  echo -n ' %F{white}FIG_PROMPT_CL'
}

export EDITOR='nvim'

# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
function update-x11-forwarding
{
    if [ -z "$STY" -a -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        export DISPLAY=`cat ~/.display.txt`
    fi
}

# This is run before every command.
preexec() {
    # Don't cause a preexec for PROMPT_COMMAND.
    # Beware!  This fails if PROMPT_COMMAND is a string containing more than one command.
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return

    update-x11-forwarding

    # Debugging.
    # echo DISPLAY = $DISPLAY, display.txt = `cat ~/.display.txt`, STY = $STY, TMUX = $TMUX
}
trap 'preexec' DEBUG

# Fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/term-title.plugin.zsh

# Configure bash history to work w/ tmux
## After each command, save and reload history
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Alias to run curio
alias curio=/google/bin/releases/secmon-tools/curio/curio
export OMEN_DIR=security/detection/pipeline/omen
export CURIO_DIR=ops/security/curio
export CURIUM_DIR=security/curium

# buildfix
alias buildfix='/google/data/ro/teams/ads-integrity/buildfix'

# Default GFS user + aliases
export GFS_USER="secmon-logs"
alias gqui="gqui --gfs_user=$GFS_USER"
alias fu="fileutil --gfs_user=$GFS_USER"
alias dremel="dremel --gfs_user=$GFS_USER"
export HEAD="/google/src/head/depot/google3"
export EXP="experimental/users/andrib"
export LOGS_DIR="/usr/local/google/tmp"

alias wm_cell_manager=/google/bin/releases/streaming-flume/tools/cell_manager
alias iwyu=/google/src/files/head/depot/google3/devtools/maintenance/include_what_you_use/iwyu.py
alias iwyu-cl=$HOME/scripts/iwyu-cl.bash
alias gst=/google/bin/releases/scaffolding/template_gen/gen_scaffolding_templates.par
alias omen=/google/bin/releases/detection-pipeline/omen/omen
alias omen-dev="/google/bin/releases/detection-pipeline/omen/omen --environment=dev"

source /etc/bash_completion.d/hgd

