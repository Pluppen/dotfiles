########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
dotfiles="zshrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Making symboliclink of $file to ~"
    ln -s $dir/$file ~/.$file
done

# move neovim config
echo "Moving old neovim config from ~/.config to $olddir"
mv -v ~/.config/nvim/* $olddir
echo "Creating symbol link to ~"
ln -s "$dir/nvim/init.vim" ~/.config/nvim/init.vim

