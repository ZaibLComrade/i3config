# ~/.config/i3/touchpad_setup.sh
#!/bin/bash
sleep 1
DEVICE="ETPS/2 Elantech Touchpad"
ID=$(xinput list --id-only "$DEVICE")
[ -n "$ID" ] || { echo "Touchpad not found" >> /tmp/touchpad.log; exit 1; }

xinput set-prop "$ID" "libinput Tapping Enabled" 1
xinput set-prop "$ID" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$ID" "libinput Scroll Method Enabled" 0 1 0
xinput set-prop "$ID" "libinput Accel Custom Scroll Step" 0.176471
echo "Touchpad config applied" >> /tmp/touchpad.log

