
function fuzzyVim;
    set path (fd -H -t f | fzf --preview 'bat --color=always {}' --reverse )
    if not test "$path" = ""
    	nvim $path
    end
end


function openDir;
    set path (fd -t d "" $HOME | fzf --reverse)
    if not test "$path" = ""
       cd $path;
       clear;
       ls;
    end
  commandline -f repaint
end

function killProcess;
    set proc (ps -e | rg " " | fzf --reverse | string split -n ' ')
    if not test "$proc[1]" = "PID"
       kill (echo $proc[1])
       echo $proc[4] killed
    end
end

function searchWord;
   set word (rg '' | fzf -e --reverse)
   echo $word
   commandline -f repaint
end
