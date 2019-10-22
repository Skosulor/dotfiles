from sys import argv
import subprocess

script, action = argv

try:
    vol = int(subprocess.check_output(['pamixer','--get-volume']))
except subprocess.CalledProcessError as E:
    vol = 0;
if action == 'dec':
    vol -= 5;
    subprocess.call(['pamixer','--set-volume', str(vol)])
elif action == 'inc':
    vol += 5;
    subprocess.call(['pamixer','--set-volume', str(vol)])     
elif action == 'toggle':
    subprocess.call(['pamixer','-t'])
