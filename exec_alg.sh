#!/bin/bash


/LETHE/COURSES/HPC24SS/AliScale/query ##query directory 
/LETHE/COURSES/HPC24SS/AliScale/references ##reference directory
time1=$(date +%s)                          ##takes the date before running the command to calculate the time afterwards

vsearch --usearch_global /LETHE/COURSES/HPC24SS/AliScale/query/$2 --db /LETHE/COURSES/HPC24SS/AliScale/references/$3 -t $1
##vsearch searches for correct alignments betweend two fasta files. Directory of the file has to be given, file name is taken form loop script 
##

time2=$(date +%s)                           ##second date is taken for time calculation 
time_elapsed=$(($time2 - $time1))           ##calculation of time and storage in variable
echo "$time_elapsed seconds; $1 threads used; number of sequences: $2; size of database: $3 "  >> testfile.txt ##one fancy output just for the sake of it 


echo "$time_elapsed seconds; $1;  $2; $3"  >> results_max.txt  ##one output to further work with 





