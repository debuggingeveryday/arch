#!/bin/sh
 #reference from --https://dev.to/prakhil_tp/add-font-ligatures-to-your-alacritty-2fld--

alacritty_legasture () {
  # update ligature alacritty
  # git clone --single-branch --branch <branchname> <remote-repo>
  git clone --single-branch --branch ligasture https://github.com/zenixls2/alacritty  $DUMP_FILES_PATH/alacritty &&
  cd $DUMP_FILES_PATH/alacritty &&  
  cargo build --release &&
  sudo mv /usr/bin/alacritty /usr/bin/alacritty.bak &&
  sudo cp $DUMP_FILES_PATH/alacritty/target/release/alacritty /usr/bin &&

  cp $DUMP_FILES_PATH/.config/alacritty/alacritty.toml $DUMP_FILES_PATH/.config/alacritty/alacritty.toml.bak &&
  cp -f $DUMP_FILES_PATH/window-manager/files_config/alacritty.yml $DUMP_FILES_PATH/.config/alacritty/alacritty.yml
}