\name{GeneFilterAbstract}
\alias{GeneFilterAbstract}
\title{Base class for filtering genes from RNA data}
\description{
Typically, this class implementation filters non-significant genes from RNA data.
\cr
This package provides four implementations: \code{LogarithmGeneFilter}, \code{LowCountsGeneFilter}, \code{MeanThresholdGeneFilter}, and \code{NoGeneFilter}.
\cr
Base class for constructor parameter \code{geneFilter} of the classes \code{DichotomicDGE}, \code{DichotomicVoomDGE},
\code{DichotomicDrugRepurpose}, \code{DichotomicDrugRepurposeCore}, \code{DichotomicVoomDrugRepurpose}
 and \code{GEORNASeqDichotomicVoomDGE}.
}
\usage{
GeneFilterImpl <- R6Class(
  "GeneFilterImpl",
  inherit = GeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, sample_statuses) {
      # do something
    }
  )
)
}
\arguments{
  \item{gene_expressions}{
    Table of RNA data analysis. Each column represents an RNA analysis sample, and each row corresponds to a gene.
    \cr
    Row names are gene IDs; column names are experiment IDs.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{sample_statuses}{
    Each element in the \code{sample_statuses} vector represents the status (control/altered) of the corresponding RNA data sample column (by position) in the expression matrix.
    \itemize{
      \item Type: \code{vector}.
    }
  }
}
\value{
Filtered \code{gene_expressions} without non-significant genes.
}
\examples{
GeneFilterImpl <- R6Class(
  "GeneFilterImpl",
  inherit = GeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, sample_statuses) {
      # do something
    }
  )
)
}

