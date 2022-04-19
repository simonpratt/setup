
workingDir=`pwd`

# Sym link kitty config
if [ -L ~/.config/kitty/kitty.conf ]; then
  echo "[ok] kitty.conf"
elif [ -e ~/.config/kitty/kitty.conf ]; then
  echo "[bad] .config/kitty/kitty.conf exists!"

  rm ~/.config/kitty/kitty.conf
  ln -s $workingDir/linked/kitty.conf ~/.config/kitty/kitty.conf
  echo "[ok] Created ~/.config/kitty/kitty.conf sym link"
else
  ln -s $workingDir/linked/kitty.conf ~/.config/kitty/kitty.conf
  echo "[ok] Created ~/.config/kitty/kitty.conf sym link"
fi
