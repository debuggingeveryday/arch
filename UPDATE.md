# UPDATES



### ON GOING TO PUSH


<h1>Polybar</h1>

<i> Installation</i>

```
pacman -Sy polybar
sed -i ':a;N;$!ba;s/\(bar {\)\n\(\s\+status_command\s\+i3status\)\s\+\(}\)/# \1\n#\2\n# \3/' /home/scrubs/.config/i3/config
mkdir /home/scrubs/.config/polybar
cp /etc/polybar/config.ini /home/scrubs/.config/polybar/config

echo "
#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

echo \"Polybar launched...\"
" > /home/scrubs/.config/polybar/launch.sh

chmod u+x /home/scrubs/.config/polybar/launch.sh

echo "exec_always --no-startup-id /home/scrubs/.config/polybar/launch" /home/scrubs/.config/i3/config
```

<i>Configuration</li>


# PLANS

- add selection monitor and add to i3 config
- update alacritty bash install plugins
- customize ranger
