sudo apt update
sudo apt upgrade

sudo apt install git
sudo apt install python3

sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt install google-chrome-stable

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install code


sudo add-apt-repository multiverse
sudo apt install steam

sudo apt install nvidia-driver-<版本>   ＃ for nv
sudo apt install mesa-vulkan-drivers\   ＃ for amd

＃ for proton 
sudo apt install vulkan-tools
sudo apt upgrade mesa*

