#!/bin/bash
##xah
rm bac_results_xah2.txt

data_directory=$(cat "/LETHE/COURSES/data/bac_genomes/refseq/xah")

## echo $data_directory
for index in $data_directory;
   do 
      sleep 0.3
      
      srun -c 1 bash bac_gen_script.sh $index &
done 




