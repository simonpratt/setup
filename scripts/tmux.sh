
workingDir=`pwd`

# Sym link .tmux.conf
if [ -L ~/.tmux.conf ]; then
  echo "[ok] .tmux.conf"
elif [ -e ~/.tmux.conf ]; then
  echo "[bad] .tmux.conf exists!"

  rm ~/.tmux.conf
  ln -s $workingDir/linked/.tmux.conf ~/.tmux.conf
  echo "[ok] Created ~/.tmux.conf sym link"
else
  ln -s $workingDir/linked/.tmux.conf ~/.tmux.conf
  echo "[ok] Created ~/.tmux.conf sym link"
fi

# Clone TPM
if [ -d ~/.tmux/plugins/tpm ]; then
  echo '[ok] tpm exists'
  (cd ~/.tmux/plugins/tpm; git pull;)

  echo ""
  echo "!!! Remember to open tmux and press 'prefix + I' to install new plugins"
else
  echo "[bad] creating folder!"
  mkdir -p ~/.tmux/plugins;
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
  (cd ~/.tmux/plugins/tpm; git pull;)

  echo ""
  echo "!!! Remember to open tmux and press 'prefix + I' to install new plugins"
fi
