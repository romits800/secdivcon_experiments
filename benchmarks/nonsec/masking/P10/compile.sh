#!/bin/bash

export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}
export SECCON_PATH=${SECCON_PATH}

func=whitening
filen=whitening
iter=$1
#120
bash -x compile_minizinc.sh ${filen}_cm0 $func 40 thumb 0.1 $iter
bash -x compile_minizinc.sh ${filen}_mips $func 30 mips 0.1 $iter

