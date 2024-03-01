#!/bin/bash

# Start ydotoold daemon and suppress output for brevity
sudo ydotoold > /dev/null 2>&1 &
echo -e "$(date +"%H:%M:%S")\tStarting ydotoold daemon service"

# Wait for daemon start before initialising ydotool
sleep 1

# Get screen resolution
IFS="x" read -r width height <<< $(xdpyinfo | grep dimensions | awk '{print $2}')

# Define delay between moves (in seconds)
delay=60

# Start the mousemove routine
while true; do
  # Generate random X and Y offsets
  offsetX=$((RANDOM % 5))
  offsetY=$((RANDOM % 5))

  # Move the mouse by an offset with respect to the current mouse position
  ydotool mousemove $offsetX $offsetY

  # Press the SHIFT key
  ydotool key shift

  # Tell everyone you are doing your job
  echo -e "$(date +"%H:%M:%S")\tMouse moved by $offsetX and $offsetY, SHIFT key"

  # Pause before next cycle
  sleep $delay
done
