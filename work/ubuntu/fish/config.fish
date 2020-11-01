# values

set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual                 block



# Abbreviations
abbr ins sudo apt install

# Aliases

alias c clear
alias cl 'clear; ls'

# Bindings

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

#set PATH $HOME/.local/bin $PATH
set PATH $HOME/.emacs.d/bin $PATH
