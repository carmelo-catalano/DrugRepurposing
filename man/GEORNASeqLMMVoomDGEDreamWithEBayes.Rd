\name{GEORNASeqLMMVoomDGEDreamWithEBayes}
\alias{GEORNASeqLMMVoomDGEDreamWithEBayes}
\title{Computes differential gene expression analysis using LMM with Voom-transformed data}
\description{
Derived class of \code{GEORNASeqLMMVoomDGEAbstract}.
\cr
Computes the Voom Linear Mixed Model (LMM) differential gene expression (DGE) analysis using the
\code{dream} function from the \code{variancePartition} package.
\cr
After the \code{dream} computation is completed "Empirical Bayes Statistics for Differential Expression"
are applied (\code{variancePartition::eBayes}).
\cr
The input consists of two groups of RNA-Seq data from tissues under different conditions:
control/altered state. For example, a disease-affected group and a control group.
\cr
Unlike the dichotomous case, where groups are divided only into "control/altered state," additional conditions
exist under which the experiments were conducted. For instance, multiple RNA plates were used, or
tissues originated from different parts of the body.
\cr
RNA data must follow a negative binomial distribution, typically data from RNA-Seq-like analyses.
\cr
The input RNA-Seq data file is sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
\cr
For more details, see \code{GEORNASeqLMMVoomDGECore}.
}
\usage{
geoRNASeqLMMVoomDGEDreamWithEBayes <- GEORNASeqLMMVoomDGEDreamWithEBayes$new()
result <- geoRNASeqLMMVoomDGEDreamWithEBayes$compute(
  rna_seq_data_filename, rna_seq_metadata, formula,
  filter_by_protein_coding
)
}
\arguments{
  The \code{compute} function arguments are identical to those in GEORNASeqLMMVoomDGEAbstract.

  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{GeneFilterAbstract}.
      \item Default value: Instance of class \code{LowCountsGeneFilter}.
    }
  }
}
\value{
Same as in GEORNASeqLMMVoomDGEAbstract.
}
\examples{
# Input data are the same as in GEORNASeqLMMVoomDGECore.

geoRNASeqLMMVoomDGEDreamWithEBayes <- GEORNASeqLMMVoomDGEDreamWithEBayes$new()
geoRNASeqLMMVoomDGEDreamWithEBayes$compute(
    rna_seq_data_filename, rna_seq_metadata, formula,
    filter_by_protein_coding
 )

# output is the same as in GEORNASeqLMMVoomDGECore
}
