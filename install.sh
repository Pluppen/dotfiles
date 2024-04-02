#!/bin/bash

cat << "EOF"
                                 ,        ,
                                /(        )`
                                \ \___   / |
                                /- _  `-/  '
                               (/\/ \ \   /\
                               / /   | `    \
                               O O   ) /    |
                               `-^--'`<     '
                   TM         (_.)  _  )   /
|  | |\  | ~|~ \ /             `.___/`    /
|  | | \ |  |   X                `-----' /
`__| |  \| _|_ / \  <----.     __ / __   \
                    <----|====O)))==) \) /====
                    <----'    `--' `.__,' \
                                 |        |
                                  \       /
                             ______( (_  / \______
                           ,'  ,-----'   |        \
                           `--{__________)        \/

 ____       _   _   _                           
/ ___|  ___| |_| |_(_)_ __   __ _   _   _ _ __  
\___ \ / _ \ __| __| | '_ \ / _` | | | | | '_ \ 
 ___) |  __/ |_| |_| | | | | (_| | | |_| | |_) |
|____/ \___|\__|\__|_|_| |_|\__, |  \__,_| .__/ 
 ___ _   _ ___| |_ ___ _ __ |___/        |_|    
/ __| | | / __| __/ _ \ '_ ` _ \                
\__ \ |_| \__ \ ||  __/ | | | | |               
|___/\__, |___/\__\___|_| |_| |_|               
     |___/                                      

EOF


logger() {
    echo "[+] $1"
}

logger "Running update of system"
sudo dnf update -qy

logger "Installing kitty"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n
cp -r ./.config/kitty ~/.config/kitty

logger "Installing zsh"
sudo dnf install zsh -qy

cp ./.zshrc ~/.zshrc

logger "Installing oh-my-zsh"
sh -c "$(curl --silent -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

logger "Installing zsh-syntax-highlightning"
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

logger "Installing zsh-autosuggestions"
git clone -q https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

logger "Installing nvm, node, and npm"
curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts
nvm use --lts

logger "Installing python3.8"
sudo dnf install python3.8 -qy

logger "Installing dotnet"
sudo dnf install dotnet-sdk-8.0 -qy

logger "Installing pwsh"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
curl --silent https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/ym.repos.d/microsoft.repo
sudo dnf update -qy
sudo dnf install powershell -qy

logger "Installing az cli"
sudo dnf install -qy azure-cli

logger "Installing neovim and setting upp config"
sudo dnf install -qy neovim python3-neovim

cp -r ./.config/nvim ~/.config/nvim

logger "Installing 1password"
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install 1password -qy

logger "Printing store apps to download"
echo "You should now install virtmanager"
echo "You should now install teams-for-linux"
echo "You should now install spotify"
