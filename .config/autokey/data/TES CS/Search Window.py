## This searches in any window that has a search bar

import time
import re

winObject="Object Window"
winCell="Cell View"
winCurr=window.get_active_title()

matchObject=re.search(winObject, str(winCurr))
matchCell=re.search(winCell, str(winCurr))

if ( matchObject ):
    time.sleep(0.1)
    mouse.click_relative(80, 20, 1)
    exit()

elif ( matchCell ):
    time.sleep(0.1)
    mouse.click_relative(80, 50, 1)
    exit()