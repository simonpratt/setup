#!/bin/bash
set -e

workingDir=`pwd`
distro=`uname -s`

homedir=~
eval homedir=$homedir

## Check that zsh is installed
if command -v zsh >/dev/null 2>&1; then
    echo '[ok] zsh is installed'
else
    echo "[bad] zsh is not installed"
    exit 1
fi

## setup zsh now ---
zsh_custom=$homedir/.oh-my-zsh/custom;

if [ -d "$homedir/.oh-my-zsh" ]; then
    echo '[ok] .oh-my-zsh'
else
    echo '[bad] oh-my-zsh is not installed. See https://ohmyz.sh/#install'
    exit 1
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ -d $zsh_custom/plugins/zsh-autosuggestions ]; then
  echo '[ok] zsh-autosuggestions exists'
  (cd $zsh_custom/plugins/zsh-autosuggestions; git pull;)
else
  mkdir -p $zsh_custom/plugins/zsh-autosuggestions;
  echo "[bad] creating folder!"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions";
  (cd $zsh_custom/plugins/zsh-autosuggestions; git pull;)
fi

# ## copy themes over and clone
if [ -d $zsh_custom/themes/powerlevel10k ]; then
  echo '[ok] powerlevel10k exists'
  (cd $zsh_custom/themes/powerlevel10k; git pull;)
else
  mkdir -p $zsh_custom/themes/powerlevel10k;
  echo "[bad] creating folder!"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $zsh_custom/themes/powerlevel10k
  (cd $zsh_custom/themes/powerlevel10k; git pull;)
fi

# Sym link .zshrc
if [ -L ~/.zshrc ]; then
  echo "[ok] .zshrc"
elif [ -e ~/.zshrc ]; then
  mv ~/.zshrc ~/.zshrc.old
  echo "[ok] Moved existing .zshrc to .zshrc.old"
  
  ln -s $workingDir/linked/.zshrc ~/.zshrc
  echo "[ok] Created ~/.zshrc sym link"
else
  ln -s $workingDir/linked/.zshrc ~/.zshrc
  echo "[ok] Created ~/.zshrc sym link"
fi

# Sym link .p10k.zsh
if [ -L ~/.p10k.zsh ]; then
  echo "[ok] .p10k.zsh"
elif [ -e ~/.p10k.zsh ]; then
  mv ~/.p10k.zsh ~/.p10k.zsh.old
  echo "[ok] Moved existing .p10k.zsh to .p10k.zsh.old"
  
  ln -s $workingDir/linked/.p10k.zsh ~/.p10k.zsh
  echo "[ok] Created ~/.p10k.zsh sym link"
else
  ln -s $workingDir/linked/.p10k.zsh ~/.p10k.zsh
  echo "[ok] Created ~/.p10k.zsh sym link"
fi

# Sym link custom zsh commands
if [ -L ~/.zsh.config ]; then
  echo "[ok] .zsh.config"
elif [ -e ~/.zsh.config ]; then
  echo "[bad] .zsh.config exists!"

  rm ~/.zsh.config
  ln -s $workingDir/linked/.zsh.config ~/.zsh.config
  echo "[ok] Created ~/.zsh.config sym link"
else
  ln -s $workingDir/linked/.zsh.config ~/.zsh.config
  echo "[ok] Created ~/.zsh.config sym link"
fi

# Append to .zshrc
if grep '.zsh.config' ~/.zshrc
then
  echo '[ok] .zshrc'
else
  # Append rather than replace
  echo '. ~/.zsh.config' >> ~/.zshrc
  echo 'Appended to .zshrc'
fi

# done
