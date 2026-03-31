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
    Data frame containing RNA expression values and associated metadata. The \code{gene_expression} column stores the gene expression levels, while all other columns provide experimental metadata used in the LMM computation.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
}
\value{
The output of the LMM function used for the computation (i.e., \code{lmer} from the \pkg{lme4} package).
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

