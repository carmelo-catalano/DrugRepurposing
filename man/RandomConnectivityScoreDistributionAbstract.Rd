\name{RandomConnectivityScoreDistributionAbstract}
\alias{RandomConnectivityScoreDistributionAbstract}
\title{Base class for random connectivity score distribution generation}
\description{
Base class for the \code{randomConnectivityScoreDistribution} parameter of the \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore} class.
\cr
Generates a random distribution for p-value computation, represented as a vector of floating-point numbers.
A larger distribution size provides a more accurate p-value.
\cr
This package includes two implementations: \code{RandomConnectivityScoreDistributionParallel} and \code{RandomConnectivityScoreDistributionSync}.
}
\usage{
RandomConnectivityScoreDistributionImpl <- R6Class(
  "RandomConnectivityScoreDistributionImpl",
  inherit = RandomConnectivityScoreDistributionAbstract,
  public = list(
    compute = function(
      n_disease_signature_down_regulated_genes,
      n_disease_signature_up_regulated_genes,
      n_drug_signatures_genes,
      random_distribution_size
    ) {
      # Generate random distribution
    }
  )
)
}
\arguments{
  \item{n_disease_signature_down_regulated_genes}{
    Number of down-regulated genes in the disease signature.
    \itemize{
      \item Type: \code{integer}.
    }
  }
  \item{n_disease_signature_up_regulated_genes}{
    Number of up-regulated genes in the disease signature.
    \itemize{
      \item Type: \code{integer}.
    }
  }
  \item{n_drug_signatures_genes}{
    Total number of genes in the drug signature.
    \itemize{
      \item Type: \code{integer}.
    }
  }
  \item{random_distribution_size}{
    Distribution size. A larger distribution size provides a more accurate p-value.
    \itemize{
      \item Type: \code{integer}.
    }
  }
}
\value{
A float vector of size \code{random_distribution_size}.
}
\examples{
RandomConnectivityScoreDistributionImpl <- R6Class(
  "RandomConnectivityScoreDistributionImpl",
  inherit = RandomConnectivityScoreDistributionAbstract,
  public = list(
    compute = function(
      n_disease_signature_down_regulated_genes,
      n_disease_signature_up_regulated_genes,
      n_drug_signatures_genes,
      random_distribution_size
    ) {
      # Generate random distribution
    }
  )
)
}