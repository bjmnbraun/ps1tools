
function ps1tools {

_PS1TOOLS_SUCCESS=
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
        _PS1TOOLS_SUCCESS=YES
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
        _PS1TOOLS_SUCCESS=YES
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
        _PS1TOOLS_SUCCESS=YES
;;
*)    # unknown option
        break
;;
esac
done

if [ "$_PS1TOOLS_SUCCESS" != "YES" ]; then
        echo "Usage: ps1tools {options}"
        echo " -p --prompt : set prompt prefix"
        echo " -t --title: set title of terminal"
        echo "Both -p and -t take the syntax of the PS1 variable, google it."
        echo "Note that the syntax allows variable and command substitution, these will be substituted every prompt line."
        echo " -c --color: colored text (ANSI terminal color code number)"
fi

}
