#!/bin/bash

pushd ../../../
. secdivconenv
popd

fname=SecMult_wires_1
iter=$1
bash -x diversify_monolithic_one.sh ${fname}_cm0 thumb $iter
bash -x diversify_monolithic_one.sh ${fname}_mips mips $iter

divs=divs_*
#divs2=$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
divs2=$divs #$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in $divs2
do
    cp *.sec.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh ${fname}_cm0 thumb $iter
    bash -x gen_obj.sh ${fname}_mips mips $iter
    popd
done
