#!/bin/bash

# File changes the default output to analog stereo output as well as disabled built-in monitor

movesinks() {
  echo "Setting default sink to: $1";
  pacmd set-default-sink $1
  pacmd list-sink-inputs | grep index | while read line
  do
  echo "Moving input: ";
  echo $line | cut -f2 -d' ';
  echo "to sink: $1";
  pacmd move-sink-input `echo $line | cut -f2 -d' '` $1

  done
}


# Change audio to dock
sink=`pactl list short sinks | grep Thunderbolt | awk '{print $1}'`
movesinks $sink

# Disable built-in monitor on laptop
xrandr --output eDP-1 --off 
