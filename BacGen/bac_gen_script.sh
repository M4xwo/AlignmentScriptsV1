#!/bin/bash

workdir="/LETHE/COURSES/data/bac_genomes/refseq/bacteria"
index=$1
gunzip $workdir/$index/*.gz

 
ac_content=$(grep -v ">" $workdir/$index/*.fna | sed "s/[AT]//g" | wc -m) 
gc_content=$(grep -v ">" $workdir/$index/*.fna | sed "s/[GC]//g" | wc -m)
total_count=$(($ac_content+$gc_content))
gc_ratio=$(echo "scale=5; $gc_content/$total_count" | bc)


num_genes=$(grep -o -i "gene" $workdir/$index/*.gff | wc -m) 
##getting bac ID step 2 friday
bac_id=$(grep -i "##species" $workdir/$index/*.gff | head -n 1 | cut -d"=" -f2)
phylum=$(docker run --rm ncbi/edirect  /bin/bash -c  "efetch -db taxonomy -id $bac_id -format xml | xtract -pattern Taxon -block '*/Taxon' -tab '\n'  -element Id,Rank,TaxId,ScientificName" | grep "phylum" | cut -f 3)
##
echo "$index; $total_count; $num_genes; $gc_ratio; $phylum " >> bac_results_xah2.txt



##echo $gc_ratio