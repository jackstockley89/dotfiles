# .bash_aliases

# Aliases
## hub Aliases
alias hubpr='hub pull-request'
alias hubi='hub issue'

## git Aliases
alias gitc='git cz commit'
alias gitcl='git clone'
alias gits='git status'
alias gita='git add'
alias gitph='git push'
alias gitphf='git push --force-with-lease'
alias gitpl='git pull'

## docker Aliases
alias dcrc='docker-compose down; docker-compose up --build -d'

## Commandline Aliases
alias lsh='ls -ltrh'
## grep Aliases

## laa cluster select Aliases
alias scc='~/./.select-cluster-config'

## AWS Account Aliases
alias modplat='export AWS_CONFIG_FILE=~/.aws/mod-platform/config; echo "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE}"'
alias laaops='export AWS_CONFIG_FILE=~/.aws/laa-ops/config; echo "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE}"'
## Iterm2 Script Aliases
alias envcollect='bash ~/.environment-collection.bash'
alias launchenv='bash ~/.launch-laaops-env.bash'
alias pkgver='bash ~/.brew-version-check.bash'
alias cplive='osascript ~/.cloudplat-live.scpt'
alias cpmgr='osascript ~/.cloudplat-mgr.scpt'
alias cptest='osascript ~/.cloudplat-test.scpt'

## URL Aliases
alias urlgoogle='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/''
alias urlaws='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://aws.amazon.com/''

## Cloud Platform
alias urlcp='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform''
alias urlcpi='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform-infrastructure''
alias urlcpe='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform-environments''

## kubectl Aliases
alias k=kubectl