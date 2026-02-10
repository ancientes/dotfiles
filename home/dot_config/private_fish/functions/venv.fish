function venv --description 'Create virtualenv named the same as current directory'
    argparse --ignore-unknown --name=venv h/help v/version r/remove -- $argv || return
    set -l python_bin
    set -l global_ver
    set -l venv_name (basename $PWD | tr . -)
    set -l version_venv '1.3.2'

    if not test -d "$HOME/.local/share/virtualenvs/"
        mkdir -p "$HOME/.local/share/virtualenvs/"
    end
    if set --query _flag_help
        __venv_help
    else if set --query _flag_version
        echo venv $version_venv
    else if set --query _flag_remove
        if ! [ -d "$HOME/.local/share/virtualenvs/$venv_name" ] # Returns true if FILE is a directory.
            echo (set_color --bold red)✘(set_color normal)(set_color yellow) $HOME/.local/share/virtualenvs/$venv_name:(set_color --bold white) No such file or directory...(set_color normal)
        else
            echo (set_color --bold white) Removing virtualenv (set_color normal)(set_color green)\($HOME/.local/share/virtualenvs/$venv_name\)...
            if test -n "$VIRTUAL_ENV"
                deactivate
            end
            command rm -rf $HOME/.local/share/virtualenvs/$venv_name
        end
    else if not set --query argv[1]
        set python_bin (asdf which python)
        set global_ver (string trim (string sub -s 15 -l 15 (asdf current python)))

        if not test -d "$HOME/.local/share/virtualenvs/$venv_name" # Returns true if FILE is a directory.
            echo (set_color --bold white) Creating a virtualenv for \'$venv_name\' project... (set_color normal)
            echo (set_color white) Fishenv:(set_color --bold yellow) $HOME/.local/share/virtualenvs/$venv_name (set_color normal)
            echo (set_color --bold white) Using (set_color --bold yellow) $HOME/.local/share/asdf/installs/python/$global_ver/bin/python (set_color normal)(set_color green)\($global_ver\)(set_color --bold white) to create virtualenv...(set_color normal)

            # python -m calls the venv module as a script and passes the venv folder name as an argument to that script.
            $python_bin -m venv $HOME/.local/share/virtualenvs/$venv_name && echo
            echo (set_color --bold green) ✔(set_color normal)(set_color white) Successfully created virtual environment! (set_color normal)
            echo (set_color green) Virtualenv location: $HOME/.local/share/virtualenvs/$venv_name (set_color normal)
            echo ' '(set_color green)⠧(set_color normal) Launching subshell in virtual environment...
            source $HOME/.local/share/virtualenvs/$venv_name/bin/activate.fish
            echo && pip install --upgrade pip
        else
            echo (set_color --bold red)✘(set_color normal)(set_color white) \'$venv_name\' already activated \& \wrapped in virtualenv... (set_color normal)
        end
    else if set --query argv[1]
        set python_bin $HOME/.local/share/asdf/installs/python/$argv/bin/python
        if not test -e $python_bin # Returns true if FILE exists.
            echo "Python version '$argv' is not installed."
            return 1
        end
        if not test -d "$HOME/.local/share/virtualenvs/$venv_name" # Returns true if FILE is a directory.
            echo (set_color --bold white) Creating a virtualenv for \'$venv_name\' project... (set_color normal)
            echo (set_color white) Fishenv:(set_color --bold yellow) $HOME/.local/share/virtualenvs/$venv_name (set_color normal)
            echo (set_color --bold white) Using (set_color --bold yellow) $HOME/.local/share/asdf/installs/python/$argv/bin/python (set_color normal)(set_color green)\($argv\)(set_color --bold white) to create virtualenv...(set_color normal)

            # python -m calls the venv module as a script and passes the venv folder name as an argument to that script.
            if string match -q '2.*' $argv
                if not pip --no-python-version-warning list | grep -q virtualenv
                    python -m pip install virtualenv
                end
                $python_bin -m virtualenv $HOME/.local/share/virtualenvs/$venv_name >/dev/null 2>&1
            else
                $python_bin -m venv $HOME/.local/share/virtualenvs/$venv_name && echo
            end
            echo (set_color --bold green) ✔(set_color normal)(set_color white) Successfully created virtual environment! (set_color normal)
            echo (set_color green) Virtualenv location: $HOME/.local/share/virtualenvs/$venv_name (set_color normal)
            if test -e requirements.txt
                echo (set_color --bold white) requirements.txt(set_color normal) found in (set_color --bold yellow) $HOME/.local/share/virtualenvs/$venv_name (set_color normal)
            end
            echo ' '(set_color green)⠧(set_color normal) Launching subshell in virtual environment...
            source $HOME/.local/share/virtualenvs/$venv_name/bin/activate.fish
            echo && pip install --upgrade pip
        else
            echo (set_color --bold red)✘(set_color normal)(set_color white) \'$venv_name\' already activated \& \wrapped in virtualenv... (set_color normal)
        end
    end
end

function __venv_help
    echo "Usage: venv <empty>             Create a virtual environment with default python version"
    echo "       venv <version>           Create a virtual environment with the specified python version"
    echo "Options:"
    echo "       -v, --version            Print the version of venv"
    echo "       -h, --help               Print this help message"
    echo "       -r, --remove             Remove the environment"
    echo "Examples:"
    echo "       venv 3.10.9              Use python version 3.10.9"
end
