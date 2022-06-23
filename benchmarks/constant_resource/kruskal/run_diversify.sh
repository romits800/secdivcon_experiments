#!/bin/bash

pushd ../../../
. secdivconenv
popd

bash -x diversify_monolithic_one.sh kruskal_cm0 thumb
bash -x diversify_monolithic_one.sh kruskal_mips mips
