#!/bin/bash

iter=$1
bash -x compile_minizinc.sh SecMultOpt_wires_1_mips _Z7SecMultiiiii 25 mips $iter
bash -x compile_minizinc.sh SecMultOpt_wires_1_cm0 _Z7SecMultiiiii 15 thumb $iter
