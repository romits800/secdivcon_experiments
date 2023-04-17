#!/bin/bash

#iteration
iter=$1

export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}
export UNISON_PATH=${SECCON_PATH}

func=whitening
filen=whitening


bash -x compile_secminizinc.sh ${filen}_mips $func 30 mips 0.1 $iter
bash -x compile_secminizinc.sh ${filen}_cm0 $func 45 thumb 0.1 $iter
