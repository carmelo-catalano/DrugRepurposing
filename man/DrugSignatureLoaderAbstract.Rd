\name{DrugSignatureLoaderAbstract}
\alias{DrugSignatureLoaderAbstract}
\title{Base class for loading drug Differential Gene Expression (DGE)}
\description{
Base class for constructor parameter \code{drugSignatureLoader} of the classes \code{BinChenConnectivityScoreListApplyerParallel}, \code{BinChenConnectivityScoreListApplyerSync}, and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
Responsible for loading a drug DGE.
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
A data frame with columns:
\itemize{
  \item \code{gene_id}
  \item \code{estimate} = log2 Fold Change
}
}
\examples{
DrugSignatureLoaderImpl <- R6Class(
  "DrugSignatureLoaderImpl",
  inherit = DrugSignatureLoaderAbstract,
  public = list(
    load = function(drug_name) {
      # Implementation here
    }
  )
)
# Output structure:
# gene_id    estimate
# 2          -0.07646
# 9           0.01935
# 14         -0.07632
# 16          0.08815
}
