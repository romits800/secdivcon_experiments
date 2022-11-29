#!/bin/bash
#iteration
iter=$1


bash -x compile_secminizinc.sh code_int_cm0  _Z7computejjj 25 thumb $iter
bash -x compile_secminizinc.sh code_int_mips  _Z7computejjj 25 mips $iter
