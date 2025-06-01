\name{DrugSignatureLoaderAbstract}
\alias{DrugSignatureLoaderAbstract}
\title{Base class for loading a drug DGE}
\description{
Base class for the constructor parameter \code{drugSignatureLoader} of the
classes \code{BinChenConnectivityScoreListApplyerParallel}, \code{BinChenConnectivityScoreListApplyerSync},
and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
Responsible for loading a drug DGE.
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
    Name of the drug DGE to be loaded. It may also refer to the filename.
    \itemize{
      \item Type: \code{string}.
    }
  }
}
\value{
Data frame. Columns: \code{gene_id}, \code{estimate} = log2 Fold Change.
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