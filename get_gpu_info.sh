#!/bin/sh

while (true); do
	str=$(nvidia-smi | grep % | awk '{print $3}' | cut -d'C' -f 1)
	str=$str$(echo ', ')
	str=$str$(nvidia-smi | grep % | awk '{print $13}' | cut -d'%' -f 1)
	str=$str$(echo ', ')
	str=$str$(sensors | grep CPU | awk '{print $2}' | cut -d'.' -f 1 | cut -d'+' -f 2)
	str=$str$(echo ', ')
	str=$str$(top -b -n 1 | grep "%Cpu(s)" | awk '{print $2}')
	echo $str >> hw_info/gpu_info_$1
done