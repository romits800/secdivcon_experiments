#!/usr/bin/bash -x


export PATH=${SECCON_PATH}/src/solvers/gecode:${SECCON_PATH}/src/solvers/multi_backend/minizinc/:${SECCON_PATH}/src/solvers/multi_backend/:${MINIZINC_PATH}:${SECCON_PATH}/src/solvers/multi_backend/common/:${PATH}

export UNISON_DIR=${SECCON_PATH}

GEC=${SECCON_PATH}/src/solvers/gecode/
flags="--disable-copy-dominance-constraints --disable-infinite-register-dominance-constraints --disable-operand-symmetry-breaking-constraints --disable-register-symmetry-breaking-constraints --disable-temporary-symmetry-breaking-constraints --disable-wcet-constraints"

#missing_files="/home/romi/didaktoriko/unison/romi_unison/divCon/src/unison/test/fast/Hexagon/speed/mesa.api.glIndexd.mir /home/romi/didaktoriko/unison/romi_unison/divCon/src/unison/test/fast/Hexagon/speed/sphinx3.glist.glist_tail.mir /home/romi/didaktoriko/unison/romi_unison/divCon/src/unison/test/fast/Hexagon/speed/sphinx3.profile.ptmr_init.mir"

#test_files="/home/romi/didaktoriko/unison/romi_unison/divCon/src/unison/test/fast/Mips/speed/gobmk.board.get_last_player.mir"
# In kbytes: 10Gbytes
#ulimit -v 10485760

if [ $# -lt 1 ]
then
    echo "Required parameters not provided."
    echo "./diversify_monolithic_one <path/to/filename-no-extension> <mips|thumb>"
fi

fil=$1
arch=$2
case $arch in
    mips)
          suff=mips;;
    thumb)
          suff=cm0;;
    *)
          echo "Give architecture as the second argument"; exit 0;;
esac

relax=0.5
lp=1000
rest="constant"
ndivs=200
seed=123
branch=clrandom
filename="${fil##*/}" # filename: file without the path but with extension


for dist in "reg_hamming" "reg_cyc_hamming"
do
for agap in 0 10 20 40 60 80 100
do
    DIVS_DIR=divs_${agap}_${dist}_${suff}
    time timeout 2m $GEC/gecode-secdiversify  ${flags} \
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

done
done
