\name{DrugSignatureLoaderAbstract}
\alias{DrugSignatureLoaderAbstract}
\title{Base class for loading a drug signature}
\description{
Base class for loading a drug signature (\link{Gene-expression-signature}).\cr
Base class for the constructor parameter \code{drugSignatureLoader} of the
classes \code{BinChenConnectivityScoreListApplyerParallel}, \code{BinChenConnectivityScoreListApplyerSync},
and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
\cr
This package provides two implementations: DrugSignatureLoaderByDrugName, and DrugSignatureLoaderByFilename.
}
\usage{
DrugSignatureLoaderImpl <- R6Class(
  "DrugSignatureLoaderImpl",
  inherit = DrugSignatureLoaderAbstract,
  public = list(
    load = function(drug_name) {
      # do something
    }
  )
)
}
\arguments{
  \item{drug_name}{
    Name of the drug signature to be loaded. It may also refer to the filename.
    \itemize{
      \item Type: \code{character}.
    }
  }
}
\value{
Data frame. Columns: \code{gene_id}, \code{estimate} = log2 Fold Change.\cr
See \link{Gene-expression-signature} for additional info.
}
\examples{
DrugSignatureLoaderImpl <- R6Class(
  "DrugSignatureLoaderImpl",
  inherit = DrugSignatureLoaderAbstract,
  public = list(
    load = function(drug_name) {
      # do something
    }
  )
)
}
