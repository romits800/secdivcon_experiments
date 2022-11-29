#!/bin/bash

iter=$1
filen=code
func=_Z7computejjjj
bash -x compile_minizinc.sh ${filen}_cm0 $func 25 thumb $iter
bash -x compile_minizinc.sh ${filen}_mips $func 25 mips $iter
