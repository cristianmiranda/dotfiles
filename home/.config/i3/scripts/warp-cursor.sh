#!/bin/sh
win=$(xdotool getwindowfocus)
eval $(xdotool getwindowgeometry --shell "$win")
xdotool mousemove --window "$win" $((WIDTH/2)) $((HEIGHT/2))
