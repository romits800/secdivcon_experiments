#!/bin/bash

pushd ../../../
. secdivconenv
popd

bash -x diversify_monolithic_one.sh code_cm0 thumb
bash -x diversify_monolithic_one.sh code_mips mips
