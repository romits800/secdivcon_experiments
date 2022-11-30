#!/bin/bash

pushd ../../../../
. secdivconenv
popd

iter=$1

bash -x diversify_monolithic_one.sh masked_xor_2_cm0 thumb $iter
bash -x diversify_monolithic_one.sh masked_xor_2_mips mips $iter

divs=divs_*
divs2=$divs #$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in $divs2
do
    cp masked_xor_2_*.alt.uni $i
    cp gen_obj.sh $i
    pushd $i
        bash -x gen_obj.sh masked_xor_2_cm0 thumb $iter
        bash -x gen_obj.sh masked_xor_2_mips mips $iter
    popd
done
