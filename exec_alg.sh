#!/bin/sh

threads= $1
seq_len= $2
nseq= $3
db_size= $4
algorithm= "VSearch"

time 1

vsearch -t $threads &

time vsearch 

time_elapsed= time 2 - time 1 

echo $time_elapsed ; $threads ; $seq_len; $nseq ; $db_size ; $algorithm

