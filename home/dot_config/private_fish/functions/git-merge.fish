function git-merge
    # Check if an argument is provided
    if test (count $argv) -eq 0
        echo "Usage: git-merge <branch>"
        return 1
    end

    # Get the branch name from the first argument
    set branch $argv[1]

    # Perform git pull, fetch, and merge with fast-forward only using the provided branch name
    git pull && git fetch origin $branch && git merge --ff-only $branch
end
