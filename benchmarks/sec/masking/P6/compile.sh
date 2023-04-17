#!/bin/bash
#iteration
iter=$1

bash -x compile_secminizinc.sh SecMultLinear_wires_1_mips _Z7SecMultiiiii 25 mips $iter
#bash -x compile_secminizinc.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 16 thumb


#bash -x compile_clustering.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 2 1000 2 thumb 
#bash -x compile_clustering.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 2 1000 3 thumb 
#bash -x compile_clustering.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 2 1000 4 thumb  $iter
bash -x compile_secminizinc.sh SecMultLinear_wires_1_cm0 _Z7SecMultiiiii 15 thumb  $iter
