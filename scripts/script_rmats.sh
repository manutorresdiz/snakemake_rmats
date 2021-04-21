#!/bin/bash

/home/torresdizm/Downloads/rmats_turbo_v4_1_1/run_rmats --paired-stats --b1 $1$2 --b2 $1$3 --gtf $4 -t paired --readLength 75 --nthread 4 --od $1$6 --tmp $1$5 