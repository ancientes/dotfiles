function forget --description "Remove current command from fish and atuin history"
    set -l cmd (commandline | string collect)

    if test -z "$cmd"
        return
    end

    # Fish history
    history delete --exact --case-sensitive -- "$cmd"
    history merge

    # Atuin history
    if type -q atuin
        atuin search --delete --limit 1 -- "$cmd" # prevents deleting multiple similar entries
    end

    commandline ""
    commandline -f repaint
end
