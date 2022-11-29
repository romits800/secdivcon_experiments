#!/bin/bash

pushd ../../../
. secdivconenv
popd

iter=$1

bash -x diversify_monolithic_one.sh kruskal_cm0 thumb $iter
bash -x diversify_monolithic_one.sh kruskal_mips mips $iter

#divs=*/divs_*
#divs2=$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )

divs=divs_*_cm0
for i in $divs
do
    cp *.alt.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh kruskal_cm0  thumb $iter
    popd
done

divs=divs_*_mips
for i in $divs
do
    cp *.alt.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh kruskal_mips  mips $iter
    popd
done
