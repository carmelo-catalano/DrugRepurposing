# Drug Repurposing

This R package is designed for transcriptome-based drug repurposing through the analysis of gene expression data from disease and pharmacological studies. 

The objective is to identify candidate compounds that may reverse disease-related gene expression patterns, offering novel therapeutic applications for existing drugs.

The core methodology of the package relies on transcriptome signature inversion, a strategy validated in prior literature [1,2] and draws direct inspiration from the reference application developed by Koudijs, available at:
https://gitlab.com/k.k.m.koudijs/TSR-comprehensive-validation. 

This approach compares differential gene expression (DGE) profiles of diseased tissues with those of drug-treated tissues to identify compounds whose transcriptional effects are inversely correlated with disease signatures.

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
LINCSRDSLMMDrugDGEJuliaParallel
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