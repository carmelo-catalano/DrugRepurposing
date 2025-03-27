\name{DichotomicDGEAbstract}
\alias{DichotomicDGEAbstract}
\title{Base Class for Dichotomic Differential Gene Expression Analysis}
\description{
Base class for the constructor parameter \code{dichotomicCustomTypeDGE} of the class \code{DichotomicDrugRepurposeCore}.
Computes the differential gene expression analysis based on two groups of RNA data: control and altered states, e.g., a disease-affected group and a control group.
}
\usage{
DichotomicDGEAbstract$new()
DichotomicDGEAbstract$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)
}
\arguments{
  \item{rna_data}{
    Table of RNA data. Each column represents a sample, and each row represents a gene.
    Row names represent gene IDs, while column names represent experiment IDs.
    \itemize{
      \item Type: \code{matrix}
    }
  }
  \item{sample_01_map}{
    A map indicating the group of each sample: \code{0} = test sample, \code{1} = control sample, \code{X} = excluded sample.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{test_sample_name}{
    Name of the test sample.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{filter_by_protein_coding}{
    If true, filters out non-protein-coding genes.
    \itemize{
      \item Type: \code{boolean}
      \item Default value: \code{FALSE}
    }
  }
}
\value{
A \code{data.frame} with columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
DichotomicDGEImpl <- R6Class(
  "DichotomicDGEImpl",
  inherit = DichotomicDGEAbstract,
  public = list(
    compute = function(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding = FALSE) {
      # perform DGE analysis
    }
  )
)
}
