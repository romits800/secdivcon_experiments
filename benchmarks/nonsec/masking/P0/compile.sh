#!/bin/bash

file=masked_xor_2
func=compute
iter=$1
bash -x compile_minizinc.sh ${file}_cm0  $func 25 thumb $iter
bash -x compile_minizinc.sh ${file}_mips $func 25 mips $iter
