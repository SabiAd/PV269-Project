# The similarity of human subtelomeric sequences at various scales
This repository contains a workflow for computing and visualizing sequence identity between subtelomeric regions of human chromosomes.  
The pipeline calculates pairwise identity between chromosome arms and generates a heatmap summarizing similarities.

## Overview
Subtelomeres are regions immediately adjacent to the telomeric repeats, forming the transition zone between the highly repetitive telomeric region (TTAGGG) and the gene-rich euchromatin of the chromosome. Subtelomeres consist of heterogeneous sequence repetitions, making them notoriously difficult to map and sequence. In humans, their size is highly variable (up to 500 kb in each autosomal arm), and they are highly polymorphic. Due to the presence of blocks of highly similar, yet non-identical, repeated sequences (known as Segmental Duplications), subtelomeres exhibit the highest instability in the genome. These highly similar sequences across non-homologous chromosomes are the main hotspots for inaccurate recombination during meiosis, known as Non-Allelic Homologous Recombination (NAHR). This process can lead to large-scale rearrangements like deletions, duplications, or segmental duplication amplification, which are implicated in many genetic syndromes and intellectual disabilities. Studying subtelomeres is crucial for understanding how gene replication and transcription are regulated in the immediate vicinity of the telomeres. Sequence comparison aids in elucidating the mechanisms by which chromosomes maintain their length and integrity despite the constant risk of incorrect DNA repair.

## Workflow
wdl
