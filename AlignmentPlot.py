import matplotlib.pyplot as plt 
import csv 

x = []
y = []

with open ('results_max.csv', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')

    for row in plots:
        x.append(row[o])
        y.append(int(row[1]))

plt.plot (x, y, color = 'g', linestyle = 'dashed', marker = 'o', label = "Runtimes")

plst.xticks(rotation = 25)
plt.xlabel('runtimes [s]')
plt.ylabel('alignments')
plt.title('Runtimes', fontsize = 20)
plt.grid()
plt.legend()
plt.show()

