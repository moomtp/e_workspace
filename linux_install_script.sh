sudo apt update
sudo apt upgrade
sudo apt install snapd

apt install vim
sudo snap install nvim --classic
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

apt install zsh -y
chsh -s $(zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# powerlevel10k主题
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# zsh-autosuggestions自动提示插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting语法高亮插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# 更改zshrc文件
vim ~/.zshrc
```.zshrc
# 修改主题
ZSH_THEME="powerlevel10k/powerlevel10k"

# 启用插件
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```
zsh

p10k configure # 重新配置p10k

＃ gen ssh key on /.ssh
ssh-keygen -t ed25519 
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519


sudo apt install git
git config --global core.editor "vim"
sudo apt install python3
sudo apt install python3-pip

sudo snap install chromium

snap install obsidian --classic

# 安裝vscode
sudo snap install code --classic
# 用command 安裝vscode擴充, Ctrl+Shift+P，输入 Shell Command: Install 'code' command in PATH
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension GitHub.vscode-pull-request-github
code --install-extension vscodevim.vim
code --install-extension yzhang.markdown-all-in-one
code --install-extension shd101wyy.markdown-preview-enhanced

sudo snap install discord # 安裝dis

# 安裝steam
sudo add-apt-repository multiverse
sudo apt install steam


＃ 安裝注音
sudo apt install ibus ibus-chewing
ibus-setup

＃ 升級ubuntu
sudo do-release-upgrade -d

sudo apt install nvidia-driver-<版本>   ＃ for
sudo apt install mesa-vulkan-drivers\   ＃ for amd

＃ for proton 
sudo apt install vulkan-tools
sudo apt upgrade mesa*

