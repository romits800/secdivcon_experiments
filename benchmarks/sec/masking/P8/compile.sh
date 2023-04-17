#!/bin/bash

#iteration
iter=$1

export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}
export UNISON_PATH=${SECCON_PATH}

func=_Z6OptLUTjjjjjjjjj 
filen=CPRR13-OptLUT_wires_1 

# sleep 20m
#bash -x compile_secminizinc.sh ${filen}_mips $func 25 mips $iter
#sleep 10m
#bash -x compile_secminizinc.sh ${filen}_cm0 $func 15 thumb $iter
bash -x compile_secminizinc.sh ${filen}_cm0 $func 10 thumb $iter
#bash -x compile_secminizinc.sh ${filen}_cm0 $func 11 thumb $iter

sleep 10m
bash -x run_minizinc.sh ${filen}_mips $func 25 mips $iter
#bash -x run_minizinc.sh ${filen}_cm0 $func 15 thumb $iter


cat ${filen}_mips.$iter.out  | outfilter.pl ${filen}_mips.out.json.chuffed.last .chuffed  > ${filen}_mips.$iter.out.json
#cat ${filen}_cm0.$iter.out  | outfilter.pl ${filen}_cm0.out.json.chuffed.last .chuffed  > ${filen}_cm0.chuffed.$iter.out.json
