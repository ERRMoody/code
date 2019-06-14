import pandas as pd

df = pd.read_csv("arcfeatures.csv")

df['S_GC'] = df[['trna_GC', 'rrna_GC']].mean(axis=1)

df.to_csv("arcfeatures2.csv", index=False)
