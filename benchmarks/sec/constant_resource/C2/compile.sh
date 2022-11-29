#!/bin/bash

iter=$1

bash -x run_othersolvers.sh mulmod8_mips mulmod8_enter 20 mips $iter
bash -x run_othersolvers.sh mulmod8_cm0 mulmod8_enter 20 thumb $iter
