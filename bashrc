# .bashrc

# Set Variables

export GOPATH="${HOME}/.go"
export REPO="${HOME}/repo"

## Kubectl auto complete
source <(kubectl completion bash)

## read aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## read function file
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi