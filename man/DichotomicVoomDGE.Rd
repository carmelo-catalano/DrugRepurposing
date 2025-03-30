\name{DichotomicVoomDGE}
\alias{DichotomicVoomDGE}
\title{Computes the differential gene expression analysis using Voom transformation}
\description{
Computes the differential gene expression analysis. The input consists of two groups of RNA-Seq data from
tissues under different conditions: control vs. altered state (e.g., a disease-affected group
and a control group).
\cr
RNA data must follow a negative binomial distribution, which is typical for RNA-Seq analysis.
\cr
For RNA data following a normal distribution (such as in microarray analysis), see \code{DichotomicDGE}.
\cr
Derived class of \code{DichotomicDGEAbstract}.
}
\usage{
dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicVoomDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)
}
\arguments{
  \item{rna_data}{
    Table of RNA-Seq data. Each column represents an RNA analysis sample, and each row represents a gene.
    Row names are gene IDs; column names are experiment IDs. See example in the “Usage section.”
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: first column = gene ID; other columns: RNA-Seq sample data. Typically, the first column name is \code{GeneID}. The remaining column names correspond to the RNA-Seq sample identifiers.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_data} table. Each character represents the type of the corresponding column in \code{rna_data} (i.e., the group): 0 = test sample, 1 = control sample, X = excluded sample.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{test_sample_name}{
    Test sample name.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{GeneFilterAbstract}.
      \item Default value: instance of class \code{LowCountsGeneFilter}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} = differential expression = log2 fold change.
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
# How the map is applied:
#           0      X      1      0
# GeneID   GSM1   GSM2   GSM3   GSM4
# 1        262    116    111    162
# ...
#
#
# GSM1, GSM4 = IPF; GSM3 = control; GSM2 = exluded

test_sample_name <- "IPF"
filter_by_protein_coding <- FALSE

dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicVoomDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)

# Output:
# gene_id  DE_log2_FC    std.error   t.value   p.value   adj.p.value
# Gene_1   -1.5782345   0.2234567   -7.06543  3.21e-05  2.14e-04
# Gene_2   2.4732156    0.4567891   5.41862   7.89e-06  4.67e-05
# Gene_3   -0.9487123   0.1892764   -5.01134  1.12e-04  7.89e-04
# Gene_4   1.2875643    0.3231345   3.98543   4.53e-03  2.18e-02
}
