#!/bin/bash

pushd ../../../
. secdivconenv
popd

iter=$1

bash -x diversify_monolithic_one.sh mulmod8_cm0 thumb $iter
bash -x diversify_monolithic_one.sh mulmod8_mips mips $iter


#divs=*/divs_*
#divs2=$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in divs_*_cm0
do
    cp *.sec.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh mulmod8_cm0 thumb
    #bash -x gen_obj.sh mulmod8_mips mips
    popd
done

for i in divs_*_mips
do
    cp *.sec.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    #bash -x gen_obj.sh mulmod8_2_cm0 thumb
    bash -x gen_obj.sh mulmod8_mips mips
    popd
done
