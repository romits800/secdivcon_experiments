#!/bin/bash

pushd ../../../
. secdivconenv
popd

iter=$1

for i in C{0..4} # if-check modexp sharevalue mulmod8 kruskal 
do
    pushd $i
    ##bash -x clean.sh
    bash -x compile.sh $iter &> out_run  # compile
    ##rm -r divs_*
    bash -x run_diversify.sh $iter &> out_div

    for j in divs_*_mips
    do
        echo $j
        cp ../*.py ../run_results.sh $j
        pushd $j
        bash -x run_results.sh mips $iter &> out_results
        popd
    done

    for j in divs_*_cm0
    do
        echo $j
        cp ../*.py ../run_results.sh $j
        pushd $j
        bash -x run_results.sh thumb $iter &> out_results
        popd
    done

    popd
done



