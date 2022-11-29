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


export PATH=${PATH}:${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/ 
export UNISON_DIR=${SECCON_PATH} 

echo "MINIZINC_PATH:" ${MINIZINC_PATH}
echo "SECCON_PATH:" ${SECCON_PATH}


#UNI=/home/romi/didaktoriko/unison/unison/src/unison/build/uni
UNI=${SECCON_PATH}/src/unison/build/uni
GPS=${SECCON_PATH}/src/solvers/gecode/gecode-presolver


$UNI import --target=$target ${aflags} $name.mir -o $name.uni --function=$func  --goal=speed  --maxblocksize=$bsize --policy $input
$UNI linearize --target=$target ${aflags} $name.uni -o $name.lssa.uni
$UNI extend --target=$target ${aflags} $name.lssa.uni -o $name.ext.uni
$UNI augment --target=$target ${aflags} $name.ext.uni -o $name.alt.uni
#$UNI secaugment --target=$target ${aflags} --policy $input $name.alt.uni -o $name.sec.uni
$UNI model  --target=$target ${aflags}   $name.alt.uni -o $name.json --policy $input
$GPS -nogoods false -tabling false -o $name.ext.json --dzn ${name}.dzn  -verbose $name.json
 
minizinc-solver --setuponly --topdown --chuffed --no-diffn --free --rnd -l .chuffed -dzn ${name}.dzn ${name}.ext.json

mzn-crippled-chuffed --fzn-flag --verbosity --fzn-flag 3 --fzn-flag -f --fzn-flag --rnd-seed --fzn-flag 123456 --fzn-flag --time-out --fzn-flag 5400000 -a -s -D good_cumulative=true -D good_diffn=false -D good_member=true ${name}.mzn ${name}.dzn -o ${name}.$iter.out #&& cat ${name}.out
