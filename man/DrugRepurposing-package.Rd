\name{DrugRepurposing-package}
\alias{DrugRepurposing}
\alias{DrugRepurposing-package}
\docType{package}
\title{Drug Repurposing System}
\description{
  \code{DrugRepurposing} Drug repurposing system based on differential expression analysis of RNA-seq expression profiles
}
\section{Package}{
  This package provides a set of tools for analyzing genetic data from disease and drug studies to identify potential new uses for existing drugs, in other words, it serves as a drug repurposing system.
  \cr
  An interesting application involves using genetic data from currently untreatable diseases to generate a list of candidate drugs for their treatment. The obtained results must then be validated in the laboratory.
  \cr
  The basic idea is to analyze the sequencing of four transcriptomes from: healthy tissue, diseased tissue, diseased tissue treated with a control vehicle, and diseased tissue treated with drugs, in order to identify potential connections between drugs and diseases.
  \cr
  This technique, known as "transcriptome signature reversion," has already been proposed and validated in several studies.
  \cr
  The software presented in this package is based on the publications:
  \itemize{
    \item	Validation of transcriptome signature reversion for drug repurposing in oncology - Karel K. M. Koudijs et al - 2022.
    \item Reversal of cancer gene expression correlates with drug efficacy and reveals therapeutic targets – Bin Chen et al - 2017.
  }
  The transcriptome reversion system proposed in this package generalizes and evolves the mathematical model described by Karel K. M. Koudijs et al implementing significantly more efficient computational procedures. Thanks to concurrent programming and the adoption of optimized algorithms, the new software is up to seventy times faster than the original version.
  \cr
  The mathematical model was expanded in order to provide a function that would also allow genetic studies of diseases that affect multiple parts of the body, such as amyotrophic lateral sclerosis, to be analyzed accurately.
  \cr
  Studies of diseases such as ALS provide genetic data from different parts of the body, for example: Cerebellum, Spinal Cord Cervical, Cortex Sensory, Spinal Cord Lumbar.
  \cr
  The computational procedures for connectivity score and linear mixed models were greatly optimized using parallel computation and Julia programming language. However, the support of parallel computation is fully supported only on unix like systems.
}
\section{Package architecture}{
  The package is entirely developed following the OOP paradigm through the use of the R6 library.
  \cr
  DrugRepurposing provides more than 80 classes that can be composed at will to perform differential gene expression analysis of RNA data and calculate the connectivity score between diseases and drugs in order to find new uses for existing drugs.
  \cr
  The library provides ready-made classes for calculating the connectivity score or DGE, but thanks to the use of the “strategy pattern”, the behavior of the available classes can be customized.
  \cr
  In the package code, there are more than eighty tests that can be taken as examples for the use of the library itself.
}
\section{Abstract Classes}{
  In order to make the software structure clearer and facilitate the use of the “strategy pattern”, pseudo-abstract classes have been created to mimic the behavior of abstract classes found in more structured languages than R, such as C++ or Java.
  \cr
  These classes allow constructor parameters to be “typed” preventing the use of collaborators of the wrong type. As an example, one can see the lmmVoomDGE parameter of the constructor of the GEORNASeqLMMVoomDGE class.
}
\section{Suggestion}{
  For better use of this package, it is recommended to consult the code at:
  \cr
  \href{https://github.com/carmelo-catalano/DrugRepurposing/tree/main/R}{https://github.com/carmelo-catalano/DrugRepurposing/tree/main/R}
  \cr
  and to use the tests at:
  \cr
  \href{https://github.com/carmelo-catalano/DrugRepurposing/tree/main/tests/testthat}{https://github.com/carmelo-catalano/DrugRepurposing/tree/main/tests/testthat}
  \cr
  as guidelines for developing software based on DrugRepurposing.
}
\section{Basic Libraries}{
  Statistical analyses are performed using the following libraries: limma, lme4, dream, and the Julia programming language.
}
\section{Julia}{
  To achieve a significant performance boost in the calculation of mixed linear models, the Julia programming lamguage has been utilized. DrugRepurposing is able to invoke Julia's fit function, which makes it possible to compute linear mixed models up to 70 times faster than lmer.
  \cr
  The porting between R and Julia is accomplished through the JuliaCall library.
}
\section{Julia installation}{
  For Julia environment installation, see: https://julialang.org/.
  \cr
  After installing Julia on your system, you need to install the Julia packages MixedModels and DataFrames:

  \code{import Pkg;
  Pkg.add("MixedModels")
  Pkg.add("DataFrames")
  }

}
\section{Troubleshooting Julia Integration with R}{
  If your R environment is unable to locate the Julia installation, you may need to configure the JULIA_HOME environment variable. Try one or both of the following instructions:
  \itemize{
    \item Option 1: Set JULIA_HOME within R
    options(JULIA_HOME = "/your-julia-installation-folder/bin/")
    This command sets the JULIA_HOME option within your current R session, pointing to the Julia executable. To make it persistent, you can add this line to your .Rprofile file.
    \item Option 2: Set JULIA_HOME in your system environment
    Bash
    export JULIA_HOME=/your-julia-installation-folder/bin/
    This command sets the JULIA_HOME environment variable for your current shell session. You might need to add this line to your shell's configuration file (e.g., .bashrc, .zshrc) to make it permanent.
    }
}
\section{Main classes}{
\strong{Drug repurposing}\cr
DichotomicDrugRepurpose\cr
DichotomicVoomDrugRepurpose\cr
GEORNASeqDichotomicVoomDrugRepurpose\cr
LMMDrugRepurpose\cr
LMMVoomDrugRepurpose\cr
GEORNASeqLMMVoomDrugRepurpose\cr
\cr
\strong{Connectivity score}\cr
BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade\cr
BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade\cr
\cr
\strong{Dichotomic differential gene expression}\cr
DichotomicDGE\cr
DichotomicVoomDGE\cr
GEORNASeqDichotomicVoomDGE\cr
\cr
\strong{LMM differential gene expression}\cr
LMMDreamDGE\cr
LMMJuliaDGE\cr
LMMLmerDGE\cr
LMMVoomDreamDGE\cr
LMMVoomJuliaDGE\cr
LMMVoomLmerDGE\cr
GEORNASeqLMMVoomDreamDGE\cr
GEORNASeqLMMVoomJuliaDGE\cr
GEORNASeqLMMVoomLmerDGE\cr
LINCSRDSLMMDrugDGEJulia\cr
LINCSRDSLMMDrugDGEJuliaClusters\cr
LINCSRDSLMMDrugDGELmer\cr
\cr
\strong{Metanalysis}\cr
DGEMetanalysisByMatrix\cr
\cr
\strong{LINCS GCTX archive export}\cr
LINCSExport

}
