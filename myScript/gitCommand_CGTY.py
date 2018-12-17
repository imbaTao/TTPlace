import os
import time
os.chdir(r'/Users/hong/Desktop/CGSport')
os.system('git add .')
str = raw_input("updateConent :");
str = 'git commit -m "%s"'%str
time.sleep(1)
os.system('git pull origin hjb2.0')
time.sleep(1)
os.system(str)
time.sleep(2.5)
os.system('git push origin hzyReview')
time.sleep(2.5)
#os.system('pod install')


