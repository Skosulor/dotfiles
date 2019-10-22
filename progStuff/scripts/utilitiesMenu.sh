#!/usr/bin/env bash

function keyboardLayout(){
  action=$(echo -e "american\nswedish" | rofi -theme powermenu -lines 2 -width 10% -dmenu -p Layout);
  if [ "$action" == "american" ]; then
      setxkbmap us; exec xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape';
  elif [ "$action" == "swedish" ]; then
      setxkbmap se; exec xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape';
  fi
}

function yesno(){
  echo -e "no\nyes" | rofi -theme powermenu -lines 2 -width 10% -dmenu -p "confirm";
}


function bluetoothMenu(){
  action=$(echo -e "jabra\ndisconnect" | rofi -theme powermenu -lines 2 -width 12% -dmenu -p Connect/disconnect);
  if [ "$action" == "jabra" ]; then
      python ~/progStuff/pyStuff/bluetooth.py c jabra

  elif [ "$action" == "disconnect" ]; then
      python ~/progStuff/pyStuff/bluetooth.py d


  fi

}

function killProcess(){
  proc=$( ps -e | rofi -theme networkmenu -i -lines 20 -width 25% -dmenu -p Kill )
  kill ${proc[0]};
  echo ${proc[3]} killed
}

function openPdf(){
  pdf=$(fd -t f .pdf | rofi -theme networkmenu -i -lines 20 -width 25% -dmenu -p Open pdf  );
  if [ "$pdf" == "" ]
  then
     echo "Aborted.."
  else
  nohup zathura $pdf & disown; exit;
  fi
}

function quickEdit(){
  file=$(fd -H |  rofi -theme networkmenu -i -lines 20 -width 25% -dmenu -p Edit  );
  if [ "$file" == "" ]
  then
     echo "Aborted.."
  else
    urxvt -e nvim $file
  fi
}

function getQuickMenu(){
  echo -e "key layout\npower off\nreboot\nquick edit\nopen pdf\nkill process\nbluetooth\nnetwork" |
    rofi -theme powermenu -lines 8 -width 10% -dmenu -p "Quick Menu" ;
}

function utilities(){
  action=$( getQuickMenu )

  if [ "$action" == "power off" ]; then
  action2=$( yesno )
  if [ "$action2" == "yes" ]; then
    shutdown -h now;
  fi

  elif [ "$action" == "reboot" ]; then
  action2=$( yesno )
  if [ "$action2" == "yes" ]; then
    reboot;
  fi

  elif [ "$action" == "key layout" ]; then
      keyboardLayout;

  elif [ "$action" == "bluetooth" ]; then
      bluetoothMenu;

  elif [ "$action" == "kill process" ]; then
      killProcess;

  elif [ "$action" == "open pdf" ]; then
      openPdf;

  elif [ "$action" == "quick edit" ]; then
      quickEdit;

  elif [ "$action" == "network" ]; then
    networkmanager_dmenu;

  fi
}


utilities
