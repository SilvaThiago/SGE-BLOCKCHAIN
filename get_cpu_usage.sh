#!/bin/sh

while (true); do
	top -b -n 1 | grep "%Cpu(s)" | awk '{print $2}' >> $3/cpu_usage_$1
done