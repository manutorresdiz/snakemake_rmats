#! /bin/bash


patients=$(sed 1d $2 | cut -f 1 | tr '\n' ' ' | awk -F " " '{print $0}')

for patient in $patients
do
        P1=$(cat $1 | awk "/$patient/ {print}" | awk '{print $2}')
        P2=$(cat $1 | awk "/$patient/ {print}" | awk '{print $3}')
        R1=$(cat $1 | awk "/$patient/ {print}" | awk '{print $4}')
        R2=$(cat $1 | awk "/$patient/ {print}" | awk '{print $5}')
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${P1}/star/${P1}.bam $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${P1}/star/${P1}.bam.bai $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${P2}/star/${P2}.bam $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${P2}/star/${P2.bam.bai $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${R1}/star/${R1}.bam $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${R1}/star/${R1}.bam.bai $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${R2}/star/${R2}.bam $1data/bam_files/
        ln -s /mnt/isilon/thomas-tikhonenko_lab/target/processed_reads/${R2}/star/${R2.bam.bai $1data/bam_files/
        
        echo "$1data/bam_files/${P1}.bam,$1data/bam_files/${P2}.bam" > $1metadata/${patient}_Primary.txt
        echo "$1data/bam_files/${R1}.bam,$1data/bam_files/${R2}.bam" > $1metadata/${patient}_Relapse.txt
done
