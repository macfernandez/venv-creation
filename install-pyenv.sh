#!/bin/bash

PYENV_FOLDER="$HOME/.pyenv"
THIS_FOLDER=$( dirname $( realpath $0 ) )
CONFIG_PATH=$THIS_FOLDER/config.txt
CONFIG=$( cat $CONFIG_PATH ) 

function add_prefix() {
    # add config's paths to the beginning of a file
    local OUTPUT="$1-tmp"
    echo -e "$CONFIG\n" >> $OUTPUT
    cat $1 >> $OUTPUT
    mv $OUTPUT $1
    source $1
}

function add_suffix() {
    # add config's paths to the ending of a file
    echo -e "\n$CONFIG" >> $1
    source $1
}

function check_if_installed() {
    # check if pyenv is downloaded
    # if not, download it
    # check if paths were added to $HOME/.bashrc
    # check if paths were added to $HOME/.profile
    # check installation
    if [ ! -d "$PYENV_FOLDER" ];
    then
        echo "** Pyenv not installed. Starting installation..."
        install_dependencies
        clone_pyenv_code
    fi
    check_if_paths_added $HOME/.bashrc add_suffix
    check_if_paths_added $HOME/.profile add_prefix
    check_installation
}

function check_if_paths_added() {
    # check if config is set in file ($1)
    # if it's not set, set it with the passed function ($2)
    local FILE=$1
    local COMMAND=$2
    local PATTERN=$( echo $CONFIG )
    local MATCH=$( echo $( cat $FILE ) | grep -oc "$PATTERN" )
    if [ ! "$MATCH" -ge 1 ];
    then
        eval $COMMAND $FILE
        echo "** Paths added to $FILE"
    fi
}

function check_installation() {
    # check if pyenv is installed
    if command -v pyenv &> /dev/null
    then
        echo "** Peynv successfully installed."
    else
        echo "** Peynv could not be installed."
    fi
    exit
}

function clone_pyenv_code() {
    # clone pyenv's code
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv

}

function install_dependencies() {
    # install required dependencies
    sudo apt install curl git-core gcc make zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev libssl-dev \
    python3-tk python3-venv

    sudo apt-get install libffi-dev lzma liblzma-dev \
    libbz2-dev

}

check_if_installed
