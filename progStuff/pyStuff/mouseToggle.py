from subprocess import call
from pyautogui import moveTo
import os

home = os.path.expanduser("~")
dire = "/home/ohman/progStuff/pyStuff/"
settingFile = open(os.path.join(dire, "mouseToggle.txt"), 'r+')
currSetStr = settingFile.read()


if  currSetStr.find("1") > -1:
    moveTo(2000,2000)
    settingFile.truncate()
    settingFile.seek(0)
    settingFile.write("0")
    call(['xinput', 'set-prop', 'Elan Touchpad', 'Device Enabled', '0'])
else:
    moveTo(960,540)
    settingFile.truncate()
    settingFile.seek(0)
    settingFile.write("1")
    call(['xinput', 'set-prop', 'Elan Touchpad', 'Device Enabled', '1'])
