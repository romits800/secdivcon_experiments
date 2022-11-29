#!/bin/bash

iter=$1
bash -x compile_minizinc.sh SecMultLinear_wires_1_mips _Z7SecMultiiiii 25 mips $iter
#bash -x compile_minizinc.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 15 thumb
bash -x compile_clustering.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 2 1000 4 thumb  $iter
