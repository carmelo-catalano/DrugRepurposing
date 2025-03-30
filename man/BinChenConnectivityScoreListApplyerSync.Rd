\name{BinChenConnectivityScoreListApplyerSync}
\alias{BinChenConnectivityScoreListApplyerSync}
\title{Synchronous Implementation of the Connectivity Score Computation}
\description{
Implementation of the abstract class \code{BinChenConnectivityScoreListApplyerAbstract} for the constructor parameter \code{binChenConnectivityScoreListApplyer} of the class \code{BinChenDiseaseDrugListConnectivityScoreCore}. \cr
This class computes the connectivity score for all input drugs using synchronous computation.
It is identical to \code{BinChenConnectivityScoreListApplyerSync}, except for the synchronous computation.
}
\usage{
BinChenConnectivityScoreListApplyerSync$new()
BinChenConnectivityScoreListApplyerSync$compute(disease_signature_down_regulated_genes,
disease_signature_up_regulated_genes, drugs, random_connectivity_score_distribution)
}
\arguments{
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug DGEs in the argument \code{drugs}.
    \itemize{
      \item Type: class derived from \code{DrugSignatureLoaderAbstract}
      \item Default value: \code{NA}
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
binChenConnectivityScoreListApplyerSync <- BinChenConnectivityScoreListApplyerSync$new()
disease_signature_down_regulated_genes <- data.frame(gene_id = c(1, 2, 18))
disease_signature_up_regulated_genes <- data.frame(gene_id = c(3, 17))
drugs <- data.frame(name = c("A-23187", "A-443644", "AG-490"),
                    filename = c("A-23187.rds", "A-443644.rds", "AG-490.rds"))
random_connectivity_score_distribution <- c(0.123, -0.56789, 0.8912763, 0.1357, -0.4754)
binChenConnectivityScoreListApplyerSync$compute(disease_signature_down_regulated_genes,
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
