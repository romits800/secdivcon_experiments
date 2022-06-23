export PATH=${PATH}:${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/
export UNISON_PATH=${SECCON_PATH}

cat CPRR13-OptLUT_wires_1_mips.out  | outfilter.pl CPRR13-OptLUT_wires_1_mips.out.json.chuffed.last .chuffed  > CPRR13-OptLUT_wires_1_mips.out.json
