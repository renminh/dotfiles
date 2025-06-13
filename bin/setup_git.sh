#!/bin/bash

# TODO:
# check if gitconfig exists anywhere and ask for deletion or if not?
# if user wants to save, make it a feature to? save their old email and name over to the new one

# ensure git is installed
if ! command -v git &> /dev/null; then
    echo "[ERROR] Git is not installed. Ensure it is installed before running script"
    exit 1
fi

# prompt for config input
read -p "Enter an email for git: " git_email
read -p "Enter a name for git: " git_name

# prompt for my custom settings
read -p "Copy my git config settings? [N/y]: " copy_settings
if [ "$copy_settings" == "Y" ] || [ "$copy_settings" == "y" ]; then copy_settings="yes"; fi

# show summary
echo ""
echo "Preparing git config for:"
echo "* Github email: $git_email"
echo "* Github name: $git_name"

if [ "$copy_settings" == "yes" ]; then
    echo "* Copy settings?: Yes"
else
    echo "* Copy settings?: No"
fi

echo ""
read -r -p "Continue?: [Y/n]: " do_it
if [ -n "$do_it" ] && [ "$do_it" != "y" ] && [ "$do_it" != "Y" ]; then
    echo "Aborting..."
    exit 1
fi


# [ OUTPUT ] 

# create config file
cat > "git/config" <<EOF
[user]
   email = $git_email
   name = $git_name
[init]
    defaultBranch = main
EOF

# copy over settings to gitconfig
if [ "$copy_settings" == "yes" ]; then
    CONF_EXTRA_FILE="git/config_extra"

    if [ -f "$CONF_EXTRA_FILE" ]; then
        echo "Appending aditional git config from my settings..."
        cat "$CONF_EXTRA_FILE" >> "git/config"
    else
        echo "[WARN] Custom settings file not found in git directory"
    fi
fi

# remove default gitconfig from home directory
rm -f ~/.gitconfig

# move gitconfig to xdg config directory
mkdir -p ~/.config/git
cp git/config ~/.config/git/
echo "Moved gitconfig to ~/.config/git/config"

echo "[FINISH] Done."
