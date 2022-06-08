#!/usr/bin/bash -x


export PATH=${PATH}:${DIVCON_PATH}/src/solvers/gecode:${DIVCON_PATH}/src/solvers/multi_backend/minizinc/:${DIVCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${DIVCON_PATH}/src/solvers/multi_backend/common/ UNISON_DIR=${DIVCON_PATH}

flags="--disable-copy-dominance-constraints --disable-infinite-register-dominance-constraints --disable-operand-symmetry-breaking-constraints --disable-register-symmetry-breaking-constraints --disable-temporary-symmetry-breaking-constraints --disable-wcet-constraints"


if [ $# -lt 1 ]
then
    echo "Required parameters not provided."
    echo "./diversify_monolithic_one <path/to/filename-no-extension>"
fi


fil=$1
 

relax=0.5
lp=1000
rest="constant"
#arch=mips
dist="hamming"
ndivs=200
agap=10
seed=123
branch=clrandom
DIVS_DIR=divs
filename="${fil##*/}" # filename: file without the path but with extension


 
time timeout 20m gecode-secdiversify  ${flags} \
                                    --acceptable-gap $agap \
                                    --relax $relax \
                                    --seed $seed \
                                    --distance ${dist} \
                                    --restart $rest \
                                    --restart-scale $lp \
                                    --number-divs $ndivs \
                                    --solver-file $fil.out.json \
                                    --use-optimal-for-diversification \
                                    --div-method monolithic_lns \
                                    --divs-dir $DIVS_DIR \
                                    -o $filename.out.json \
                                    --enable-solver-solution-brancher \
                                    --branching ${branch}  \
                                    --verbose $fil.ext.json

