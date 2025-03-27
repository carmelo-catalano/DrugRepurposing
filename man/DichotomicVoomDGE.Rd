\name{DichotomicVoomDGE}
\alias{DichotomicVoomDGE}
\title{Compute the differential gene expression analysis}
\description{
Compute the differential gene expression analysis. The input consists of two groups of RNA-Seq data from tissues under different conditions: control vs. altered state (e.g., a disease-affected group and a control group). RNA data must follow a negative binomial distribution, which is typical for RNA-Seq analysis. For RNA data following a normal distribution (such as in microarray analysis), see DichotomicDGE.
}
\usage{
dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicVoomDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)
}
\arguments{
  \item{rna_seq}{
    Table of RNA-Seq data. Each column represents an RNA-Seq sample, and each row represents a gene.
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: first column = gene ID; other columns: RNA-Seq sample data.
    }
    Typically, the first column name is \code{"GeneID"}. The remaining column names correspond to the RNA-Seq sample identifiers. See the example in the \code{Usage} section.
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_seq} table. Each character represents the type of the corresponding column in the \code{rna_seq} table (i.e., the group): \code{0} = test sample, \code{1} = control sample, \code{X} = excluded sample.
  }
  \item{test_sample_name}{
    Test sample name.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{filter_by_protein_coding}{
    If true remove no protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value = \code{F}.
    }
  }
}
\section{Constructor arguments}{
  \item{\code{geneFilter}}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: Derived class of \code{GeneFilterAbstract}.
      \item Default value: \code{LowCountsGeneFilter}.
    }
  }
}
\value{
Table. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}. \code{DE_log2_FC} = differential expression = log 2 Fold Change. See example in the \code{Usage} section.
}
\examples{
rna_seq <- data.frame(
  GeneID = c(1, 2, 3, 9, 10, 11, 12, 13),
  GSM1 = c(262, 281897, 463, 12301, 284, 2966, 4842, 9966),
  GSM2 = c(116, 337026, 261, 3277, 132, 2006, 3699, 12406),
  GSM3 = c(111, 111736, 193, 862, 88, 1371, 2536, 1531),
  GSM4 = c(162, 219471, 281, 5990, 280, 2241, 4527, 12941)
)

sample_01_map <- "0X10"
test_sample_name <- "IPF"
filter_by_protein_coding <- FALSE

dichotomicVoomDGE <- DichotomicVoomDGE$new()
result <- dichotomicVoomDGE$compute(rna_seq, sample_01_map, test_sample_name, filter_by_protein_coding)
print(result)
}
