\name{DGEToSignatureMapperAbstract}
\alias{DGEToSignatureMapperAbstract}
\title{Abstract Class for Mapping Differential Gene Expression (DGE) to Signature}
\description{
Base class for the \code{dgeToSignatureMapper} constructor parameter in the classes \code{BinChenDiseaseDGEDrugConnectivityScore} and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
Maps the Differential Gene Expression (DGE) data to a gene signature.
}
\usage{
DGEToSignatureMapperAbstract$new()
DGEToSignatureMapperAbstract$map(dge, parameter)
DGEToSignatureMapperAbstract$getSignatureType(parameter)
}
\arguments{
  \item{dge}{
    Differential Gene Expression (DGE) data to be mapped.
    \itemize{
      \item Type: \code{data.frame}
    }
  }
  \item{parameter}{
    Optional parameter for signature mapping computation.
    \itemize{
      \item Type: \code{Any}
    }
  }
}
\value{
\code{map}: A \code{data.frame} containing the gene signature. Columns: \code{estimate} (usually the t-value column of the DGE). Row names contain the gene IDs.

\code{getSignatureType}: A \code{string} representing the mapping strategy type name.
}
\examples{
DGEToSignatureMapperImpl <- R6Class(
  "DGEToSignatureMapperImpl",
  inherit = DGEToSignatureMapperAbstract,
  public = list(
    map = function(dge, parameter) {
      # perform mapping operation
    },
    getSignatureType = function(parameter) {
      # return the type of signature mapping
    }
  )
)
}
