# .bashrc

# Set Variables

export GOPATH="${HOME}/.go"
export REPO="${HOME}/repo"

## Kubectl auto complete
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source <(kubectl completion bash)

## read aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## read function file
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

## read function file
if [ -f ~/.env_address ]; then
    . ~/.env_address
fi
