#!/bin/bash

iter=$1

bash -x run_othersolvers.sh modexp_mips modexp_enter 20 mips $iter
bash -x run_othersolvers.sh modexp_cm0 modexp_enter 20 thumb $iter
