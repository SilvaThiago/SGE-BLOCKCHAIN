#!/bin/sh

QTD_TEST=$1


# rm $3/hw_info$2.csv
for counter in $(seq 1 $QTD_TEST); do
	sed -i.bak s/,/\./g $3/cpu_usage_$counter
	sed -i.bak s/,/\./g $3/gpu_usage_$counter
	sed -i.bak s/,/\./g $3/mem_usage_$counter
done

rm $3/*.bak

printf "cpu_temp, gpu_temp, mem_usage, cpu_usage, gpu_usage\n" >> $3/hw_info$2.csv

for counter in $(seq 1 $QTD_TEST); do
	echo TESTE $2 $counter/$QTD_TEST;

	# Retirando valores N/A
	cat $3/cpu_temp_$counter | grep -v N/A > $3/cpu_temp_now;
	mv $3/cpu_temp_now $3/cpu_temp_$counter;
	# Calculando media da temperatura da cpu
	count=$(wc -l < $3/cpu_temp_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/cpu_temp_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media da temperatura da gpu
	count=$(wc -l < $3/gpu_temp_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/gpu_temp_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media do uso da memoria
	count=$(wc -l < $3/mem_usage_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/mem_usage_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media do uso da cpu
	count=$(wc -l < $3/cpu_usage_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/cpu_usage_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media do uso da gpu
	count=$(wc -l < $3/gpu_usage_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/gpu_usage_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f\n" $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv


done