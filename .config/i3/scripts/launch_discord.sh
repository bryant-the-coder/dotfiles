#!/bin/bash

# Check if discord is running and run if not
# if ! pgrep "Discord" > /dev/null
# then
#         /usr/bin/discord
# fi


#!/bin/bash

killall -q Discord

while pgrep -x Discord >/dev/null; do sleep 1; done

Discord
