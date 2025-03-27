\name{BinChenConnectivityScoreListApplyerParallel}
\alias{BinChenConnectivityScoreListApplyerParallel}
\title{Parallel Implementation of the Connectivity Score Computation}
\description{
Implementation of the abstract class \code{BinChenConnectivityScoreListApplyerAbstract} for the constructor parameter \code{binChenConnectivityScoreListApplyer} of the class \code{BinChenDiseaseDrugListConnectivityScoreCore}. This class computes the connectivity score for all input drugs and performs parallel computation using the \code{\%dopar\%} statement.
}
\usage{
BinChenConnectivityScoreListApplyerParallel$new()
BinChenConnectivityScoreListApplyerParallel$compute(disease_signature_down_regulated_genes, 
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
A \code{data.frame} with columns: \code{drug name}, \code{connectivity score}, \code{p.value}.
}
\examples{
binChenConnectivityScoreListApplyerParallel <- BinChenConnectivityScoreListApplyerParallel$new()
disease_signature_down_regulated_genes <- data.frame(gene_id = c(1, 2, 18))
disease_signature_up_regulated_genes <- data.frame(gene_id = c(3, 17))
drugs <- data.frame(name = c("A-23187", "A-443644", "AG-490"),
                    filename = c("A-23187.rds", "A-443644.rds", "AG-490.rds"))
random_connectivity_score_distribution <- c(0.123, -0.56789, 0.8912763, 0.1357, -0.4754)
result <- binChenConnectivityScoreListApplyerParallel$compute(disease_signature_down_regulated_genes, 
                                                               disease_signature_up_regulated_genes, 
                                                               drugs, 
                                                               random_connectivity_score_distribution)
print(result)
}
