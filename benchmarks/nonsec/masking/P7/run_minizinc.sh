#!/bin/bash

name=$1
func=$2
bsize=$3
arch=$4
# iteration number
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


#UNI=/home/romi/didaktoriko/unison/unison/src/unison/build/uni
UNI=${SECCON_PATH}/src/unison/build/uni
GPS=${SECCON_PATH}/src/solvers/gecode/gecode-presolver
#flags="--disable-copy-dominance-constraints --disable-infinite-register-dominance-constraints --disable-operand-symmetry-breaking-constraints --disable-register-symmetry-breaking-constraints --disable-temporary-symmetry-breaking-constraints --disable-wcet-constraints"
#flags="$flags --sec-implementation sec_reg_2_mem_2"

$UNI import --target=$target ${aflags} $name.mir -o $name.uni --function=$func  --goal=speed --maxblocksize=$bsize
$UNI linearize --target=$target ${aflags} $name.uni -o $name.lssa.uni
$UNI extend --target=$target ${aflags} $name.lssa.uni -o $name.ext.uni
$UNI augment --target=$target ${aflags} $name.ext.uni -o $name.alt.uni
$UNI model  --target=$target ${aflags}   $name.alt.uni -o $name.json
$GPS -nogoods false -tabling false -o $name.ext.json --dzn ${name}.dzn  -verbose $name.json
 
minizinc-solver --setuponly --topdown --chuffed --no-diffn --free --rnd -l .chuffed -dzn ${name}.dzn ${name}.ext.json

timeout=5400000
#timeout=5400000
mzn-crippled-chuffed --fzn-flag --verbosity --fzn-flag 3 --fzn-flag -f --fzn-flag --rnd-seed --fzn-flag 123456 --fzn-flag --time-out --fzn-flag $timeout -a -s -D good_cumulative=true -D good_diffn=false -D good_member=true ${name}.mzn ${name}.dzn -o ${name}.$iter.out #&& cat ${name}.out
