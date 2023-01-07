#!/bin/bash

ARGS=($@)
PYTHON_VERSION="${ARGS[0]}"
REQUIREMENTS=(${ARGS[@]:1})

function create_n_activate_venv() {
    python -m venv venv
    source venv/bin/activate
}

function delete_old_venv() {
    local VENV="venv"
    if [ -d "$VENV" ]; then
        rm -r $VENV
        echo "** Older environment found and deleted."
fi
}

function install_python_version() {
    pyenv install -s $1
}

function install_requirements() {
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
    pyenv local $1
}

install_python_version $PYTHON_VERSION
select_python $1
create_n_activate_venv
install_requirements ${REQUIREMENTS[@]}
