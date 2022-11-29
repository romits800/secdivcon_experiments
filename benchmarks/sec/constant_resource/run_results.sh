#!/bin/bash

arch=$1
iter=$2
python jop_rc.py `pwd` pairwise_gadgets.dump $arch $iter
python extract_results.py -p `pwd`  -f results.csv -s stime.csv
