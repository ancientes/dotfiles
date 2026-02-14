function git-branch-push
    # Check if an argument is provided
    if test (count $argv) -eq 0
        echo "Usage: git-branch <branch>"
        return 1
    end

    # Get the branch name from the first argument
    set branch $argv[1]

    # Perform git checkout to create new branch and push the branch to remote repository
    git checkout -b $branch && git push --set-upstream origin $branch
end
