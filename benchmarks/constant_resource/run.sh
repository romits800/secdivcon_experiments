#!/bin/bash

pushd ../../
. secconenv
popd

for i in kruskal kruskal_find modexp mulmod8 sharevalue
do
    pushd $i
    bash -x run_diversify.sh &> out_div
    #bash -x run_only_chuffed.sh &> out_only_chuffed
    popd
done
