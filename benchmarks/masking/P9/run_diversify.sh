#!/bin/bash

pushd ../../../
. secdivconenv
popd

fname=CPRR13-1_wires_1
bash -x diversify_monolithic_one.sh ${fname}_cm0 thumb
bash -x diversify_monolithic_one.sh ${fname}_mips mips
