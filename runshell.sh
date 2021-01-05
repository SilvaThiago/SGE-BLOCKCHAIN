#!/bin/sh
QTD_TEST=10;
QTDACCOUNTS=1;

for i in 1; do
	QTDACCOUNTS=$i;
	mkdir "$QTDACCOUNTS"usr_"$QTD_TEST"exe
	for counter in $(seq 0 $(echo $QTDACCOUNTS-1 | bc)); do
		public=$(cat accounts.txt | grep "($counter)" | grep 'ETH)' | cut -d' ' -f 2);
		private=$(cat accounts.txt | grep "($counter)" | grep -v 'ETH)' | cut -d' ' -f 2 | cut -d'x' -f 2);

		# node src/app.js $public $private &
		./script.sh 0$counter $public $private $QTDACCOUNTS &
	done
	sleep 1000;
done
