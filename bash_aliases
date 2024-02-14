# .bash_aliases

# Aliases
## hub Aliases
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
alias dstart='open -a Docker'

## Commandline Aliases
alias lsh='ls -ltrh'
## grep Aliases

## laa cluster select Aliases
alias scc='~/./.select-cluster-config'

## Iterm2 Script Aliases
alias envcollect='bash ~/.environment-collection.bash'
alias launchenv='bash ~/.launch-laaops-env.bash'
alias pkgver='bash ~/.brew-version-check.bash'
alias cplive='osascript ~/.cloudplat-live.scpt'
alias cplivem='osascript ~/.cloudplat-live-m.scpt'
alias cplive2='osascript ~/.cloudplat-live-2.scpt'
alias cplive2m='osascript ~/.cloudplat-live-2-m.scpt'
alias cpmgr='osascript ~/.cloudplat-mgr.scpt'
alias cpmgrm='osascript ~/.cloudplat-mgr-m.scpt'
alias cptest='osascript ~/.cloudplat-test.scpt'
alias cptestm='osascript ~/.cloudplat-test-m.scpt'

## URL Aliases
alias urlgoogle='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/''
alias urlaws='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://aws.amazon.com/''

## Cloud Platform
alias urlcp='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform''
alias urlcpi='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform-infrastructure''
alias urlcpe='/usr/bin/open -a "/Applications/Google Chrome.app" 'https://github.com/ministryofjustice/cloud-platform-environments''

## kubectl Aliases
alias k=kubectl

## reposiory Aliases
alias cprepo='cd ~/repo/cloud-platform'
alias jsrepo='cd ~/repo/jackstockley89'

## confing
alias authlive='cat ~/.properties/live-auth.txt'
alias authethm='cat ~/.properties/ethm-auth.txt'
