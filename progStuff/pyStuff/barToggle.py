import subprocess
from pyautogui import hotkey

try: 
    processes = ((subprocess.check_output(["ps", "-e"])))
except subprocess.CalledProcessError as E:
    print("Unable to get processes")

barExist = str(processes).find("polybar")
if barExist > -1:
    print("polybar is running")
    subprocess.call(["killall", "polybar"])
    hotkey('alt', 'ctrl', 'shift', 'm')
else:
    print("polybar is not running")
    subprocess.call(["/home/ohman/.config/polybar/launch.sh"])
    hotkey('alt', 'ctrl', 'shift', 'n')
