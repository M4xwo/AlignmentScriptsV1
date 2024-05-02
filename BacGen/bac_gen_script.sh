#!/bin/bash

workdir="/LETHE/COURSES/data/bac_genomes/refseq/bacteria"
index=$1
gunzip $workdir/$index/*.gz

 
ac_content=$(grep -v ">" $workdir/$index/*.fna | sed "s/[AT]//g" | wc -m) 
gc_content=$(grep -v ">" $workdir/$index/*.fna | sed "s/[GC]//g" | wc -m)
total_count=$(($ac_content+$gc_content))
gc_ratio=$(echo "scale=5; $gc_content/$total_count" | bc)


num_genes=$(grep -o -i "gene" $workdir/$index/*.gff | wc -m) 

echo "$index; $total_count; $num_genes; $gc_ratio " >> bac_results_xah.txt



##echo $gc_ratio
