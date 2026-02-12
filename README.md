# Drug Repurposing

This package provides a set of tools for analyzing genetic data from disease and drug studies to identify potential new uses for existing drugs, in other words, it serves as a drug repurposing system.\
An interesting application involves using genetic data from currently untreatable diseases to generate a list of candidate drugs for their treatment. The obtained results must then be validated in the laboratory.\
The basic idea is to analyze the sequencing of four transcriptomes from: healthy sample, diseased sample, diseased sample treated with a control vehicle, and diseased sample treated with drugs, in order to identify potential connections between drugs and diseases.\
This technique, known as "transcriptome signature reversion," has already been proposed and validated in several studies (e.g., [1,2]).\
The software presented in this package is based on the publications:


  1. Validation of transcriptome signature reversion for drug repurposing in oncology - Karel K. M. Koudijs et al. - 2022.
  2. Reversal of cancer gene expression correlates with drug efficacy and reveals therapeutic targets – Bin Chen et al. - 2017.

The repository accompanying the first article by Karel K. M. Koudijs et al., available at [https://gitlab.com/k.k.m.koudijs/TSR-comprehensive-validation](https://gitlab.com/k.k.m.koudijs/TSR-comprehensive-validation),
was used as the starting point for the development of DrugRepurposing.\
\
The core class for drug repurposing, `BinChenCMapScoreByDrugRank`, was extracted from the software accompanying the second article by Bin Chen et al., available at [https://github.com/Bin-Chen-Lab/RGES](https://github.com/Bin-Chen-Lab/RGES).\
\
The transcriptome reversion system provided in this package implements the same mathematical model described by Karel K. M. Koudijs et al., but with significantly more efficient computational procedures. Thanks to concurrent programming, optimized algorithms, and the use of the Julia programming language, the new software is up to 70 times faster than the original version developed by Koudijs. However, the support of parallel processing is fully supported only on unix like systems.

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
* LINCS [4] Level 3 data exploration

Custom behaviors can be introduced through the strategy design pattern, allowing experienced users to adapt components for specific research needs.
The package includes a comprehensive suite of unit tests that serve as usage examples and facilitate reproducibility.

### Integration with LINCS [4]
The Common Fund’s Library of Integrated Network-based Cellular Signatures (LINCS).
This package provides many classes to analyze the level 3 of LINCS dataset. 


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
LMMDGEDream
LMMDGEDreamWithEBayes
LMMDGEJulia
LMMDGELmer
LMMVoomDGEDream
LMMVoomDGEDreamWithEBayes
LMMVoomDGEJulia
LMMVoomDGELmer
GEORNASeqLMMVoomDGEDream
GEORNASeqLMMVoomDGEDreamWithEBayes
GEORNASeqLMMVoomDGEJulia
GEORNASeqLMMVoomDGELmer
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
