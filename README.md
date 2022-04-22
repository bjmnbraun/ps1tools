ps1tools is a low rent function in bash for modifying the PS1 variable without overwriting it entirely. 

Set the terminal title:

    ps1tools -t "My Title"
    
Set the terminal text color:

    ps1tools -c 31
    
Set the prompt prefix:

    ps1tools -p "$"
    
 Notably, the above all cooperate with eachother (so changing the prompt prefix doesn't overwrite the custom title, say.)

## Installation:

add

    . {path to load_ps1tools.sh}
    
to your .bashrc

## Usage

Run `ps1tools` for usage
