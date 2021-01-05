#!/bin/sh

PATH_RESULTS="/home/thiago/Documentos/Coding/Truffle/signed_backend/";
QTD_TEST=100;
rm hw_info.csv;


printf "num_accounts, cpu_temp, gpu_temp, mem_usage, cpu_usage, gpu_usage\n" >> hw_info.csv

for QTDACCOUNTS in 1 10 20 30 40; do
	PATH_GERAL=$PATH_RESULTS$QTDACCOUNTS"usr_"$QTD_TEST"exe/";
	# echo $PATH_GERAL;
	cpu_temp=0; gpu_temp=0; mem_usage=0; cpu_usage=0; gpu_usage=0;

	for counter in $(seq 0 $(echo $QTDACCOUNTS-1 | bc)); do
		PATH_ATUAL=$PATH_GERAL"hw_info0"$counter"/";
		# echo $PATH_ATUAL;
		for i in $(seq 2 $(echo $QTD_TEST+1 | bc)); do 
	    	line=$(cat $PATH_ATUAL"hw_info0"$counter".csv" | awk "NR=="$i"{print}")
			


			# echo $line;
	    	temp=$(echo $line | awk '{print $1}' | cut -d',' -f 1)
	    	cpu_temp=$(echo $cpu_temp+$temp | bc )

	    	temp=$(echo $line | awk '{print $2}' | cut -d',' -f 1)
	    	gpu_temp=$(echo $gpu_temp+$temp | bc )

	    	temp=$(echo $line | awk '{print $3}' | cut -d',' -f 1)
	    	mem_usage=$(echo $mem_usage+$temp | bc )

	    	temp=$(echo $line | awk '{print $4}' | cut -d',' -f 1)
	    	cpu_usage=$(echo $cpu_usage+$temp | bc )

	    	temp=$(echo $line | awk '{print $5}' | cut -d',' -f 1)
	    	gpu_usage=$(echo $gpu_usage+$temp | bc )
	    done
	done
	printf "%d, " $(echo "$QTDACCOUNTS") >> hw_info.csv;
    printf "%f, " $(echo "scale=6; $cpu_temp / ($QTD_TEST * $QTDACCOUNTS)" | bc) >> hw_info.csv;
    printf "%f, " $(echo "scale=6; $gpu_temp / ($QTD_TEST * $QTDACCOUNTS)" | bc) >> hw_info.csv;
    printf "%f, " $(echo "scale=6; $mem_usage / ($QTD_TEST * $QTDACCOUNTS)" | bc) >> hw_info.csv;
    printf "%f, " $(echo "scale=6; $cpu_usage / ($QTD_TEST * $QTDACCOUNTS)" | bc) >> hw_info.csv;
    printf "%f\n" $(echo "scale=6; $gpu_usage / ($QTD_TEST * $QTDACCOUNTS)" | bc) >> hw_info.csv;

done
