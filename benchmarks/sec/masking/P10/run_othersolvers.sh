#!/bin/bash

name=$1
func=$2
bsize=$3
arch=$4
iter=$5

case $arch in
    mips)
          target=Mips; aflags=""; input=input_mips.txt;;
    thumb)
          target=Thumb; aflags="--targetoption cortex-m0"; input=input_cm0.txt;;
    *)
          echo "Give architecture as the third argument"; exit 0;;
esac


export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}
export UNISON_DIR=${SECCON_PATH} 

echo "MINIZINC_PATH:" ${MINIZINC_PATH}
echo "SECCON_PATH:" ${SECCON_PATH}
echo "which gecode-solver:" `which gecode-solver`


#UNI=/home/romi/didaktoriko/unison/unison/src/unison/build/uni
UNI=${SECCON_PATH}/src/unison/build/uni
GEC=${SECCON_PATH}/src/solvers/gecode/
flags="--disable-copy-dominance-constraints --disable-infinite-register-dominance-constraints --disable-operand-symmetry-breaking-constraints --disable-register-symmetry-breaking-constraints --disable-temporary-symmetry-breaking-constraints --disable-wcet-constraints"
flags="$flags --sec-implementation sec_reg_2_mem_2"
timeout=5400000

$UNI import --target=$target ${aflags} $name.mir -o $name.uni --function=$func  --goal=speed --maxblocksize=$bsize --policy $input
$UNI linearize --target=$target ${aflags} $name.uni -o $name.lssa.uni
$UNI extend --target=$target ${aflags} $name.lssa.uni -o $name.ext.uni
$UNI augment --target=$target ${aflags} $name.ext.uni -o $name.alt.uni
#$UNI secaugment --target=$target ${aflags} --policy $input $name.alt.uni -o $name.sec.uni
$UNI model  --target=$target ${aflags}   $name.alt.uni -o $name.json --policy $input
${GEC}/gecode-presolver -nogoods false -tabling false -o $name.ext.json --dzn ${name}.dzn  -verbose $name.json
#  
minizinc-solver --setuponly --topdown --chuffed --no-diffn --free --rnd -l .chuffed -dzn ${name}.dzn ${name}.ext.json

mzn-crippled-chuffed --fzn-flag --verbosity --fzn-flag 3 --fzn-flag -f --fzn-flag --rnd-seed --fzn-flag 123456 --fzn-flag --time-out --fzn-flag $timeout -a -s -D good_cumulative=true -D good_diffn=false -D good_member=true ${name}.mzn ${name}.dzn -o ${name}.tdw.$iter.out #&& cat ${name}.out

#gecode-secsolver --global-budget 500 --local-limit 50000 $flags -o $name.gecode.out.json --verbose $name.ext.json


# export MINIZINC_PATH=/home/romi/repo/minizinc/MiniZincIDE-2.6.2-bundle-linux-x86_64/bin/
# export PATH=${MINIZINC_PATH}:${PATH} 
# minizinc -c --solver geas -D good_cumulative=true -D good_diffn=false -D good_member=true --fzn ${name}.geas.fzn ${name}.dzn ${name}.mzn
# fzn-geas -s --time-out 5400 -f --global-diff true -a ${name}.geas.fzn
# 
# fzn-geas -s --time-out 5400 -f --core-opt true --global-diff true -a ${name}.geas.fzn
# 
# minizinc -c --solver ortools -D good_cumulative=true -D good_diffn=false -D good_member=true --fzn ${name}.ortools.fzn ${name}.dzn ${name}.mzn
# fzn-or-tools --stop_logging_if_full_disk true --threads 12 --free_search true --time_limit 5400 --statistics=true ${name}.ortools.fzn
