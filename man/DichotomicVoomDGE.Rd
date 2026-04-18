\name{DichotomicVoomDGE}
\alias{DichotomicVoomDGE}
\title{Computes the differential gene expression analysis using Voom transformation}
\description{
Computes the differential gene expression analysis (\link{DGE}). The input consists of two groups of RNA-Seq data from
tissues under different conditions: control vs. altered state (e.g., a disease-affected group
and a control group).
\cr
RNA data must follow a negative binomial distribution, which is typical for RNA-Seq analysis.
\cr
For RNA data following a normal distribution (such as in microarray analysis), see \code{\link{DichotomicDGE}}.
\cr
Derived class of \code{DichotomicDGEAbstract}.
}
\usage{
dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicVoomDGE$compute(rna_data, sample_01_map, filter_by_protein_coding)
}
\arguments{
  \item{rna_seq}{
    Table of RNA-Seq data analysis. Each column represents an RNA-Seq analysis sample, and each row corresponds to a gene.
    \cr
    RNA data must follow a "negative binomial distribution".
    \cr
    Row names are gene IDs; column names are experiment IDs.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_data} table.
    Each character represents the type of the corresponding column in
    \code{rna_data} table (i.e., the group):
    0 = control sample, 1 =  test sample (altered state), X = excluded sample.
    Instead of using 0 and 1, you can label samples as C (control) and T (test).
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{\link{GeneFilterAbstract}}.
      \item Default value: instance of class \code{\link{LowCountsGeneFilter}}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} = differential expression = log2 Fold Change.
\cr
See \link{DGE} for additional details.
}
\examples{
rna_seq <- matrix(
  c(
    262, 281897, 463, 12301, 284, 2966, 4842, 9966,
    116, 337026, 261, 3277, 132, 2006, 3699, 12406,
    111, 111736, 193, 862, 88, 1371, 2536, 1531,
    162, 219471, 281, 5990, 280, 2241, 4527, 12941
  ),
  nrow = 8,
  ncol = 4,
  dimnames = list(
    c(1, 2, 3, 9, 10, 11, 12, 13),
    c("GSM1", "GSM2", "GSM3", "GSM4")
  )
)

sample_01_map <- "1X01"
# How the map is applied:
#           1      X      0      1
# GeneID   GSM1   GSM2   GSM3   GSM4
# 1        262    116    111    162
# ...
#
#
# GSM1, GSM4 = IPF; GSM3 = control; GSM2 = excluded

filter_by_protein_coding <- FALSE

dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicVoomDGE$compute(rna_seq, sample_01_map, filter_by_protein_coding)

# Output:
# gene_id  DE_log2_FC    std.error     t.value       p.value     adj.p.value
# --------------------------------------------------------------------------
# 1        -14.468.569   0.26210106    -5.520.225    5,60E+02    1,12E+03
# 10       -0.6876448    0.25642630    -2.681.647    2,79E+04    3,18E+04
# 11       -14.106.530   0.06931947    -20.350.026   3,55E-02    2,84E-01
# 12       -13.780.645   0.29686726    -4.642.022    1,66E+03    2,66E+03
# 13       0.4928160     0.31559626    1.561.539     1,57E+05    1,57E+05
# 2        -11.863.750   0.11560740    -10.262.103   6,99E+00    2,80E+01
# 3        -14.128.238   0.24532569    -5.758.972    4,25E+02    1,12E+03
# 9        10.124.515    0.36336856    2.786.294     2,37E+04    3,16E+04
}
