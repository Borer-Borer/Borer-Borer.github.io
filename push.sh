#!/bin/sh
current_branch=$(git branch --show-current)
# Add changes to git.
git pull --rebase --autostash origin $current_branch
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin $current_branch



###############Deploy##############

# If a command fails then the deploy stops set -e 
printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
# hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -t LoveIt

# Go To Public folder
cd public

# current_branch=$(git branch --show-current)
# echo "$current_branch"
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin $current_branch
