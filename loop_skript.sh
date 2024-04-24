#!/bin/sh 

threads=(1)
seqlength=(3 1)
Nseq=(1 16)
db_size=(1)

for db in ${db_size[@]}
    do    
        for num in ${Nseq[@]}
            do    
                for length in ${seqlength[@]}
                    do    
                        for amount in ${threads[@]}    
                            do     
                            
                            srun -c 10 sh exec_alg.sh $Threads $seqlength $Nseq $db_size
                            
                             
                        done   
                done
        done
done


