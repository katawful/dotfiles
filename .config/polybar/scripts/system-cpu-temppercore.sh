#!/bin/sh

# sensors | grep Package | awk '{print substr($4, 2, length($4)-3)}' | tr "\\n" " " | sed 's/ /°C  /g' | sed 's/  $//' | awk '{print "﨎 " $0; }'
sensors | grep edge | awk '{print substr($2, 2, length($2)-3)}' | tr "\\n" " " | sed 's/ /°C  /g' | sed 's/  $//' | awk '{print "﨎 " $0; }'
