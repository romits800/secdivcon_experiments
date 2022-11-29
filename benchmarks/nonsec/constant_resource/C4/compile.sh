#!/bin/bash

iter=$1

bash -x run_othersolvers.sh kruskal_mips kruskal_enter 20 mips $iter
bash -x run_othersolvers.sh kruskal_cm0 kruskal_enter 20 thumb $iter
