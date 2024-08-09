mkdir -p $HOME/AppData/Local/nvim
mkdir -p $HOME/Documents\PowerShell
#New-Item -ItemType SymbolicLink -Path "$HOME/AppData/Local/nvim/init.vim" -Target "$HOME/dotfiles/home/vimrc"
#New-Item -ItemType SymbolicLink -Path "$HOME/.gitconfig" -Target "$HOME/dotfiles/home/gitconfig"
cp Microsoft.PowerShell_profile.ps1 $profile
cp $HOME/dotfiles/home/vimrc $HOME/AppData/Local/nvim/init.vim
cp $HOME/dotfiles/home/gitconfig $HOME/.gitconfig

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
