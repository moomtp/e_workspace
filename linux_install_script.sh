sudo apt update
sudo apt upgrade
sudo apt install snapd

＃ gen ssh key on /.ssh
ssh-keygen -t ed25519 
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519


sudo apt install git
sudo apt install python3

sudo snap install chromium

# 安裝vscode
sudo snap install code --classic
# 用command 安裝vscode擴充, Ctrl+Shift+P，输入 Shell Command: Install 'code' command in PATH
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools


sudo snap install discord # 安裝dis

# 安裝steam
sudo add-apt-repository multiverse
sudo apt install steam


＃ 安裝注音
sudo apt install ibus ibus-chewing
ibus-setup

＃ 升級ubuntu
sudo do-release-upgrade -d

sudo apt install nvidia-driver-<版本>   ＃ for nv
sudo apt install mesa-vulkan-drivers\   ＃ for amd

＃ for proton 
sudo apt install vulkan-tools
sudo apt upgrade mesa*

