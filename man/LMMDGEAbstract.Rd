\name{LMMDGEAbstract}
\alias{LMMDGEAbstract}
\title{Base class for LMMDGE classes}
\description{
Base class for \code{LMMDGE} classes. Computes a differential gene expression (DGE) analysis by
Linear Mixed Model (LMM).
\cr
This package provides three implementations: \code{LMMDGEDream}, \code{LMMDGEJulia}, and \code{LMMDGELmer}.
}
\usage{
LMMDGEImpl <- R6Class(
  "LMMDGEImpl",
  inherit = LMMDGEAbstract,
  public = list(
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = F) {
      # do something
    }
  )
)
}
\arguments{
  \item{rna_data}{
    Table of RNA data. Each column represents an RNA data sample, and each row represents a gene.
    Row names are gene IDs, and column names are experiment identifiers.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{rna_metadata}{
    For each RNA data analysis column in \code{rna_data} table there is a row in \code{rna_metadata} table.
    \cr
    The first column of \code{rna_metadata} must contain the sample IDs and must match the row names of \code{rna_data}.
    \cr
    The metadata contain the control/altered status of each sample, along with additional conditions.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account
    for all the conditions under which the RNA data analysis were performed.
    \cr
    Because data and metadata are in separate files, the dependent variable to the left of the \code{~} operator must not be specified. For example:
    \code{~ tissue_status + (1 | tissue)}
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, remove non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
}
\value{
Data frame containing DGE results. Each row represents a gene, and columns include \code{log2_FC},
\code{t.value}, and \code{p.value}.
}
\examples{
LMMDGEImpl <- R6Class(
  "LMMDGEImpl",
  inherit = LMMDGEAbstract,
  public = list(
    compute = function(rna_data, rna_metadata, formula, filter_by_protein_coding = F) {
      # do something
    }
  )
)
}
