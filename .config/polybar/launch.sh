#!/bin/bash

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

polybar main
#!/usr/bin/env bash
# killall -q polybar

# while pgrep -x polybar >/dev/null; do sleep 1; done

# polybar --reload top &
# polybar --reload bottom &
