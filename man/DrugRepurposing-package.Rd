\name{DrugRepurposing-package}
\alias{DrugRepurposing}
\alias{DrugRepurposing-package}
\docType{package}
\title{Drug Repurposing System}
\description{
  \code{DrugRepurposing} Drug repurposing system based on differential expression analysis of RNA expression profiles
  \cr\cr
}
\section{Package}{
    This package provides a set of tools for analyzing genetic data from disease and drug studies to identify potential
    new uses for existing drugs, in other words, it serves as a drug repurposing system.
    \cr
    An interesting application involves using genetic data from currently untreatable diseases to
    generate a list of candidate drugs for their treatment. The obtained results must then be validated in the laboratory.
    \cr
    The basic idea is to analyze the sequencing of four transcriptomes from: healthy sample, diseased sample,
    diseased sample treated with a control vehicle, and diseased sample treated with drugs, in order
    to identify potential connections between drugs and diseases.
    \cr
    This technique, known as "transcriptome signature reversion," has already been proposed and validated
    in several studies.
    \cr
    The software presented in this package is based on the publications:
    \itemize{
        \item Validation of transcriptome signature reversion for drug repurposing in oncology - Karel K. M. Koudijs et al. - 2022.
        \item Reversal of cancer gene expression correlates with drug efficacy and reveals therapeutic targets – Bin Chen et al. - 2017.
    }
    The repository accompanying the first article by Karel K. M. Koudijs et al., available at \href{https://gitlab.com/k.k.m.koudijs/TSR-comprehensive-validation}{https://gitlab.com/k.k.m.koudijs/TSR-comprehensive-validation},
    was used as the starting point for the development of DrugRepurposing.
    \cr
    Alternatively to \code{BinChenCMapScoreByDrugRank} is possible to use \code{connectivityScore} from \code{PharmacoGx}.
    \cr
    The core class for drug repurposing, \code{BinChenCMapScoreByDrugRank}, was extracted from the software accompanying the
    second article by Chen et al., available at \href{https://github.com/Bin-Chen-Lab/RGES}{https://github.com/Bin-Chen-Lab/RGES}.
    \cr
    The transcriptome reversion system provided in this package implements the same mathematical model
    described by Karel K. M. Koudijs et al., but with significantly more efficient computational
    procedures. Thanks to concurrent programming, optimized algorithms, and the use of the Julia
    programming language, the new software is up to 70 times faster than the original version
    developed by Koudijs. However, the support of parallel processing is fully supported only on unix
    like systems.
    \cr\cr
}
\section{Drug repurposing analysis}{
    The implemented repurposing pipeline consists of four principal stages:
    \itemize{
        \item \strong{Disease DGE Generation}. DGE is computed between diseased and healthy samples using either a dichotomic or linear mixed model (LMM)-based method, depending on study design and available metadata.
        \item \strong{Drug DGE Generation}. DGE is computed for samples exposed to drugs versus vehicle-treated controls. This step is repeated for each compound under evaluation.
        \item \strong{Signature Generation}. The most differential expressed genes are selected using either:
        \itemize{
            \item the top n genes ranked by absolute t-value (typically 50–150), or
            \item genes with adjusted p-value < 0.001 and absolute log fold change above a specified threshold (e.g., 1.5).
        }
        \item \strong{Connectivity Score Computation}. A connectivity score is calculated to quantify the degree of inversion between the disease and drug signatures. A negative score suggests potential therapeutic relevance, indicating that the drug may reverse the disease gene expression pattern.
    }
    \cr
}
\section{Connectivity Score}{
    The connectivity score represents the correlation between the disease and the drug. The score ranges from -1 to +1.
    \cr
    A positive value indicates that the drug behaves similarly to the disease.
    \cr
    A negative value indicates that the drug behaves conversely to the disease.
    \cr
    A higher positive score implies stronger correlation, while a higher negative score
    indicates greater anticorrelation. Drugs with strongly negative scores are prioritized as repurposing candidates.
    \cr\cr
}

\section{Connectivity Score Calculation}{
    The connectivity score algorithm is based on the model proposed by Lamb et al. [3] and refined by
    Chen et al. [2], the latter being the recommended implementation due to its robustness and specificity.
    \cr\cr
}
\section{Differential Expression Models}{
    The package provides two classes of DGE methods:
    \itemize{
      \item Dichotomic Models for pairwise comparisons (e.g., disease vs. control).
      \item Linear Mixed Models (LMM) for analyses involving additional factors such as tissue origin.
    }
    Support is provided for data following both normal distributions (e.g., microarray) and negative binomial distributions (e.g., RNA-Seq), with RNA-Seq data requiring a preprocessing step via the voom transformation.
    \cr\cr
}
\section{Differential Gene Expression (DGE) analysis}{
    This package provides four types of functions to compute differential gene expression (DGE) for four different types of RNA data:
    \itemize{
        \item \strong{RNA data counts following a "negative binomial distribution" (typically RNA-Seq data) with a single condition "altered state/control state"}.
        \cr
        These functions are based on the voom transformation and \code{lmFit} from the \code{limma} package.
        \cr
        They are referred to as Dichotomic voom DGE.

        \item \strong{RNA data counts following a "negative binomial distribution" (typically RNA-Seq data) (typically RNA-Seq data) with additional conditions beyond the base "altered state/control state"}.
         \cr
         For example, in a disease analysis, samples may also differ by tissue of origin in addition to the "altered state/control state" condition.
        \cr
        These functions are based on the voom transformation and Linear Mixed Models (LMM).
        \cr
        The Linear Mixed Model is computed using one of the following functions: \code{lmer} from \code{lme4}, \code{dream} from \code{variancePartition}, or \code{fit} from Julia programming language.
        \cr
        They are referred to as LMM voom DGE.

        \item \strong{RNA data log-counts following a "normal distribution" (typically microarray data) with a single condition "altered state/control state"}.
        \cr
        These functions are based on \code{lmFit} from the limma package.
        \cr
        They are referred to as Dichotomic DGE.

        \item \strong{RNA data log-counts following a "normal distribution" (typically microarray data) with additional conditions beyond the base "altered state/control state"}.
        \cr
        For example, in a disease analysis, samples may differ by tissue of origin in addition to the "altered/control condition".
        \cr
        These functions are based on Linear Mixed Models (LMM).
        \cr
        The Linear Mixed Model is computed using one of the following functions: \code{lmer} from \code{lme4}, \code{dream} from \code{variancePartition}, or \code{fit} from Julia programming language.
        \cr
        They are referred to as LMM DGE.
    }
    For further information about voom, see:
    \cr
    voom: Precision weights unlock linear model analysis tools for RNA-Seq read counts - Charity W Law, Yunshun Chen, Wei Shi, Gordon K Smyth - 2014
    \cr\cr
}

\section{DGE format}{
    The DGE output format of DGE functions is a data.frame containing the following columns:\cr
    \code{gene_id} = Unique NCBI Gene ID\cr
    \code{DE_log2_FC} = Differential expression expressed as the log2 fold change\cr
    \code{std.error} = \code{DE_log2_FC / t.value}\cr
    \code{t.value} = moderated t-statistic\cr
    \code{p.value} = p-value\cr
    \code{adj.p.value} = adjusted p-values calculated using the Benjamini-Hochberg (BH) method.\cr
    \cr
    \strong{Note: DGEs calculated using \code{lmer} from the \code{lme4} package do not include the
    \code{p.value} and \code{adj.p.value} columns due to limitations of \code{lmer}.}
    \cr
    For an example see \link{DGE}
    \cr\cr
}

\section{Gene expression signature}{
    A table containing a subset of the disease \link{DGE} corresponding to the n most significant genes.
    A typical value of n ranges from 50 to 300.\cr
    Only two columns from the original \link{DGE} are retained: \code{gene_id} and \code{t.value}.\cr
    The table is structured as a data.frame with two columns:
    \itemize{
        \item The first column, named "gene_id", contains the gene identifiers.
        \item The second column, named "estimate", contains the t-value.
    }
    The "estimate" column represents a gene-level statistic derived from the DGE analysis.\cr
    This package adopts the convention defined by Koudijs et al. [1], in which the t-value is used as the expression estimate.
    In contrast, the implementation by Chen et al. [2] uses the log fold change.\cr
    \strong{Note}: For connectivity score computation, the "estimate" value is needed.
    The sign of the "estimate" indicates the status of the gene: positive = upregulated, negative = downregulated.

    \cr
    For an example see \link{Gene-expression-signature}.
    \cr\cr
}

\section{Integration with LINCS [4]}{
    The Common Fund’s Library of Integrated Network-based Cellular Signatures (LINCS).
    This package provides many classes to analyze the level 3 of LINCS dataset.
    \cr
    See \link{LINCS} for more information.
    \cr\cr

}
\section{Parallel Processing}{
    The parallel processing is controlled by the \code{processorCores} instance of the \code{ProcessorCores} class.
    Through \code{processorCores} instance, it is possible to retrieve the number of processor cores available on
    the system and to configure how many cores are used for parallel processing.
    \cr
    For more information, see the \code{ProcessorCores} documentation.
    \cr\cr
}
\section{Logging system}{
    Package logging is controlled by the \code{dgrpLogger} instance of the \code{DGRPLogger} class.
    The \code{dgrpLogger} instance allows switching the logging mode between \code{CONSOLE}, \code{FILE}, or both \code{CONSOLE} and \code{FILE}.
    It can be used to log activity and data.
    \cr
    For more information, see the \code{DGRPLogger} documentation.
    \cr\cr
}
\section{Package overview}{
    The package is entirely developed following the OOP paradigm through the use of the R6 library.
    \cr
    DrugRepurposing provides more than 80 classes that can be composed at will to perform differential gene expression analysis of RNA data and calculate the connectivity score between diseases and drugs in order to find new uses for existing drugs.
    \cr
    The library provides ready-made classes for calculating the connectivity score or DGE, but thanks to the use of the “strategy design pattern”, the behavior of the available classes can be customized.
    \cr
    In the package code, there are more than 100 tests that can be taken as examples for the use of the library itself:
    \href{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/tests/testthat}{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/tests/testthat}
    \cr\cr
}
\section{Abstract Classes}{
    In order to make the software structure clearer and facilitate the use of the “strategy design pattern”, pseudo-abstract classes have been created to mimic the behavior of abstract classes found in more structured languages than R, such as C++ or Java.
    \cr
    These classes allow constructor parameters to be “typed” preventing the use of collaborators of the wrong type. As an example, one can see the lmmVoomDGE parameter of the constructor of the GEORNASeqLMMVoomDGE class.
    \cr\cr
}
\section{Suggestion}{
    For better use of this package, it is recommended to consult the code at:
    \cr
    \href{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/tests/testthat}{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/}
    \cr
    and to use the tests at:
    \cr
    \href{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/tests/testthat}{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/tests/testthat}
    \cr
    as guidelines for developing software based on DrugRepurposing.
    \cr\cr
}
\section{Basic Libraries}{
    Statistical analyses are performed using the following libraries: limma, lme4, dream, and the Julia programming language.
    \cr\cr
}
\section{Julia}{
    To achieve a significant performance boost in the calculation of mixed linear models, the Julia
    programming language has been utilized. DrugRepurposing is able to invoke Julia's fit function,
    which makes it possible to compute linear mixed models up to 70 times faster than \code{lmer}.
    \cr
    The porting between R and Julia is accomplished through the \code{JuliaCall} library.
    \cr\cr
}
\section{Julia installation}{
    For Julia environment installation, see: https://julialang.org/.
    \cr
    After installing Julia on your system, you need to install the Julia packages MixedModels and DataFrames:

    \code{import Pkg;\cr
        Pkg.add("MixedModels")\cr
        Pkg.add("DataFrames")\cr
        Pkg.add("Suppressor")\cr
        Pkg.add("RCall")
        \cr\cr
    }
}
\section{Troubleshooting Julia Integration with R}{
    If your R environment is unable to locate the Julia installation, you may need to configure the JULIA_HOME environment variable. Try one or both of the following instructions:
    \itemize{
        \item Option 1: Set JULIA_HOME within R.\cr
        options(JULIA_HOME = "/your-julia-installation-folder/bin/")\cr
        This command sets the JULIA_HOME option within your current R session, pointing to the Julia executable. To make it persistent, you can add this line to your .Rprofile file.
        \item Option 2: Set JULIA_HOME in your system environment.\cr
        Bash\cr
        export JULIA_HOME=/your-julia-installation-folder/bin/.\cr
        This command sets the JULIA_HOME environment variable for your current shell session. You might need to add this line to your shell's configuration file (e.g., .bashrc, .zshrc) to make it permanent.
        \cr\cr
    }
}
\section{Main classes}{
    \strong{Drug repurposing}\cr
    \code{
        DichotomicDrugRepurpose\cr
        DichotomicVoomDrugRepurpose\cr
        GEORNASeqDichotomicVoomDrugRepurpose\cr
        LMMDrugRepurpose\cr
        LMMVoomDrugRepurpose\cr
        GEORNASeqLMMVoomDrugRepurpose\cr
    }
    \cr
    \strong{Connectivity score}\cr
    \code{
        BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade\cr
        BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade\cr
    }
    \cr
    \strong{Dichotomic differential gene expression}\cr
    \code{
        DichotomicDGE\cr
        DichotomicVoomDGE\cr
        GEORNASeqDichotomicVoomDGE\cr
    }
    \cr
    \strong{LMM differential gene expression}\cr
    \code{
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
    }
    \cr
    \strong{Metanalysis}\cr
    \code{
        DGEMetanalysisByMatrix\cr
    }
    \cr
    \strong{LINCS GCTX archive export}\cr
    \code{
        LINCSExport
    }
    \cr\cr
}

\section{Examples}{
  Here you can find two complete examples built on real data from NCBI \href{https://www.ncbi.nlm.nih.gov/}{https://www.ncbi.nlm.nih.gov/)}:\cr
  \href{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/examples}{https://github.com/carmelo-catalano/DrugRepurposing/tree/devel/examples}
  \cr\cr
}

\section{References}{
    \itemize{
        \item 1.	Koudijs K.K.M. et al. Validation of transcriptome signature reversion for drug repurposing in oncology. Briefings in Bioinformatics, 2022.
        \item 2.	Chen B. et al. Reversal of cancer gene expression correlates with drug efficacy and reveals therapeutic targets. Nature Communications, 2017; 8:16022.
        \item 3.	Lamb J. et al. The Connectivity Map: using gene-expression signatures to connect small molecules, genes, and disease. Science, 2006; 313(5795):1929–1935.
        \item 4.	Keenan A.B. et al. The Library of Integrated Network-Based Cellular Signatures NIH Program: System-Level Cataloging of Human Cells Response to Perturbations. Cell Systems, 2018; 6.
    }
}


