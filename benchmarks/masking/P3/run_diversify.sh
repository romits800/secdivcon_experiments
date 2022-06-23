#!/bin/bash

pushd ../../../
. secdivconenv
popd

bash -x diversify_monolithic_one.sh code_int_cm0 thumb
bash -x diversify_monolithic_one.sh code_int_mips mips
