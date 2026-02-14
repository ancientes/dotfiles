function git-update
    # Check if an argument is provided
    if test (count $argv) -eq 0
        echo "Usage: git-update <branch>"
        return 1
    end

    # Get the branch name from the first argument
    set branch $argv[1]

    # Perform git fetch and pull with rebase using the provided branch name
    git fetch origin $branch && git pull --rebase origin $branch
end
