#!/bin/bash

if [[ "$(dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply /org/freedesktop/DBus org.freedesktop.DBus.ListNames)" == *org.mpris.MediaPlayer2.spotify* ]]; then
        echo ""
else
        echo ""
fi
