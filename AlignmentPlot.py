import matplotlib.pyplot as plt 
import csv 

x = []
y = []

with open ('results_combined.csv', 'r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ';')

    for row in plots:
        x.append(row[0])
        y.append(int(row[1]))

plt.scatter (x, y )

plt.xticks(rotation = 25)
plt.xlabel('runtimes [s]')
plt.ylabel('alignments')
plt.title('Runtimes', fontsize = 20)
plt.grid()
plt.legend()
plt.show()

