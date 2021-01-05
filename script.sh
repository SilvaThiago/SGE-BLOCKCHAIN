#!/bin/sh

QTD_TEST=10;
QTDACCOUNTS=$4;
PATH_HWINFO="$QTDACCOUNTS"usr_"$QTD_TEST"exe/hw_info$1;
#echo $PATH_HWINFO;

# rm result_time
# rm result_classify
# rm clean_result
# rm -rd $PATH_HWINFO
# mkdir "$QTDACCOUNTS"usr_"$QTD_TEST"exe
mkdir $PATH_HWINFO

for counter in $(seq 1 $QTD_TEST); do
	total=0;
	for i in $(seq 1 10); do
		node src/app.js $2 $3 > "$PATH_HWINFO"/temp_time;
		total=$(echo $total+$(cat "$PATH_HWINFO"/temp_time | grep Duracao | cut -d' ' -f 3) | bc)
		#echo $total;
	done
	echo $total >> "$PATH_HWINFO"/result_time;
	sleep 5
done
# sed '/^Extracting/ d' < result_time > clean_result_time

for counter in $(seq 1 $QTD_TEST); do
	./get_gpu_temp.sh $counter $1 $PATH_HWINFO &
	./get_gpu_usage.sh $counter $1 $PATH_HWINFO &
	./get_cpu_temp.sh $counter $1 $PATH_HWINFO &
	./get_cpu_usage.sh $counter $1 $PATH_HWINFO &
	./get_mem_usage.sh $counter $1 $PATH_HWINFO &
	for i in $(seq 1 10); do
		node src/app.js $2 $3;
	done
	$(ps -axf | grep "./get_gpu_temp.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_gpu_usage.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_cpu_temp.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_cpu_usage.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_mem_usage.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	sleep 5	
done

./get_hw_infos.sh $QTD_TEST $1 $PATH_HWINFO
