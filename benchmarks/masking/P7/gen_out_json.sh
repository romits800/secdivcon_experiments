export PATH=${PATH}:${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/
export UNISON_PATH=${SECCON_PATH}

filename=CPRR13-lut_wires_1_mips
cat $filename.out  | outfilter.pl $filename.out.json.chuffed.last .chuffed  > $filename.out.json
