#!/bin/bash 

#iteration
iter=$1

bash -x compile_secminizinc.sh masked_xor_2_cm0  compute 25 thumb $iter
bash -x compile_secminizinc.sh masked_xor_2_mips  compute 25 mips $iter
