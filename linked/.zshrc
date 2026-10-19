# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------ PATH --------------------

# Keep PATH free of duplicates (first occurrence wins).
typeset -U path PATH

# Homebrew: Apple Silicon installs to /opt/homebrew, Intel to /usr/local.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export GOPATH="$HOME/go"
export PY_USER_BASE="$HOME/Library/Python/3.11"

# Your own bins first, then the system/Homebrew PATH, then Python user scripts.
path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/scripts/bin
  $GOPATH/bin
  $path
  $PY_USER_BASE/bin
)

# ------------ oh-my-zsh --------------------

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Must be set before oh-my-zsh.sh is sourced.
# Show an update reminder (non-blocking) every 7 days; run `omz update` to update.
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

# Autocomplete settings
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Too many plugins slow down shell startup.
# zsh-syntax-highlighting must be the last plugin loaded.
plugins=(postgres git colored-man-pages history zsh-autosuggestions)
command -v kubectl &>/dev/null && plugins+=(kubectl)
plugins+=(zsh-syntax-highlighting)

# oh-my-zsh runs compinit itself, so no separate compinit call is needed.
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
setopt HIST_IGNORE_ALL_DUPS

# ------------ end oh-my-zsh --------------------

# generic aliases
alias lsn='find . -cmin -30'
alias myip='curl https://ipinfo.io/ip'
alias ak='ack'
alias ack-grep='ack'
alias get_dns="grep AAAA ~/mywork/dnszones/netspot.com.au | grep -v ';' | sort -nd"
alias get_hosts="cat ~/hosts/all-hosts.dyn"
alias updatedb='sudo gupdatedb'
alias dlt="find ~/Downloads -type f -newermt '2 day ago' -print0 | xargs -0 ls -oAHd"

# docker: remove dangling (<none>) images
alias dc='docker image prune -f'

# postgres
alias psql='PAGER="less -SF" psql'

# kubernetes (completion comes from the kubectl oh-my-zsh plugin)
if command -v kubectl &>/dev/null; then
  alias ku="kubectl"
  alias kup="kubectl get pods -o wide"
  alias kua="kubectl get all --all-namespaces"
fi

# python
alias py='python3'
export PIPENV_VENV_IN_PROJECT=true

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -r ~/.zsh.config ]] && . ~/.zsh.config

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh