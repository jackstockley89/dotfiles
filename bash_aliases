# .bash_aliases

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

## go Aliases
alias kcu='./.kube_config_update'

## AWS Account Aliases
alias cplat='export AWS_CONFIG_FILE=~/.aws/cloud-platform/config; export AWS_SHARED_CREDENTIALS_FILE=~/.aws/cloud-platform/credentials; echo "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE}"; echo "AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE}"'
alias modplat='export AWS_CONFIG_FILE=~/.aws/mod-platform/config; echo "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE}"'
alias laaops='export AWS_CONFIG_FILE=~/.aws/laa-ops/config; echo "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE}"'

## Terraform Aliases
alias tf101='tfenv use 1.0.1; echo "Terraform Version: "; tfenv version-name'
alias tf155='tfenv use 0.15.5; echo "Terraform Version: "; tfenv version-name'
alias tf146='tfenv use 0.14.6; echo "Terraform Version: "; tfenv version-name'
alias tf135='tfenv use 0.13.5; echo "Terraform Version: "; tfenv version-name'

## Iterm2 Script Aliases
alias envcollect='bash ~/.environment-collection.bash'
alias launchenv='bash ~/.launch-laaops-env.bash'
alias launchlaaops='osascript ~/.launch-laaops-terminal.scpt'
alias launchmodplat='osascript ~/.launch-modplat-terminal.scpt'
alias pkgver='bash ~/.brew-version-check.bash'


## URL Aliases
alias urlgoogle='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/''
alias urlaws='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://aws.amazon.com/''

## Cloud Platform
alias urlcp='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform''
alias urlcpi='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform-infrastructure''
alias urlcpe='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform-environments''