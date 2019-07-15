# Get Argument
for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            LOCALE)              LOCALE=${VALUE} ;;
            *)   
    esac    
done


# Get Linux Distribution
DIST_NAME=`awk -F= '/^ID=/{print $2}' /etc/*-release | sed 's/\"//g'`
echo "OS Distro: $DIST_NAME"

case "$DIST_NAME" in
  "ubuntu") pkgmgr="apt-get" ;;
  "centos") pkgmgr="yum" ;;
esac

# Install Dev Tools
if [ "$DIST_NAME" = "ubuntu" ]; then
  sed -i 's/^override*/#&/' /etc/yum.conf
fi

$pkgmgr update -y
$pkgmgr install vim zsh curl wget git man -y
if [ "$DIST_NAME" = "ubuntu" ]; then
  $pkgmgr install build-essential -y
elif [ "$DIST_NAME" = "centos" ]; then
  $pkgmgr group mark install "Development Tools"
  $pkgmgr group update "Development Tools"
  $pkgmgr groupinstall -y 'development tools'
  $pkgmgr install sudo -y
fi


# Set Locales
# LOCALE=ko_KR
if [ "$DIST_NAME" = "ubuntu" ]; then
  $pkgmgr install locales -y
  echo "LANG=$LOCALE.UTF-8"
  locale-gen $LOCALE.UTF-8
  update-locale LANG=$LOCALE.UTF-8 LC_ALL=$LOCALE.UTF-8; echo "$(locale)"
  #export LANG=$LOCALE.UTF-8; echo "$(locale)"
  #export LC_ALL=$LOCALE.UTF-8; echo $LC_ALL


  ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
elif [ "$DIST_NAME" = "centos" ]; then
  sed -i 's/^override*/#&/' /etc/yum.conf
  echo "LANG=$LOCALE.utf8" > /etc/locale.conf
  $pkgmgr reinstall glibc-common glibc -y

  localedef -f UTF-8 -i $LOCALE $LOCALE.utf8
  echo "RUN LANG"
  export LANG=$LOCALE.utf8; echo "$(locale)"
  export LC_ALL=$LOCALE.utf8; echo $LC_ALL

  ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

fi

# Install sudo
$pkgmgr install sudo -y

# # Set Default User: pydemia
USERNAME="pydemia"
echo "Set Default User: $USERNAME"

if [ "$DIST_NAME" = "ubuntu" ]; then
  adduser --quiet --disabled-password $USERNAME \
  && echo "$USERNAME:ubuntu" | chpasswd
  usermod -aG sudo $USERNAME

elif [ "$DIST_NAME" = "centos" ]; then
  adduser $USERNAME --password "centos"
  usermod -aG wheel $USERNAME # wheel: sudo privileges.
  echo "pydemia ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pydemia && \
  chmod -R 0440 /etc/sudoers.d
fi

echo "Setting Finished."
