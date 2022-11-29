#!/bin/bash


iter=$1

pushd ../../../../
. secdivconenv
popd

bash -x diversify_monolithic_one.sh password_cm0 thumb
bash -x diversify_monolithic_one_sec.sh password_cm0 thumb


#divs=*/divs_*
#divs2=$( grep -v reg <<< `echo $divs| tr  ' ' '\n'` )
for i in divs_*_cm0*
do
    cp *.sec.uni $i
    cp gen_obj.sh $i
 
    pushd $i
    bash -x gen_obj.sh password_cm0 thumb
    popd
done


