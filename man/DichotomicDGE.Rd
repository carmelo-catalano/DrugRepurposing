\name{DichotomicDGE}
\alias{DichotomicDGE}
\title{Compute Differential Gene Expression Analysis}
\description{
This class performs differential gene expression analysis based on two groups of RNA data from tissues under different conditions (e.g., disease-affected group vs. control group).
RNA data should follow a normal distribution, typically derived from microarray-like analysis. For RNA-Seq data (negative binomial distribution), see \code{DichotomicVoomDGE}.
}
\usage{
DichotomicDGE$new()
DichotomicDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)
}
\arguments{
  \item{rna_data}{
    RNA data table. Each column represents an RNA analysis sample, and each row corresponds to a gene.
    Row names represent gene IDs, and column names represent experiment IDs.
    \itemize{
      \item Type: \code{matrix}
    }
  }
  \item{sample_01_map}{
    A mapping of RNA samples: \code{"0"} = test sample, \code{"1"} = control sample, \code{"X"} = excluded sample.
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
    Indicates whether non-protein-coding genes should be excluded.
    \itemize{
      \item Type: \code{boolean}
      \item Default value: \code{FALSE}
    }
  }
}
\value{
A \code{data.frame} containing the computed differential expression results. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
rna_data <- matrix(c(
  3000, 2322, 2807, 3000,
  9676, 8910, 9006, 8960,
  4954, 4248, 3907, 4392
), nrow = 3, byrow = TRUE)
rownames(rna_data) <- c(1, 2, 3)
colnames(rna_data) <- c("GSM1", "GSM2", "GSM3", "GSM4")

sample_01_map <- "0X10"
test_sample_name <- "IPF"
filter_by_protein_coding <- FALSE

dichotomicDGE <- DichotomicDGE$new()
result <- dichotomicDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)
print(result)
}
