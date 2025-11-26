import sys
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

identity_file = sys.argv[1] 
output_file = sys.argv[2]   

df = pd.read_csv(identity_file, sep="\t", header=None, names=["query","target","identity"])

matrix = df.pivot_table(
    index="query",
    columns="target",
    values="identity",
    aggfunc="mean",
)
matrix = matrix.fillna(0).round(2)


plt.figure(figsize=(18,16))
sns.heatmap(
    matrix, 
    annot=True, 
    fmt=".2f", 
    cmap="viridis", 
    cbar_kws={'label': 'Percent identity'},  
    annot_kws={"size": 12} 
)

plt.title("Similarity of subtelomeric regions between chromosomes", fontsize=16)
plt.xlabel("")
plt.ylabel("")
plt.xticks(rotation=90)
plt.yticks(rotation=0)
plt.tight_layout()
plt.savefig(output_file, dpi=300)
