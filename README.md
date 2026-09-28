## Pre Condition
> [!IMPORTANT]
> Ensure the setup script has been executed before using these features:
> ```bash
> ./install.sh
> ```

# 'git clone' alias
' git cl "repository path" ' git command can be ran to speed up the repository cloning workflow when interfacing with github.com via ssh or https


### usage: git cl "repository path"

# git fetch on established network connection
When the machine establishes a network connection, all Git repositories located within 7 levels of directory depth are automatically synchronized via git fetch to keep their remote-tracking references up to date.