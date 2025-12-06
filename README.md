# Drug Repurposing

This R package is designed for transcriptome-based drug repurposing through the analysis of gene expression data from disease and pharmacological studies. 

The objective is to identify candidate compounds that may reverse disease-related gene expression patterns, offering novel therapeutic applications for existing drugs.

The core methodology of the package relies on transcriptome signature inversion, a strategy validated in prior literature [1,2] and draws direct inspiration from the reference application developed by Koudijs, available at:
https://gitlab.com/k.k.m.koudijs/TSR-comprehensive-validation. 

This approach compares differential gene expression (DGE) profiles of diseased tissues with those of drug-treated tissues to identify compounds whose transcriptional effects are inversely correlated with disease signatures.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DrugRepurposing")
```

### Required packages
R6, log4r, data.table, R.utils, edgeR, variancePartition, readr, parallel, doParallel, metafor, JuliaCall, lme4, cmapR, PharmacoGx, tibble, testthat.


### Julia

To achieve a significant performance boost in the calculation of mixed linear models, the Julia programming language has been utilized. DrugRepurposing is able to invoke Julia's [fit] function, which makes it possible to compute linear mixed models up to 70 times faster than lmer.
The porting between R and Julia is accomplished through the JuliaCall library.


### Julia installation

For Julia environment installation, see: https://julialang.org/.
After installing Julia on your system, you need to install the Julia packages MixedModels and DataFrames:
```
import Pkg;
Pkg.add("MixedModels")
Pkg.add("DataFrames")
```

### Troubleshooting Julia Integration with R
If your R environment is unable to locate the Julia installation, you may need to configure the JULIA_HOME environment variable. Try one or both of the following instructions:

* Option 1: Set JULIA_HOME within R  
```options(JULIA_HOME = "/your-julia-installation-folder/bin/") ```  
This command sets the JULIA_HOME option within your current R session, pointing to the Julia executable. To make it persistent, you can add this line to your .Rprofile file.


* Option 2: Set JULIA_HOME in your system environment  
Bash  
```export JULIA_HOME=/your-julia-installation-folder/bin/```  
This command sets the JULIA_HOME environment variable for your current shell session.  
You might need to add this line to your shell's configuration file (e.g., .bashrc, .zshrc) to make it permanent.

### Algorithmic Overview
The implemented repurposing pipeline consists of four principal stages:
1.	**Disease DGE Generation**. DGE is computed between diseased and healthy tissues using either a dichotomic or linear mixed model (LMM)-based method, depending on study design and available metadata.


2.	**Drug DGE Generation**. DGE is computed for tissues exposed to drugs versus vehicle-treated controls. This step is repeated for each compound under evaluation.


3.	**Signature Generation**. The most differential expressed genes are selected using either:
* the top n genes ranked by absolute t-value (typically 50–150), or  


* genes with adjusted p-value < 0.001 and absolute log fold change above a specified threshold (e.g., 1.5).
4.	Connectivity Score Computation. A connectivity score is calculated to quantify the degree of inversion between the disease and drug signatures. A negative score suggests potential therapeutic relevance, indicating that the drug may reverse the disease gene expression pattern.


### Differential Expression Models
The package provides two classes of DGE methods:
* Dichotomic Models for pairwise comparisons (e.g., disease vs. control).
* Linear Mixed Models (LMM) for analyses involving additional factors such as tissue origin.

Support is provided for data following both normal distributions (e.g., microarray) and negative binomial distributions (e.g., RNA-Seq), with RNA-seq data requiring a preprocessing step via the voom transformation.


### Connectivity Score Calculation
The connectivity score algorithm is based on the model proposed by Lamb et al. [3] and refined by Chen et al. [2], the latter being the recommended implementation due to its robustness and specificity.  
Scores range from -1 (perfect inverse correlation) to +1 (direct correlation). Drugs with strongly negative scores are prioritized as repurposing candidates.

### Software Architecture
The package is entirely developed following the OOP paradigm through the use of the R6 library. It provides a modular and extensible architecture. Over 80 classes are available, supporting:
* DGE calculation
* Connectivity Score analysis
* LINCS Level 3 data exploration

Custom behaviors can be introduced through the strategy design pattern, allowing experienced users to adapt components for specific research needs.
The package includes a comprehensive suite of unit tests that serve as usage examples and facilitate reproducibility.

### Integration with LINCS
The Common Fund’s Library of Integrated Network-based Cellular Signatures (LINCS).
This package provides many classes to analyse the level 3 of LINCS dataset. 


## Performance and Scalability
DrugRepurposing generalizes and extends the mathematical model proposed by Koudijs et al. [1], with major improvements in computational efficiency. Through concurrent programming and algorithmic optimizations, performance is increased by 60–70× relative to the original implementation.

## Disease Modeling under different conditions (using LMM)
The software is particularly suitable for RNA-seq analysis under different conditions, for example multi-tissue RNA-seq studies of complex diseases such as amyotrophic lateral sclerosis (ALS). ALS data often include samples from diverse anatomical regions (e.g., cerebellum, cervical and lumbar spinal cord, sensory cortex), enabling comprehensive transcriptomic modeling across tissues.


## Main classes

### Drug repurposing
```
DichotomicDrugRepurpose
DichotomicVoomDrugRepurpose
GEORNASeqDichotomicVoomDrugRepurpose
LMMDrugRepurpose
LMMVoomDrugRepurpose
GEORNASeqLMMVoomDrugRepurpose
```

### Connectivity score 
```
BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade
BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade
```

### Dichotomic differential gene expression
```
DichotomicDGE
DichotomicVoomDGE
GEORNASeqDichotomicVoomDGE
```

### LMM differential gene expression
```
LMMDreamDGE
LMMJuliaDGE
LMMLmerDGE
LMMVoomDreamDGE
LMMVoomJuliaDGE
LMMVoomLmerDGE
GEORNASeqLMMVoomDreamDGE
GEORNASeqLMMVoomJuliaDGE
GEORNASeqLMMVoomLmerDGE
LINCSRDSLMMDrugDGEJulia
LINCSRDSLMMDrugDGEJuliaClusters
LINCSRDSLMMDrugDGELmer
```

### Metanalysis
```
DGEMetanalysisByMatrix
```

### LINCS GCTX archive export
```
LINCSExport
```

## References
1.	Koudijs K.K.M. et al. Validation of transcriptome signature reversion for drug repurposing in oncology. Briefings in Bioinformatics, 2022.
2.	Chen B. et al. Reversal of cancer gene expression correlates with drug efficacy and reveals therapeutic targets. Nature Communications, 2017; 8:16022.
3.	Lamb J. et al. The Connectivity Map: using gene-expression signatures to connect small molecules, genes, and disease. Science, 2006; 313(5795):1929–1935.
4.	Keenan A.B. et al. The Library of Integrated Network-Based Cellular Signatures NIH Program: System-Level Cataloging of Human Cells Response to Perturbations. Cell Systems, 2018; 6.
