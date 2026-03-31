\name{BinChenConnectivityScoreListApplyerAbstract}
\alias{BinChenConnectivityScoreListApplyerAbstract}
\title{Base Class for Computing Connectivity Score for All Input Drugs}
\description{
Base class for the constructor parameter \code{binChenConnectivityScoreListApplyer} of the class \code{link{BinChenDiseaseDrugListConnectivityScoreCore}}.\cr
This class computes the connectivity score for all input drugs.\cr
The package includes two implementations: \code{link{BinChenConnectivityScoreListApplyerParallel}} and \code{link{BinChenConnectivityScoreListApplyerSync}}.
}
\usage{
BinChenConnectivityScoreListApplyerImpl <- R6Class(
  "BinChenConnectivityScoreListApplyerImpl",
  inherit = BinChenConnectivityScoreListApplyerAbstract,
  public = list(
    compute = function(disease_signature_down_regulated_genes,
                       disease_signature_up_regulated_genes,
                       drugs,
                       random_connectivity_score_distribution) {
      # do something
    }
  )
)
}
\arguments{
  \item{disease_signature_down_regulated_genes}{
    Disease signature down-regulated genes. The genes are ordered by decreasing absolute value of the estimate.\cr
    See \link{Gene-expression-signature} for more details.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{disease_signature_up_regulated_genes}{
    Disease signature up-regulated genes. The genes are ordered by decreasing absolute value of the estimate.\cr
    See \link{Gene-expression-signature} for more details.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{drug_signatures}{
    A table (data.frame) containing drug signatures.
    It must contain two columns:
    \itemize{
        \item \code{name}: The name of the drug.
        \item \code{signature_reference}: Either a data.frame containing the \link{Gene-expression-signature}, or a reference (e.g., a filename) used by the signature loader class to retrieve the data.
    }
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name} (drug name), \code{signature_reference}
    }
  }
  \item{random_connectivity_score_distribution}{
    Random connectivity score distribution.\cr
    \code{random_connectivity_score_distribution} is compared with connectivity score for p-value computation.\cr
    See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details.
    \itemize{
      \item Type: \code{numeric vector}
    }
  }
}
\value{
\code{data.frame}. \code{drug name}, \code{connectivity score}, \code{p.value}.\cr
See example in \code{BinChenConnectivityScoreListApplyerParallel}.
}
\examples{
BinChenConnectivityScoreListApplyerImpl <- R6Class(
  "BinChenConnectivityScoreListApplyerImpl",
  inherit = BinChenConnectivityScoreListApplyerAbstract,
  public = list(
    compute = function(disease_signature_down_regulated_genes,
                       disease_signature_up_regulated_genes,
                       drugs,
                       random_connectivity_score_distribution) {
      # do something
    }
  )
)
}
