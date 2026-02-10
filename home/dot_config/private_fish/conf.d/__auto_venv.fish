function __auto_venv --on-variable PWD --description "Automatically activate/deactivate python venv"
    status --is-command-substitution; and return  # Skip running if called inside a command substitution

    set -l venv_root "$HOME/.local/share/virtualenvs"

    # Inside a git repo
    if git rev-parse --show-toplevel >/dev/null 2>&1
        set -l git_root (realpath (git rev-parse --show-toplevel))
        set -l venv_name (basename "$git_root" | tr . -)
        set -l venv_path "$venv_root/$venv_name"

        # If a venv is active but it's not the repo venv, deactivate
        if test -n "$VIRTUAL_ENV"
            if test "$AUTO_VENV_NAME" != "$venv_name"
                __auto_venv_deactivate "$AUTO_VENV_NAME"
                set -e AUTO_VENV_NAME
            end
        end

        # Activate repo venv if none is active
        if test -z "$VIRTUAL_ENV"; and test -d "$venv_path"
            source "$venv_path/bin/activate.fish" >/dev/null 2>&1
            set -g AUTO_VENV_NAME "$venv_name"
        end

        return
    end

    # Outside git repo → regular directory
    set -l dir_name (basename "$PWD" | tr . -)
    set -l venv_path "$venv_root/$dir_name"

    # If a venv is active but we're outside the project, deactivate
    if test -n "$VIRTUAL_ENV"
        if test "$AUTO_VENV_NAME" != "$dir_name"
            __auto_venv_deactivate "$AUTO_VENV_NAME"
            set -e AUTO_VENV_NAME
        end
    end

    # Activate matching directory venv
    if test -z "$VIRTUAL_ENV"; and test -d "$venv_path"
        source "$venv_path/bin/activate.fish" >/dev/null 2>&1
        set -g AUTO_VENV_NAME "$dir_name"
    end
end

function __auto_venv_deactivate --argument-names name --description "Helper to deactivate a venv by name"
    if functions -q deactivate
        echo "venv: deactivating"
        # echo "venv: deactivating ($name)" # Print with folder name for clarity
        deactivate >/dev/null 2>&1
    end
end