#!/bin/bash

pushd ../../../
. secdivconenv
popd

bash -x diversify_monolithic_one.sh mulmod8_cm0 thumb
bash -x diversify_monolithic_one.sh mulmod8_mips mips
