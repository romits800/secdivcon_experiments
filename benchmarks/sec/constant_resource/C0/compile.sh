#!/bin/bash

iter=$1

bash -x run_othersolvers.sh if-check_mips compare_key 20 mips $iter
bash -x run_othersolvers.sh if-check_cm0 compare_key 20 thumb $iter
