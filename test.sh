#!/bin/sh

QTDACCOUNTS=2;


for counter in $(seq 0 $(echo $QTDACCOUNTS-1 | bc)); do
	public=$(cat ganache.txt | grep "($counter)" | grep 'ETH)' | cut -d' ' -f 2);
	private=$(cat ganache.txt | grep "($counter)" | grep -v 'ETH)' | cut -d' ' -f 2);

	printf "$public\n$private\n"
done