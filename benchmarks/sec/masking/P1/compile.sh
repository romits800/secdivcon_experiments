#!/bin/bash
#iteration
iter=$1


bash -x compile_secminizinc.sh code_cm0  _Z7computejjjj 25 thumb $iter
bash -x compile_secminizinc.sh code_mips  _Z7computejjjj 25 mips $iter
