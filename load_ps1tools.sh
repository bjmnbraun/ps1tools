#Installation:
#add
#. load_ps1tools.sh
#
#Usage:
# ps1tools -t (title)
# ps1tools -p (prompt)
#
#Both can take the syntax of the PS1 variable, google it.
#Note that that syntax allows variable and command substitution -
#$() and $ are fine, they are re-evaluated every new prompt line.

function ps1tools {

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
-t|--title)
        title="$2"
        #By default the greediness results in this finding the last match
        #which is exactly what we want.
        re='(.*\\\[\\e\]0;)(.*)(\\a\\\].*)'
        if [[ $PS1 =~ $re ]]; then
        PS1="${BASH_REMATCH[1]}$title${BASH_REMATCH[3]}"
        else
        PS1=${PS1}'\[\e]0;'${title}'\a\]'
        fi
        shift # past argument
        shift # past value
        #Note that the title will only be loaded _after_ the next prompt line
        #Doing this forces it to be updated immediately:
        echo -en '\e]0;'${title}'\a'
;;
-c|--color)
        color="$2"
        #By default the greediness results in this finding the last match
        #which is exactly what we want.
        re='(.*\\\[\\e\[)([0-9;]+)(m.*)'
        if [[ $PS1 =~ $re ]]; then
        PS1="${BASH_REMATCH[1]}$color${BASH_REMATCH[3]}"
        else
        PS1=${PS1}'\[\e['${color}'m\]'
        fi
        shift # past argument
        shift # past value
        #Update the color immediately:
        echo -en '\e['${color}'m'
;;
-p|--prompt)
        prompt="$2"
        #By default the greediness results in this finding the last match
        #which is exactly what we want.
        re='(.*\\\[\\e\]0;)(.*)(\\a\\\].*)'
        if [[ $PS1 =~ $re ]]; then
        PS1=$prompt'\[\e]0;'${BASH_REMATCH[2]}'\a\]'
        else
        PS1=$prompt
        fi
        shift # past argument
        shift # past value
;;
*)    # unknown option
POSITIONAL+=("$1") # save it in an array for later
shift # past argument
;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

}
