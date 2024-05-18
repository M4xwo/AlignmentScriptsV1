# HPC-SS24

Name: Max Wölfle

Immatriculation Number: 11738266

# Introduction

At first I was sceptical because I thought the course was more or less only math like I've heard about Computational Biology I but then a friend of mine who did it in the 4th semester recommended it to me.

I would like to learn about HPC computing because I think it will be very relevant in the future not only in biology but in a large scale of topics.

My expectations for the course are to learn how to use bigger networks to fulfill tasks that are out or range for normal desktop or laptop workstations.
Another goal for me would be to make coding a continuous hobby. I already enjoyed coding Python for the coding module in the third semester but after the module was completed
I didn't really know where to continue because I had no real idea about what projects to start.



# Course content

## Github

I created a GitHub Account for the Python module in the 3rd Semester but never actually used it because there was no need.
Now working on different branches for the protocol and using my own repository to be able to work on scripts wherever I like is really cool,
even though at first the whole procedure of importing repositories into VS Code and switching between them melt my brain for a while.

## Markdown

Markdown seems like a great tool to create well designed and interactive files to share or to explain things.

## Linux

## SLURM

SLURM is a workload manager designed to protect the HPC-Server from being overloaded with too many tasks at the same time.
On the one hand it is possible to reserve 	threads for different tasks, on the other it manages the total workload of all different users.

SLURM or other similiar working workload managers are mostly preinstalled on HPC's. 

To queue a task with SLURM you use the command -c before calling your scripts.
To reserve a certain amount of threads you use the operator --threads and follow up with the number you wish to reserve.
By adding a "&" sign at the end of your command you can close the command line window and your command still gets processed in the background.


## First Project: AliScale 

For our first project, we decided to test different sequence alignment tools for their speed, also comparing the differnces betweend single and multi-
threaded runs.
We used:

* Needle
* BLAST
* VSearch 

for comparison.

Every row in the classroom took another tool, me and the others in the third row took vsearch.
```shell 
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
```

```shell
#!/bin/bash


/LETHE/COURSES/HPC24SS/AliScale/query ##query directory 
/LETHE/COURSES/HPC24SS/AliScale/references ##reference directory
time1=$(date +%s)                          ##takes the date before running the command to calculate the time afterwards

vsearch --usearch_global /LETHE/COURSES/HPC24SS/AliScale/query/$2 --db /LETHE/COURSES/HPC24SS/AliScale/references/$3 --id 0.7 --uc test --threads $1
##vsearch searches for correct alignments betweend two fasta files. Directory of the file has to be given, file name is taken form loop script 
##

time2=$(date +%s)                           ##second date is taken for time calculation 
time_elapsed=$(($time2 - $time1))           ##calculation of time and storage in variable
echo "$time_elapsed seconds; $1 threads used; number of sequences: $2; size of database: $3 "  >> testfile.txt ##one fancy output just for the sake of it 


echo "$time_elapsed seconds; $1;  $2; $3"  >> results_max.txt  ##one output to further work with 

```



## BacGenStat
```shell

/bin/bash
##xah
rm bac_results_xah2.txt

data_directory=$(cat "/LETHE/COURSES/data/bac_genomes/refseq/xah")

## echo $data_directory
for index in $data_directory;
   do 
      sleep 0.3
      
      srun -c 1 bash bac_gen_script.sh $index &
done 

```
As our final project 

# Discussion
