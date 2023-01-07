PYENV_FOLDER="$HOME/.pyenv"

CONFIG='''# pyenv configs
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi'''

function add_prefix() {
    OUTPUT="$1-tmp"
    echo -e "$CONFIG\n" >> $OUTPUT
    cat $1 >> $OUTPUT
    mv $OUTPUT $1
    source $1
}

function add_suffix() {
    echo -e "\n$CONFIG" >> $1
    source $1
}

function check_if_installed() {
    if [ -d "$PYENV_FOLDER" ];
    then
        echo "** Pyenv already installed."
    else
        echo "** Pyenv not installed. Starting installation..."
        install_dependencies
        clone_pyenv_code
        add_suffix $HOME/.bashrc
        add_prefix $HOME/.profile
        check_installation
    fi
}

function check_installation() {
    if command -v pyenv &> /dev/null
    then
        echo "** Peynv successfully installed."
    else
        echo "** Peynv could not be installed."
    fi
    exit
}

function clone_pyenv_code() {
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
}

function install_dependencies() {
    sudo apt install curl git-core gcc make zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev libssl-dev

    sudo apt-get install libffi-dev
}

check_if_installed