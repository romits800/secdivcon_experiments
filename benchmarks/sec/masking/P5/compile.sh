#!/bin/bash
#iteration
iter=$1

bash -x compile_secminizinc.sh SecMult_wires_1_mips _Z7SecMultiiiii 25 mips $iter
bash -x compile_secminizinc.sh SecMult_wires_1_cm0 _Z7SecMultiiiii 15 thumb $iter
