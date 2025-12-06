\name{LMMAbstract}
\alias{LMMAbstract}
\title{Base class for LMM classes}
\description{
Base class for LMM classes. The \code{compute} method calculates a Linear Mixed Model (LMM). The \code{getFormula} method returns the formula used for LMM computation.
This package provides four implementations: \code{LINCSLMMJulia}, \code{LINCSLMMLmer}, \code{LMMJulia}, \code{LMMLmer}.
}
\usage{
LMMImpl <- R6Class(
  "LMMImpl",
  inherit = LMMAbstract,
  public = list(
    compute = function(rna_data_metadata) {
      # do something
    },
    getFormula = function() {
      # do something
    }
  )
)
}
\arguments{
  \item{rna_data_metadata}{
    Table containing RNA data analysis and metadata. The \code{gene_expression} column stores gene expression values under different conditions, while all other columns contain metadata for the LMM.
    \itemize{
      \item Type: \code{data frame}.
    }
  }
}
\value{
Output of the LMM computation.
}
\examples{
LMMImpl <- R6Class(
  "LMMImpl",
  inherit = LMMAbstract,
  public = list(
    compute = function(rna_data_metadata) {
      # do something
    },
    getFormula = function() {
      # do something
    }
  )
)
}

