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
On the one hand it is possible to reserve 	threads for different tasks, on the other it manages the amount and order of the jobs of all different users.

SLURM or other similiar working workload managers are mostly preinstalled on HPC's. 
To get an overview of the free capacities of the HPC you can use the command `htop`. 
Queueing a task with SLURM can be done by using the command `srun` before calling your scripts.
To reserve a certain amount of threads you use the operator `-c` and follow up with the number you wish to reserve.
The operator `--mem XG` lets you specify the amount of memory you'd like to use for your jobs.
Using the `squeue` command you can check if your jobs made it into the queue and at which location they're at.
By adding a `&` sign at the end of your command you can close the command line window and your command still gets processed in the background.


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

```R 
##install.packages("ggplot2")
library(ggplot2)

daten <- read.table("C:/Users/woelf/OneDrive/Dokumente/GitHub/AlignmentScriptsV1/results_combined.csv", sep=";") 


daten$threads_nseq <- interaction(daten$V2, daten$V3)   

ggplot(daten, aes(x=V4, y=V1, col=V5, shape=threads_nseq))+ 
  geom_point(size=5)+ 
  scale_y_log10()+  
  scale_x_log10()+  
  scale_shape_manual(values = 0:10)+   
  geom_smooth(se=F)+    
  theme_bw()
```

## Containers 

Containers are storages for certain applications and all their configurations.
They are an easy way for users to to get different jobs done without having to worry about special confiogurations 
for their device e.g. certain dependencies and versions for coding packages.

Other than being very comfortable and user friendly, containers provide great consistency and therefore 
great and easy reproducibility which is specially important for working in scientific and development circumstances.
Containers can also be compared to virtual machines or sandboxes, providing an isolated environment, preventing conflicts 
and damages to the HPC systems or the users own devices.

Containers need to be pulled from a directory or an online source and then executed.
Depending on the used registry or library the syntax may vary slightly.

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

```shell
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
```

```R
library(ggplot2)
 
   daten <- read.table("/Users/ra76waj/HPCSS24/AlignmentScriptsV1/BacGen/complete.csv", sep=";") 
   
     
     
       ggplot(daten, aes(x=V2, y=V3, col=V4))+ 
           geom_point(size = 1.5)+ 
           scale_y_log10()+  
           scale_x_log10()+  
           scale_shape_manual(values = 0:10)+   
           xlab("genome lenght")+
           ylab("number of genes")+
           theme_bw()
```

```R
library(ggplot2)
##library(viridis)
 
   daten <- read.table("/Users/ra76waj/HPCSS24/AlignmentScriptsV1/BacGen/part_taxonomy.csv", sep=";") 
   
     
     
       ggplot(daten, aes(x=V2, y=V3, col=V5))+  ##y=V3 for number of genes and taxonomy, y=V4 for gc_content and taxonomy 
           geom_point(size = 1.5)+ 
           scale_y_log10()+  
           scale_x_log10()+  
           scale_shape_manual(values = 0:10)+   
           xlab("genome lenght")+
           ylab("number of genes")+
           theme_bw()
           ##scale_colour_viridis(option="turbo", discrete=TRUE)
```

# Discussion
