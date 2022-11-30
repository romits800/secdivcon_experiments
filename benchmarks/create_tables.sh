#!/bin/bash
dist="reg_cyc_hamming"

 

echo "Both CM0 Mips + DivTime"
echo -e "\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\\\\\\\\"
for bench in P{0..10}
do 
    #echo; echo $bench
    vals="$bench"
    for j in 0 10 # 50; 
    do  
        for i in  sec/masking/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val

        done;
        for i in  nonsec/masking/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
        done;

    done
    for j in 0 10 # 50; 
    do
        for i in  sec/masking/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
        done;
        for i in  nonsec/masking/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
        done;

    done; 

    echo -e "$vals\\\\\\\\"
done
echo "\\hline"
#for bench in if-check sharevalue mulmod8 modexp kruskal 
for bench in C{0..4}
do 
    #echo; echo $bench
    vals="$bench"
    for j in 0 10 # 50; 
    do  
        for i in  sec/constant_resource/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
       done;
        for i in  nonsec/constant_resource/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
       done;

    done
    for j in 0 10 # 50; 
    do  
        for i in  sec/constant_resource/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
       done;
        for i in  nonsec/constant_resource/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | cut -d\",\" -f 4" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
            command=`sh -c "tail -1 $i/stime.csv" 2>/dev/null`
            val=$(echo "scale=2;$command" | bc -l | awk '{printf "%.2f", $0}')
            vals=$vals"\t&\t"$val
       done;

    done

    echo -e "$vals\\\\\\\\"
done



echo "Code reuse CM0 Mips"
echo -e "\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\t&\tN\t&\tNS\\\\\\\\"
for bench in P{0..10}
do 
    #echo; echo $bench
    vals="$bench"
    for j in 0 10 # 50; 
    do  
        for i in  sec/masking/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "if test -f "$i/results.csv"; then tail -1 $i/results.csv | tr ',' '&'; else echo \"-&-&-&1\"; fi" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
        done;
        for i in  nonsec/masking/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "if test -f "$i/results.csv"; then tail -1 $i/results.csv | tr ',' '&'; else echo \"-&-&-&1\"; fi" 2>/dev/null`
            #command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
        done;

    done
    for j in 0 10 # 50; 
    do
        for i in  sec/masking/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "if test -f "$i/results.csv"; then tail -1 $i/results.csv | tr ',' '&'; else echo \"-&-&-&1\"; fi" 2>/dev/null`
            #command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
        done;
        for i in  nonsec/masking/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "if test -f "$i/results.csv"; then tail -1 $i/results.csv | tr ',' '&'; else echo \"-&-&-&1\"; fi" 2>/dev/null`
            #command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
        done;

    done; 

    echo -e "$vals\\\\\\\\"
done
echo "\\hline"
for bench in C{0..4}
do 
    #echo; echo $bench
    vals="$bench"
    for j in 0 10 # 50; 
    do  
        for i in  sec/constant_resource/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
       done;
        for i in  nonsec/constant_resource/$bench/divs_${j}_${dist}_cm0/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
       done;

    done
    for j in 0 10 # 50; 
    do  
        for i in  sec/constant_resource/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
       done;
        for i in  nonsec/constant_resource/$bench/divs_${j}_${dist}_mips/; 
        do  
            command=`sh -c "tail -1 $i/results.csv | tr ',' '&'" 2>/dev/null`
            val=${command}
            vals=$vals"\t&\t"$val
       done;

    done

    echo -e "$vals\\\\\\\\"
done


echo 
echo "Costs"
for bench in C{0..4}
do 
    #echo; echo $bench
    vals="$bench"
    #for impl in sec nonsec
    #do
        impl=sec
        cp extract_cost.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_cost.py *_cm0.*.out.json | head -1" 2>/dev/null`
        valsec=${command}
        #vals=$vals"\t&\t"$val
        popd &> /dev/null
        
        impl=nonsec
        cp extract_cost.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_cost.py *_cm0.*.out.json | head -1" 2>/dev/null`
        valnsec=${command}
        #vals=$vals"\t&\t"$val
        popd &> /dev/null

        oh=$(echo "scale=2;($valsec-$valnsec)/$valnsec*100." | bc -l | awk '{printf "%d", $0}')

        vals=$vals"\t&\t"$valsec"\t&\t"$valnsec"\t&\t"$oh


    #done
    #for impl in sec nonsec
    #do
        impl=sec
        cp extract_cost.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_cost.py *_mips.*.out.json | head -1" 2>/dev/null`
        valsec=${command}
        #vals=$vals"\t&\t"$val
        popd &> /dev/null

        impl=nonsec
        cp extract_cost.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_cost.py *_mips.*.out.json | head -1" 2>/dev/null`
        valnsec=${command}
        #vals=$vals"\t&\t"$val
        popd &> /dev/null


        oh=$(echo "scale=2;($valsec-$valnsec)/$valnsec*100." | bc -l | awk '{printf "%d", $0}')

        vals=$vals"\t&\t"$valsec"\t&\t"$valnsec"\t&\t"$oh

    #done
    echo -e "$vals\\\\\\\\"
done


echo
echo "Solving time"
#for bench in "if-check" sharevalue mulmod8 modexp kruskal 
for bench in C{0..4}
do 
    #echo; echo $bench
    vals="$bench"
    #for impl in sec nonsec
    #do
        impl=sec
        cp extract_stime.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_stime.py *_cm0.*.out.json | head -1" 2>/dev/null`
        valsec=$(echo "scale=2;$command/1000.0" | bc -l | awk '{printf "%.2f", $0}')
        #vals=$vals"\t&\t"$val
        popd &> /dev/null

        impl=nonsec
        cp extract_stime.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_stime.py *_cm0.*.out.json | head -1" 2>/dev/null`
        valnsec=$(echo "scale=2;$command/1000.0" | bc -l | awk '{printf "%.2f", $0}')
        #vals=$vals"\t&\t"$val
        popd &> /dev/null

        oh=$(echo "scale=2;($valsec-$valnsec)/$valnsec*100." | bc -l | awk '{printf "%d", $0}')

        vals=$vals"\t&\t"$valsec"\t&\t"$valnsec"\t&\t"$oh
    #done
    #for impl in sec nonsec
    #do
        impl=sec
        cp extract_stime.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_stime.py *_mips.*.out.json | head -1" 2>/dev/null`
        valsec=$(echo "scale=2;$command/1000.0" | bc -l | awk '{printf "%.2f", $0}')
        #vals=$vals"\t&\t"$val
        popd &> /dev/null

        impl=nonsec
        cp extract_stime.py $impl/constant_resource/$bench/
        pushd $impl/constant_resource/$bench/ &> /dev/null
        command=`sh -c "python extract_stime.py *_mips.*.out.json | head -1" 2>/dev/null`
        valnsec=$(echo "scale=2;$command/1000.0" | bc -l | awk '{printf "%.2f", $0}')
        #vals=$vals"\t&\t"$val
        popd &> /dev/null

        oh=$(echo "scale=2;($valsec-$valnsec)/$valnsec*100." | bc -l | awk '{printf "%d", $0}')

        vals=$vals"\t&\t"$valsec"\t&\t"$valnsec"\t&\t"$oh
    #done
    echo -e "$vals\\\\\\\\"
done

