import pandas as pd 

#os.chdir()
blast_falues = pd.read_csv("results_combined.csv", sep=";", names=['time', 'number', 'nseq', 'dbsize', 'algorythm'])

sns.set_style("darkgrid")

plot=sns.relplot(data=blast_falues, x='dbsize', y='time', hue='algorythm', kind='line', style='number')
plot.set(xscale="log", yscale="log")
