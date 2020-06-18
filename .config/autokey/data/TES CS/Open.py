## This opens in any window that has an open button

import time
import re

winMain="TES Construction Set"
winCurr=window.get_active_title()

matchMain=re.search(winMain, str(winCurr))

## open for the main window
if ( matchMain ):
    mouse.click_relative(40, 30, 1)
    mouse.click_relative(40, 30, 1) # click to open plugin
    time.sleep(0.1)
    window.activate("Data", switchDesktop=False, matchClass=False)  # activate Data window
    mouse.click_relative(40, 30, 1) # "click" to move mouse closer
    mouse.click_relative(40, 30, 1)
    exit()
    