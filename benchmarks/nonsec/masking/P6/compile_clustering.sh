#!/bin/bash

name=$1
func=$2
csize=$3
kmiter=$4
neigens=$5
arch=$6
iter=$7

case $arch in
    mips)
          target=Mips; aflags="";;
    thumb)
          target=Thumb; aflags="--targetoption cortex-m0";;
    *)
          echo "Give architecture as the third argument"; exit 0;;
esac


#SECCON_PATH=/home/romi/unison/secdivcon/divCon #seccon_experiments/secConCG/

export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH} 
export UNISON_DIR=${SECCON_PATH} 

echo "MINIZINC_PATH:" ${MINIZINC_PATH}
echo "SECCON_PATH:" ${SECCON_PATH}


#UNI=/home/romi/didaktoriko/unison/unison/src/unison/build/uni
UNI=${SECCON_PATH}/src/unison/build/uni
GPS=${SECCON_PATH}/src/solvers/gecode/gecode-presolver
GS=${SECCON_PATH}/src/solvers/gecode/gecode-solver
flags="--monolithic-budget 120 --global-budget 500 --local-limit 80000"
flags="$flags --step-aggressiveness 0.5"



$UNI import --target=$target ${aflags} $name.mir -o ${name}_${csize}_${kmiter}_${neigens}.uni --function=$func  --goal=speed --clusternumber=$csize \
            --kmeansiterations $kmiter --numbereigenvectors $neigens
$UNI linearize --target=$target ${aflags} ${name}_${csize}_${kmiter}_${neigens}.uni -o $name.lssa.uni
$UNI extend --target=$target ${aflags} $name.lssa.uni -o $name.ext.uni
$UNI augment --target=$target ${aflags} $name.ext.uni -o $name.alt.uni
$UNI model  --target=$target ${aflags}   $name.alt.uni -o $name.json
$GPS -o $name.ext.json -dzn ${name}_${csize}.dzn --verbose $name.json
 
# 0.1 - 800 - 80000 : 1413
$GS $flags -o ${name}.$iter.out.json --verbose $name.ext.json
#${SECCON_PATH}/src/solvers/multi_backend/portfolio-solver --timeout 1200 --gecodeflags "$flags" -o $name.out.json --verbose $name.ext.json



