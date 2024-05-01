## BacGenStat Skript Theorie

We want a script that analyzes different bacterial genomes deposited either as a .fa or a .gff file for their GC content 
in relation to their genome size or their number of total deposited genes 

First we have to calculate the GC_content of the Gene through counting the amount of G's and C's and dividing it through the total size in bases.
This probably works by for looping through all the files using the grep command specifically for the amount of G's and C's and 
doing a simple calculation afterwards. 

we also have to find a way to check how many genes there are in every bacterial genome, either trough comparison with a database like in our first project AliScale 
(maybe already written scripts are reusable) or by just parting the genome in theoretical genes with a predefined size 

while calculating the gc content we already need the total amount of bases in the genome so we there is no need to count the genome size seperately 

Visualization can either be done in RStudio or Python afterwards, technically it should be poissible to script this aswell but I guess its too complicated 

Its probably best to start with the calculation of the gc content, then