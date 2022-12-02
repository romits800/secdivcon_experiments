#!/bin/bash

export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}
export SECCON_PATH=${SECCON_PATH}

func=_Z12CPRR13_wiresjjjjjjjjj
filen=CPRR13-1_wires_1
iter=$1

bash -x compile_minizinc.sh ${filen}_cm0 $func 20 thumb $iter
bash -x run_minizinc.sh ${filen}_mips $func 50 mips $iter


cat ${filen}_mips.$iter.out  | outfilter.pl ${filen}_mips.out.json.chuffed.last .chuffed  > ${filen}_mips.$iter.out.json

