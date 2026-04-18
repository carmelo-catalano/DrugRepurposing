\name{LMMDGEAbstract}
\alias{LMMDGEAbstract}
\title{Base class for LMMDGE classes}
\description{
Base class for \code{LMMDGE} classes. Computes a differential gene expression (\link{DGE}) analysis by
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
    Table of RNA data analysis. Each column represents an RNA analysis sample, and each row corresponds to a gene.
    \cr
    RNA data must follow the "normal distribution", usually data from microarray-like analysis.
    \cr
    Row names are gene IDs; column names are experiment IDs.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{rna_metadata}{
    RNA metadata table associated with the RNA data table.\cr
    The metadata contains the control/altered state of the samples, along with additional conditions (e.g., sample origin).\cr
    For each RNA sample column in the RNA data table, there must be a corresponding row in the \code{rna_metadata} table.\cr
    One column of \code{rna_metadata} must be named \code{"sample_id"} and must contain the sample IDs of the RNA experiments.
    This column is used to filter \code{rna_data}: \code{rna_data <- rna_data[, rna_metadata$sample_id]}.\cr
    The status column must be a factor, and the first level of the factor must correspond to the \code{"control"} state.\cr
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula}{
    The formula used for LMM computation. The formula may include both fixed and random effects to account for the conditions under which the RNA-Seq experiments were performed.
    \cr
    Because data and metadata are stored in separate tables, the dependent variable (to the left of the \code{~} operator) must not be specified.
    For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{formula}.
    }
  }
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\code{DE_log2_FC} = differential expression = log2 Fold Change.
\cr
The \code{lmer} implementation does not return \code{p.value} and \code{adj.p.value}.
\cr
See \link{DGE} for additional details.
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
