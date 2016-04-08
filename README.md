# vim-conf

Configure my vim.
* Copy cc2 file to your /home/USER/.vimrc file (Only if you don't have a .vimrc already.  If you do, look at the cc2 file and just add the plugins and NeoBundle content at top).
* Run shell code
```sh
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
```
* For Linux,  a prompt should occur when you open vim to install neobundle and any defined bundles in your .vimrc.
* Modify the .vimrc file to replace USER with your username.
* Navigate to your ~/.vim/bundle/YouCompleteMe directory and run :  $  ./install.sh --clang-completer
