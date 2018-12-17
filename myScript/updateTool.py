import os
import time
os.chdir(r'/Users/hong/Desktop/HZYToolBox')
str = raw_input("updateConent:");
str = 'git commit -m "%s"'%str
os.system('git add .')
time.sleep(2)
os.system(str)
time.sleep(2.5)
os.system('git push origin master')

