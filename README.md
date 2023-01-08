# Virtual Environment Creation

Bash scripts for creating a Python virtual environment with pyenv and venv.

## Pyenv

For installing [pyenv](https://github.com/pyenv/pyenv), run the following
command:

```{bash}
./install-pyenv.sh
```

This command will check if pyenv's code is already downloaded in your $HOME
directory, and if the [configuration](./config.txt) was added in .bashrc and
.profile (if exists) files.

If the code was not downloaded, the program will download it.
And if the configuration was not set, it will be.

## Venv

For creating a new virtual environment using 
[venv](https://docs.python.org/es/3/library/venv.html), run the following
command:

```{bash}
source ./create-venv.sh <python-version> [<requirements-file>]
```

If a virtual environment in a `venv` folder already exists, this command
will delete it and replace it with the new environment.

It's assumed that you have pyenv already installed in your computer.

For example:

```{bash}
source ./create-venv.sh 3.10.4
```

Requirements files are optional, and you can list as many requirements files
as you want.

After running the previous command, the environment will be activated. For
deactivating it, run:

```{bash}
deactivate
```
