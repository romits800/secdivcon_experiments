#!/bin/bash

pushd ../../../
. secdivconenv
popd

fname=CPRR13-lut_wires_1
iter=$1
bash -x diversify_monolithic_one.sh ${fname}_cm0 thumb $iter
bash -x diversify_monolithic_one.sh ${fname}_mips mips $iter

divs=divs_*
divs2=$divs #$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in $divs2
do
    cp *.alt.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh ${fname}_cm0 thumb $iter
    bash -x gen_obj.sh ${fname}_mips mips $iter
    popd
done
