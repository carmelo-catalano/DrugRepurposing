\name{DichotomicDGEAbstract}
\alias{DichotomicDGEAbstract}
\title{Base class for differential gene expression analysis}
\description{
Base class for the constructor parameter \code{dichotomicCustomTypeDGE} of the class \code{DichotomicDrugRepurposeCore}.
This package provides two implementations: \code{DichotomicDGE} and \code{DichotomicVoomDGE}.
Computes the differential gene expression analysis. The input is composed of two groups of RNA data from tissues under different conditions: control/altered state; for example, a disease-affected group and a control group.
}
\usage{
DichotomicDGEImpl <- R6Class(
  "DichotomicDGEImpl",
  inherit = DichotomicDGEAbstract,
  public = list(
    compute = function(rna_data, sample_01_map, filter_by_protein_coding = FALSE) {
      # do something
    }
  )
)
}
\arguments{
  \item{rna_data}{
    Table of RNA data. Each column represents an RNA analysis sample, and each row corresponds to a gene.
    Row names are gene IDs; column names are experiment identifiers.
    See \code{DichotomicDGE} or \code{DichotomicVoomDGE} for more details.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_data} table. Each character represents the type of the
    corresponding column in \code{rna_data} table (i.e., the group):
    0 = control sample, 1 =  test sample (altered state), X = excluded sample.
    Instead of using 0 and 1, you can label samples as C (control) and T (test).
    \cr
    See \code{DichotomicDGE} or \code{DichotomicVoomDGE} for more details.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} represents differential expression = log2 fold change.
}
\examples{
DichotomicDGEImpl <- R6Class(
  "DichotomicDGEImpl",
  inherit = DichotomicDGEAbstract,
  public = list(
    compute = function(rna_data, sample_01_map, filter_by_protein_coding = FALSE) {
      # do something
    }
  )
)
}
