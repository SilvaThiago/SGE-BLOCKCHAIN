 #!/bin/sh

while (true); do
	top -b -n 1 | grep "KiB Mem" | awk '{print ($4-$6)*100/$4}' >> $3/mem_usage_$1
done