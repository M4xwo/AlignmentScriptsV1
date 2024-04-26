#!/bin/bash 

##script for a nested loops that iterate over every combination from used threats, query-file, reference-file and give every iteration 
##to the second script which gives the combinations into a vsearch 


threads=(1 5 10) ##number of used threats 
Nseq=$(ls /LETHE/COURSES/HPC24SS/AliScale/query) ##directory of query files 
db_size=$(ls /LETHE/COURSES/HPC24SS/AliScale/references) ##directory of reference files
rm testfile.txt ##deletes any files from previous runs 
rm results_max.txt ##deletes any files from previous runs 
for db in $db_size;
    do    
        for num in $Nseq;
            do      
                for amount in ${threads[@]};    
                    do     
                    sleep 1                                                 ##sleep to slow down the flood of jobs 
                    srun -c 10 sh exec_alg.sh $threads $Nseq $db_size &     ##srun manages jobs and after the script name used values of the current 
                                                                            ##iteration are given to the vseasrch script         
                             
                           
                done
        done
done
