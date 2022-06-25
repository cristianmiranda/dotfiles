#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 2; done

# Launch polybar
K2_MONITORS=`xrandr --listmonitors | grep x1440 | wc -l`
K4_MONITORS=`xrandr --listmonitors | grep x2160 | wc -l`

if [[ "$K2_MONITORS" != "0" ]]; then

    xrandr --query | grep " connected" | while read entry; do
        mon=$(cut -d" " -f1 <<< "$entry")                                          
        status=$(cut -d" " -f3 <<< "$entry")                                       
                                                                                   
        tray_pos=""                                                                
        if [ "$status" == "primary" ]; then                                        
            tray_pos="right"                                                       
        fi                                                                         

        MONITOR=$mon TRAY_POS=$tray_pos polybar --reload asus 2>&1 | tee -a /tmp/polybar-monitor-"$mon".log & disown                                                     
    done                                                                           

elif [[ "$K4_MONITORS" != "0" ]]; then
    polybar --reload laptop 2>&1 | tee -a /tmp/polybar-laptop.log & disown    
fi
