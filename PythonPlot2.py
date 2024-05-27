import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

os.chdir("C:/Users/woelf/OneDrive/Dokumente/GitHub/AlignmentScriptsV1")

results = pd.read_csv("results_combined.csv", sep=";",names=['time','number','nseq','dbsize','algorythm'])
#spalten benennen und (query spalte zu Zahlen machen)

#blast_falues.tail()

sns.set_style("darkgrid")


plot=sns.relplot(data=results, x='dbsize', y='time', hue='algorythm', kind='line', style='number')
plot.set(xscale="log", yscale="log")
plt.show()
