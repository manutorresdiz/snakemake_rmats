#! /bin/bash


patients=$(sed 1d $2 | cut -f 1 | tr '\n' ' ' | awk -F " " '{print $0}')

for patient in $patients
do
        P1=$(cat $1 | awk "/$patient/ {print}" | awk '{print $2}')
        P2=$(cat $1 | awk "/$patient/ {print}" | awk '{print $3}')
        R1=$(cat $1 | awk "/$patient/ {print}" | awk '{print $4}')
        R2=$(cat $1 | awk "/$patient/ {print}" | awk '{print $5}')
        
        echo "$1data/bam_files/${P1}.bam,$1data/bam_files/${P2}.bam" > $1metadata/${patient}_Primary.txt
        echo "$1data/bam_files/${R1}.bam,$1data/bam_files/${R2}.bam" > $1metadata/${patient}_Relapse.txt
done
