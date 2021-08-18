echo "Running Setup"

set -e

currentUser=`logname`
currentHome=`eval echo ~$currentUser`
currentDirectory=`pwd`

# create home bin dir
if [ -d $currentHome/bin ]; then
  echo "[ok] bin exists"
else
  echo "[ok] creating bin!"
  mkdir $currentHome/bin
fi

echo ""

read -p "setup zsh? [y/n]: " setup_zsh
read -p "setup git? [y/n]: " setup_git

if [ "$setup_zsh" == "y" ]; then
    echo "installing up zsh"
    bash ./scripts/zsh.sh
fi

if [ "$setup_git" == "y" ]; then
    echo "setting up git"
    bash ./scripts/git.sh
fi
