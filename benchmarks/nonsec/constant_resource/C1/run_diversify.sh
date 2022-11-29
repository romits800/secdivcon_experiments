#!/bin/bash

pushd ../../../
. secdivconenv
popd

iter=$1
bash -x diversify_monolithic_one.sh sharevalue_cm0 thumb $iter
bash -x diversify_monolithic_one.sh sharevalue_mips mips $iter


divs=divs_*_cm0
#divs2=$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in $divs
do
    cp *.alt.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh sharevalue_cm0  thumb $iter
    #bash -x gen_obj.sh sharevalue_mips  mips $iter
    popd
done


divs=divs_*_mips
#divs2=$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in $divs
do
    cp *.alt.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    #bash -x gen_obj.sh sharevalue_cm0  thumb $iter
    bash -x gen_obj.sh sharevalue_mips  mips $iter
    popd
done
