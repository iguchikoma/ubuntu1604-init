#!/bin/bash

# screen
git clone https://github.com/iguchikoma/screen.git ~/screen
mv ~/screen/.screen* ~/
rm -rf ~/screen

# git
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
mv git-completion.bash ~/.git-completion.bash
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh ~/.git-prompt.sh
git config --global user.email "iguchi.t@gmail.com"
git config --global user.name "Takashi Iguchi"
cat <<'EOF' >>~/.bashrc

# git config
. ~/.git-completion.bash
. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
EOF
 

# ls color
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal
mv dircolors.ansi-universal ~/.dircolors

cat <<'EOF' >>~/.bashrc

# ls color config (add here)
if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    fi
fi
EOF


# sudo
sudo sh -c 'echo 127.0.1.1 $(hostname) >> /etc/hosts'


# .bash_profile
touch ~/.bash_profile
cat <<'EOF' >>~/.bash_profile

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
EOF



# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

cat <<'EOF' >>~/.bash_profile

# pyenv init
# ref: https://github.com/pyenv/pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
 
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
EOF


# source .bash_profile
source ~/.bash_profile


# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

cat <<'EOF' >>~/.bash_profile

# pyenv-virtualenv init
# ref: https://github.com/pyenv/pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
EOF

source ~/.bashrc
source ~/.bash_profile
