import subprocess

try:
    # pkgs = ((subprocess.check_output(['yay', '-Qu'])))
    pkgs = ((subprocess.check_output(['checkupdates'])))
except subprocess.CalledProcessError as E:
    pkgs = "E"

# print(type(pkgs))
if pkgs == "E":
    print(pkgs)
else:
    derp = str(pkgs)
    print((pkgs.count(('\n').encode())))


