# check exist function taken from zsh installation script

check_exists() {
    command_to_run=$1
    error_message=$2
    local __resultvar=$3

    if ! eval "$command_to_run" &> /dev/null; then
        if [ "$__resultvar" != ""]; then
            eval $__resultvar="'false'"
        else
            printf "%s\n" "$error_message"
            exit 1
        fi
    else
        if [ "$__resultvar" != "" ]; then
            eval $__resultvar="'true'"
        fi
   fi
}
