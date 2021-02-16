# .bashrc

# Set Variables

export GOPATH="${HOME}/.go"
export REPO="${HOME}/repo"

# Aliases
## hub Aliases
alias hubpr='hub pull-request'
alias hubi='hub issue'

## git Aliases
alias gitc='git commit'
alias gitcl='git clone'
alias gits='git status'
alias gita='git add'
alias gitph='git push'
alias gitphf='git push --force-with-lease'
alias gitpl='git pull'

## docker Aliases
alias dcrc='docker-compose down; docker-compose up --build -d'

## list Aliases
alias lsh='ls -ltrh'

## grep Aliases

## AWS Aliases
alias modplat='export AWS_CONFIG_FILE=~/.aws/mod-platform/config'
alias laaops='export AWS_CONFIG_FILE=~/.aws/laa-ops/config'
