#!/usr/bin/env bash
#
# A template for creating command line scripts taking options, commands
# and arguments.
#
# Exit values:
#  0 on success
#  1 on failure
#



# Name of the script
SCRIPT=$( basename "$0" )

# Current version
VERSION="1.0.0"



#
# Message to display for usage and help.
#
function usage
{
    local txt=(
"Utility $SCRIPT for doing stuff."
"Usage: $SCRIPT [options] <command> [arguments]"
""
"Command:"
"  app-quote            Prints out a random motivational quote."
"  app-daily [anything] Prints out a daily quote from a site."
"  calendar [events]    Print out current calendar with(out) events."
""
"Options:"
"  --help, -h     Print help."
"  --version, -h  Print version."
    )

    printf "%s\\n" "${txt[@]}"
}



#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
"For an overview of the command, execute:"
"$SCRIPT --help"
    )

    [[ -n $message ]] && printf "%s\\n" "$message"

    printf "%s\\n" "${txt[@]}"
}

#
# Message to display for version.
#
function version
{
    local txt=(
"$SCRIPT version $VERSION"
    )

    printf "%s\\n" "${txt[@]}"
}

#
# source: https://github.com/mubaris/motivate
#
# prints out a linux penguin mascot tux with a quote.

function app-quote
{
    quote=$(motivate)
    echo -e "\n $(cowsay -f tux "$quote")"
}

#
# 
#
function app-daily
{
    quote=$(curl -s "https://api.quotable.io/random" | jq -r '.content')
    echo -e "\n $(cowsay -f tux "$quote")"

}

#
# Process options
#
while (( $# ))
do
    case "$1" in

        --help | -h)
            usage
            exit 0
        ;;

        --version | -v)
            version
            exit 0
        ;;
    
        quote | daily   )
            command=$1
            shift
            app-"$command" "$*"
            exit 0
        ;;

        *)
            badUsage "Option/command not recognized."
            exit 1
        ;;

    esac
done

badUsage
exit 1
