#!/bin/bash

#find all .git directories under the home directory and execute git fetch --all --quiet
# -maxdepth prevents searching long paths
find "$HOME" -maxdepth 7 -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repodir="$(dirname "$gitdir")"
    
    #check if the repository has an active remote origin configured
    if git -C "$repodir" remote get-url origin &>/dev/null; then
        #fetch updates from the remote origin
        git -C "$repodir" fetch --all --quiet &>/dev/null &
    fi
done

#wait for all background fetches to finish before exiting
wait