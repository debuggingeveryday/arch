#!/bin/sh
 #reference from --https://dev.to/prakhil_tp/add-font-ligatures-to-your-alacritty-2fld--

alacritty_legasture () {
  # update ligature alacritty
  git clone https://github.com/zenixls2/alacritty $HOME/alacritty &&
  cd $HOME/alacritty && 
  git checkout ligature && 
  cargo build --release &&
  sudo mv /usr/bin/alacritty /usr/bin/alacritty.bak &&
  sudo cp $HOME/alacritty/target/release/alacritty /usr/bin &&

  cp $HOME/.config/alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml.bak &&
  cp -f $HOME/window-manager/files_config/alacritty.yml $HOME/.config/alacritty/alacritty.yml
}