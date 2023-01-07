# Virtual Environment Creation

Bash scripts for creating a Python virtual environment with pyenv and venv.

## Pyenv

For installing [pyenv](https://github.com/pyenv/pyenv), run the following
command:

```{bash}
./install-pyenv.sh
```

This command will check if pyenv's code is already downloaded in your $HOME
directory.

- If it's already downloaded, the program asusmes you have already
installed pyenv, and made the proper modifications for its paths.

- If pyenv's code is not downloaded, it will be. Then, all necesary modifications
will be made in .bashrc (and .profile, if exists) for enabling pyenv's usage.

## Venv

For creating a new virtual environment using 
[venv](https://docs.python.org/es/3/library/venv.html), run the following
command:

```{bash}
source ./create-venv.sh <python-version> [<requirements-file>]
```

If a virtual environment in a `venv` folder already exists, this command
will delete it and replace it with the new environment.

This command assumes that you have pyenv already installed in your computer.

For example:

```{bash}
source ./create-venv.sh 3.10.4
```

Requirements files are optional, and you can list as many requirements files
as you want.