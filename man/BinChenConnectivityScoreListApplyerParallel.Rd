\name{BinChenConnectivityScoreListApplyerParallel}
\alias{BinChenConnectivityScoreListApplyerParallel}
\title{Parallel Implementation of the Connectivity Score Computation}
\description{
    Implementation of the abstract class \code{\link{BinChenConnectivityScoreListApplyerAbstract}} for
    the constructor parameter \code{binChenConnectivityScoreListApplyer} of the class \code{BinChenDiseaseDrugListConnectivityScoreCore}. \cr
    This class computes the connectivity score for all input drugs and performs parallel computation using the \code{\%dopar\%} statement.\cr
    It is identical to \code{BinChenConnectivityScoreListApplyerSync}, except for the parallel computation.
}
\usage{
    BinChenConnectivityScoreListApplyerParallel$new()
    BinChenConnectivityScoreListApplyerParallel$compute(disease_signature_down_regulated_genes,
    disease_signature_up_regulated_genes, drugs, random_connectivity_score_distribution)
}
\arguments{
 \item{drugSignatureLoader (constructor argument)}{
    Loader for drug signatures provided in the \code{drug_signatures} argument.
    \cr
    This class uses the \code{signature_reference} column of the \code{drug_signatures} table to load the drug signature.
    \cr
    The \code{signature_reference} field may contain either the signature itself or a reference to it (e.g., a filename).
    \itemize{
      \item Type: class derived from \code{\link{DrugSignatureLoaderAbstract}}.
      \item Default value: Instance of class \code{\link{DrugSignatureLoaderByFilename}}.
    }
  }
  \item{Other arguments}{
    Same as \code{BinChenConnectivityScoreListApplyerAbstract}.
  }
}
\value{
Data frame. Columns: \code{drug name}, \code{connectivity score}, \code{p.value}.
}
\examples{
binChenConnectivityScoreListApplyerParallel <- BinChenConnectivityScoreListApplyerParallel$new()
disease_signature_down_regulated_genes <- data.frame(gene_id = c(1, 2, 18))
disease_signature_up_regulated_genes <- data.frame(gene_id = c(3, 17))
drugs <- data.frame(name = c("A-23187", "A-443644", "AG-490"),
                    filename = c("A-23187.rds", "A-443644.rds", "AG-490.rds"))
random_connectivity_score_distribution <- c(0.123, -0.56789, 0.8912763, 0.1357, -0.4754)
binChenConnectivityScoreListApplyerParallel$compute(disease_signature_down_regulated_genes,
                                                               disease_signature_up_regulated_genes,
                                                               drugs,
                                                               random_connectivity_score_distribution)
# output
# drug                connectivity_score   p.value
# A-23187             0.20828369           0.90688
# AG-490              0.04242417           0.66417
# AKT-inhibitor-1-2   -0.11393820          0.25596
# AM-404              0.31814264           0.99762
# A-443644            -0.07763290          0.27676
# AG-494              0.38102364           0.99993
# AG-957              0.16303776           0.80283
}
