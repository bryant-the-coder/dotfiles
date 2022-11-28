#!/bin/bash

killall cava

i3bgwin rxvt -depth 32 -bg '[00]black' --color6 '[50]cyan' +sb -embed {windowid} -e cava
