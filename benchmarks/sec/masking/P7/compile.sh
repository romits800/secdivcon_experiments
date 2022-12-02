#!/bin/bash -x

#iteration
iter=$1


export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}
export UNISON_PATH=${SECCON_PATH}

file=CPRR13-lut_wires_1
func=_Z18CPRR13_lut_wires_1iiiiiiiii


#sleep 20m
bash -x compile_secminizinc.sh ${file}_cm0 $func 10 thumb $iter
#bash -x compile_secminizinc.sh ${file}_cm0 $func 11 thumb $iter
#bash -x compile_secminizinc.sh ${file}_cm0 $func 15 thumb $iter
#sleep 10m
#bash -x compile_secminizinc.sh ${file}_mips $func 25 mips $iter
sleep 10m
# 
# #bash -x run_minizinc.sh ${file}_cm0 $func 15 thumb $iter
bash -x run_minizinc.sh ${file}_mips $func 25 mips $iter
# 
# 
cat ${file}_mips.$iter.out  | outfilter.pl ${file}_mips.out.json.chuffed.last .chuffed  > ${file}_mips.$iter.out.json
#cat ${file}_cm0.$iter.out  | outfilter.pl ${file}_cm0.out.json.chuffed.last .chuffed  > ${file}_cm0.chuffed.$iter.out.json
