#!/bin/bash

pushd ../../../
. secdivconenv
popd

bash -x diversify_monolithic_one.sh sharevalue_cm0 thumb
bash -x diversify_monolithic_one.sh sharevalue_mips mips
