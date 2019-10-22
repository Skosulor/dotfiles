#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

sleep 2s
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/home/ohman/go/bin
export PATH=$PATH:/home/ohman/.local/bin
export PATH=$PATH:/home/ohman/Ac6/SystemWorkbench
export PATH=$PATH:/home/ohman/.gem/ruby/2.6.0/bin
export PATH=$PATH:/home/ohman/progStuff/esp/xtensa-esp32-elf/bin
export PATH=$PATH:/home/ohman/.cargo/bin
export PATH=$PATH:/home/ohman/.cabal/bin
export IDF_PATH=~/progStuff/esp/esp-idf
export TERM=xterm-256color

# (cat ~/.cache/wal/sequences &)

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
