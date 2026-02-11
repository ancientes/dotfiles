# Only run gpg-agent initialization if the session is interactive
if status is-interactive
    function gpgagent_init
        # Check if gpg-agent is available
        if not type -q gpg-connect-agent
            # Only show the error message if in an interactive session
            if status is-interactive
                echo "gpg-connect-agent is not available; please install GnuPG"
            end
            return 1
        end

        # Ensure that gpg-agent is running (it will start on demand if not already running)
        gpg-connect-agent /bye >/dev/null 2>&1

        # Enable the use of GPG keys for SSH authentication
        gpg-connect-agent "SCD LEARN --force" /bye >/dev/null 2>&1
    end

    # Call the function to initialize gpg-agent
    gpgagent_init
end
