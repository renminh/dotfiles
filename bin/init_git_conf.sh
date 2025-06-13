#!/bin/bash

# TODO:
# make sure git is installed first

# TODO:
# clear file before setting it here

github_email=""
git_name=""
echo -n "Enter your github email: "
read github_email

echo -n "Enter a name for git: " 
read git_name

mkdir -p git
cat > "git/config" <<EOF
[user]
   email = $github_email
   name = $git_name
[init]
    defaultBranch = main
EOF

# setting up git dir
mkdir -p ~/.config/git
cp git/config ~/.config/git/
echo "Moved gitconfig to .config/git/"
