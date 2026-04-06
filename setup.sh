export DOTFILES=$(pwd)

function homebrew_install {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
    brew bundle install --file=$DOTFILES/Brewfiles/Brewfile
    echo "Homebrew installed, updated and so are your Casks and Cellars."
} 

function setup_function {
    echo "Do you want to install Homebrew ? [Y/n] "
    read yn
    case $yn in
        ([Yy]*) homebrew_install ;;
        ([Nn]*) continue ;;
    esac
    mkdir ~/Developer
    ln -s $DOTFILES/zsh $HOME/.zsh
    ln -s $DOTFILES/vimrc $HOME/.vimrc
    ln -s $HOME/.zsh/.zshrc $HOME/.zshrc
}

function setup {
    echo "Do you want to setup dotfiles ? [Y/n] "
    read yn
    case $yn in
        ([Yy]*) setup_function ;;
        ([Nn]*) continue ;;
    esac
    echo "Setup done. Welcome back."
} 
