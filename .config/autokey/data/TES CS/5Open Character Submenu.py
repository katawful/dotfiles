## this series of scripts opens the tool bars

import time
import re

winMain="TES Construction Set"
winCurr=window.get_active_title()

matchMain=re.search(winMain, str(winCurr))

## check if its the main window
if ( matchMain ):
    mouse.click_relative(155, 10, 1)
    mouse.click_relative(155, 10, 1)
    mouse.click_relative(155, 10, 1)
    exit()