#!/bin/bash

pushd ../
. secdivconenv
popd

# clean old results
rm -r */*/*/divs_*

for iter in {0..4}
do
  for j in nonsec sec
  do 
    for i in masking constant_resource
    do
        pushd $j/$i
        bash -x run.sh $iter &> out_all_div
        #bash -x run_only_chuffed.sh &> out_only_chuffed
        popd
    done
  done
done
