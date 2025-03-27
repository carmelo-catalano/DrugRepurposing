\name{BinChenConnectivityScoreListApplyerAbstract}
\alias{BinChenConnectivityScoreListApplyerAbstract}
\title{Base Class for Computing Connectivity Score for All Input Drugs}
\description{
Base class for the constructor parameter \code{binChenConnectivityScoreListApplyer} of the class \code{BinChenDiseaseDrugListConnectivityScoreCore}.\cr
This class computes the connectivity score for all input drugs.\cr
The package includes two implementations: \code{BinChenConnectivityScoreListApplyerParallel} and \code{BinChenConnectivityScoreListApplyerSync}.

}
\usage{
BinChenConnectivityScoreListApplyerAbstract$new()
BinChenConnectivityScoreListApplyerAbstract$compute(disease_signature_down_regulated_genes,
disease_signature_up_regulated_genes, drugs, random_connectivity_score_distribution)
}
\arguments{
  \item{disease_signature_down_regulated_genes}{
    Disease signature down-regulated genes.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{disease_signature_up_regulated_genes}{
    Disease signature up-regulated genes.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{drugs}{
    Drug signatures.\cr A table containing the drug names and their corresponding DGE filenames.
    The files must be in RDS format.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name} (drug name), \code{filename} (drug DGE filename)
    }
  }
  \item{random_connectivity_score_distribution}{
    Random connectivity score distribution.
    \code{random_connectivity_score_distribution} is compared with connectivity score for p-value computation.
    \itemize{
      \item Type: \code{numeric vector}
    }
  }
}
\value{
\code{data.frame}. \code{drug name}, \code{connectivity score}, \code{p.value}.\cr
See example in \code{BinChenConnectivityScoreListApplyerParallel} “Usage section”.
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
      # Example implementation for connectivity score computation
      do something
    }
  )
)
}
