# .bashrc

# Set Variables

export GOPATH="${HOME}/.go"
export REPO="${HOME}/repo"

## Kubectl auto complete
source <(kubectl completion bash)

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
alias modplat='export AWS_CONFIG_FILE=~/.aws/mod-platform/config; echo "AWS_CONFIG_FILE: "$AWS_CONFIG_FILE'
alias laaops='export AWS_CONFIG_FILE=~/.aws/laa-ops/config; echo "AWS_CONFIG_FIL: "$AWS_CONFIG_FILE'

## Terraform Aliases
alias tf101='tfenv use 1.0.1; echo "Terraform Version: "; tfenv version-name'
alias tf155='tfenv use 0.15.5; echo "Terraform Version: "; tfenv version-name'
alias tf146='tfenv use 0.14.6; echo "Terraform Version: "; tfenv version-name'
alias tf135='tfenv use 0.13.5; echo "Terraform Version: "; tfenv version-name'

## Iterm2 scripts
alias envcollect='bash ~/.environment-collection.bash'
alias launchenv='bash ~/.launch-laaops-env.bash'
alias launchlaaops='osascript ~/.launch-laaops-terminal.scpt'
alias launchmodplat='osascript ~/.launch-modplat-terminal.scpt'


## URL Aliases
alias urlgoogle='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/''
alias urlaws='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://aws.amazon.com/''
alias urlpui='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/laa-ccms-infra-pui''
alias urlsoa='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/laa-ccms-infra-soa''
alias urlebs='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/laa-ccms-infra-ebs''
alias urlopa='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/laa-ccms-infra-opa-hub''
alias urledrms='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/laa-ccms-infra-edrms''
alias urlshared='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/laa-ccms-shared''