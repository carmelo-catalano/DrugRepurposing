\name{DGEToSignatureMapperAbstract}
\alias{DGEToSignatureMapperAbstract}
\title{Base class for mapping DGE to a gene expression signature}
\description{
Base class for constructor parameter \code{dgeToSignatureMapper} of many classes such as \code{BinChenDiseaseDGEDrugConnectivityScore}, and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
Maps the \link{DGE} to a \link{Gene-expression-signature}.
The \code{map} method calculates the signature. The \code{getSignatureType} method returns the mapping strategy type name.
This package provides two implementations: \code{MostSignificantGenesSignatureMapper} and \code{PValueAndFCThresholdSignatureMapper}.
}
\usage{
dgeToSignatureMapperImpl <- R6Class(
  "DGEToSignatureMapperImpl",
  inherit = DGEToSignatureMapperAbstract,
  public = list(
    map = function(dge, parameter) {
      # do something
    },
    getSignatureType = function(parameter) {
      # do something
    }
  )
)
}
\arguments{
  \item{dge}{
    A table containing a DGE.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{parameter}{
    An optional parameter for mapping computation.
  }
}
\value{
Data frame. Columns: \code{gene_id}, \code{estimate} (usually the t-value column of the DGE).
}
\examples{
dgeToSignatureMapperImpl <- R6Class(
  "DGEToSignatureMapperImpl",
  inherit = DGEToSignatureMapperAbstract,
  public = list(
    map = function(dge, parameter) {
      # do something
    },
    getSignatureType = function(parameter) {
      # do something
    }
  )
)
}
