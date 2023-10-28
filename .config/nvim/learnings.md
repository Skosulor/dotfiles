# Learnings

This document consists of new things I learn for vim through various sources but things
I dont seem to remember since i rarley use them...

## Keymaps

| command | mode | description                     |
| ------  | ---- | ------------------------------- |
| gv      | n    | reselect last visual selection  |
| C-h     | i    | delete character in insert mode |
| o       | v    | move curser to opposite end of visual text |


## Saving buffer with sudo privileges 
    
:w !sudo tee % > /dev/nul

