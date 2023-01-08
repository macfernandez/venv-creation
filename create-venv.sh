#!/bin/bash

ARGS=($@)
PYTHON_VERSION="${ARGS[0]}"
REQUIREMENTS=(${ARGS[@]:1})

function create_n_activate_venv() {
    # create venv and activate it
    python -m venv venv
    source venv/bin/activate
}

function delete_old_venv() {
    # delete older venv if it exists
    local VENV="venv"
    if [ -d "$VENV" ]; then
        rm -r $VENV
        echo "** Older environment found and deleted."
fi
}

function install_python_version() {
    # install python version in pyenv
    pyenv install -s $PYTHON_VERSION
}

function install_requirements() {
    # install requirements (specified with files)
    local REQS=($@)
    pip install --upgrade pip
    for REQ in ${REQS[@]}
    do
        if [ -f $REQ ];
        then
            pip install -r $REQ
        fi
    done
}

function select_python() {
    # select python version
    pyenv local $PYTHON_VERSION
}

install_python_version
select_python
create_n_activate_venv
install_requirements ${REQUIREMENTS[@]}
