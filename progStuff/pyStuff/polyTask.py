
from sys import argv
from datetime import datetime, time, date
import subprocess
import json
import dateutil.parser

try:
    tasks = ((subprocess.check_output(["task", "export"])))
except subprocess.CalledProcessError as E:
    urgentTask = "No tasks"
    print("Problem calling subprocess: task export")
jsonTasks = (json.loads(tasks))

urgency = -1
urgentTask = "No tasks"
# nodue = True

for object in jsonTasks:
    if ((float(object['urgency']) > float(urgency)) and (object['status'] == "pending")):
        urgentTask = object['description']
        urgency = object['urgency']
        try:
            dueDate = object['due']
            nodue = False
        except:
            nodue = True
if urgentTask == "No tasks": 
    print("No Tasks")
else:   
    if not nodue:
        dueDate = dateutil.parser.parse(dueDate)
        due = ( dueDate.replace(tzinfo=None)- datetime.now())
        hours = round((due.seconds/3600))
        days = due.days
    else:
        days = 0
        hours = 0
    if abs(days) >= 1:
        print(urgentTask + ": " + str(days) + "d")
    else:
        print(urgentTask + ": " + str(hours) + "H")
