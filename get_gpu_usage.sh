#!/bin/sh

while (true); do
	nvidia-smi | grep % | awk '{print $13}' | cut -d'%' -f 1 >> $3/gpu_usage_$1
done