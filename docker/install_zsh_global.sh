DIST_NAME=`awk -F= '/^ID=/{print $2}' /etc/*-release | sed 's/\"//g'`
echo "OS Distro: $DIST_NAME"

case "$DIST_NAME" in
  "ubuntu") pkgmgr="apt-get" ;;
  "centos") pkgmgr="yum" ;;
esac


# Install ZSH
#$pkgmgr install zsh -y
chsh -s /bin/zsh #"$(which zsh)"

#$pkgmgr install dconf-cli uuid-runtime

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Fonts
cd ~/
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf ./fonts

# Pydemia-theme
git clone https://github.com/pydemia/pydemia-theme ~/pydemia-theme
cp ./pydemia-theme/zsh/.oh-my-zsh/themes/cobalt2-pydemia.zsh-theme ~/.oh-my-zsh/themes/
cp -r ./pydemia-theme/zsh/.pydemia-config ~/
echo "source ~/.pydemia-config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
#echo "source .pydemia-theme/.pydemia-config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

sed -i 's/^ZSH_THEME*/#&/' ~/.zshrc
cat ./pydemia-theme/zsh/.zshrc >> ~/.zshrc

rm -rf ./pydemia-theme