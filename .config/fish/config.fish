#values
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual                 block


# Path
set PATH $HOME/.cargo/bin $PATH

# Abbreviations
abbr ins sudo pacman -S 
abbr upg sudo pacman -Syu
abbr big xdotool key F11
#abbr workssh ssh -xt andreaso@192.168.2.183 tmux attach
#abbr goldssh ssh -x pi@192.168.2.115 tmux attach
#abbr workmount sshfs andreaso@192.168.2.183:/home/andreaso/ ~/jobb/mount/ 

# Aliases
alias ls exa
alias cat bat
alias kp killProcess
alias c clear
alias cl 'clear; ls'
alias hack 'cat /dev/urandom | hexdump -C | rg "13 37"'

# Bindings
bind -M insert \cp fuzzyVim
bind -M insert \co openDir
bind -M insert \cg searchWord

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

bind -M insert \ck nextd-or-forward-word
bind -M insert \cj prevd-or-backward-word
bind -M insert \cl accept-autosuggestion

# Full path in prompt
set -U fish_prompt_pwd_dir_length 0


# Vterm support, unclear if working

function vterm_printf;
    if [ -n "$TMUX" ]
        # tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

# cd up to n dirs
# using:  cd.. 10   cd.. dir
function cd_up; 
	if string match --quiet --regex '\D' $argv[1];
      		cd ( pwd | sed -r "s|(.*/$argv[1][^/]*/).*|\1|" )     
	else
		for x in (seq $argv[1])
			cd ..
		end
  	end
end
alias cd.. cd_up                                


# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /home/ohman/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/ohman/.ghcup/bin $PATH

#set PATH $HOME/.local/bin $PATH
set PATH $HOME/.emacs.d/bin $PATH
set PATH $HOME/.local/bin $PATH

set -g fish_escape_delay_ms 10
