#!/bin/bash

iter=$1
bash -x compile_minizinc.sh SecMult_wires_1_mips _Z7SecMultiiiii 25 mips $iter
bash -x compile_minizinc.sh SecMult_wires_1_cm0 _Z7SecMultiiiii 15 thumb $iter
#bash -x compile_clustering.sh SecMult_wires_1_cm0 _Z7SecMultiiiii 2 1000 3 thumb
#bash -x compile_clustering.sh SecMult_wires_1_cm0 _Z7SecMultiiiii 2 1000 4 thumb
