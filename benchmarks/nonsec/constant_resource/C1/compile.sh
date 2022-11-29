#!/bin/bash

iter=$1

bash -x run_othersolvers.sh sharevalue_mips sharevalue_enter 20 mips $iter
bash -x run_othersolvers.sh sharevalue_cm0 sharevalue_enter 20 thumb $iter
