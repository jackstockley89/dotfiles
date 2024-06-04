
# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave

source ~/.bashrc

PATH="/opt/homebrew/:/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH


complete -C /usr/local/Cellar/tfenv/3.0.0/versions/1.2.6/terraform terraform
