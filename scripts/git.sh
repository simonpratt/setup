
workingDir=`pwd`

# Sym link .gitconfig
if [ -L ~/.gitconfig ]; then
  echo "[ok] .gitconfig"
elif [ -e ~/.gitconfig ]; then
  echo "[bad] .gitconfig exists!"

  rm ~/.gitconfig
  ln -s $workingDir/__config__/.gitconfig ~/.gitconfig
  echo "[ok] Created ~/.gitconfig sym link"
else
  ln -s $workingDir/__config__/.gitconfig ~/.gitconfig
  echo "[ok] Created ~/.gitconfig sym link"
fi

# Sym link diff-highlight dir
if [ -L ~/bin/diff-highlight ]; then
  echo "[ok] diff-highlight"
elif [ -e ~/bin/diff-highlight ]; then
  echo "[bad] diff-highlight exists!"
else
  ln -s $workingDir/__config__/diff-highlight ~/bin/diff-highlight
  chmod +x ~/bin/diff-highlight
  echo "[ok] Created diff-highlight sym link"
fi
