\name{DichotomicDGE}
\alias{DichotomicDGE}
\title{Computes the differential gene expression analysis}
\description{
Computes the differential gene expression analysis. The input is composed of two groups of RNA data from tissues under different conditions: control/altered state; for example, a disease-affected group and a control group. RNA data must follow the "normal distribution", usually data from microarray-like analysis. For RNA data following a negative binomial distribution, like Illumina RNA-Seq, see \code{DichotomicVoomDGE}.
Derived class of \code{DichotomicDGEAbstract}.
}
\usage{
dichotomicDGE <- DichotomicDGE$new()
dichotomicDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)

}
\arguments{
  \item{rna_data}{
    Table of RNA data. Each column represents an RNA analysis, and each row represents a gene.
    Row names are gene IDs; column names are experiment IDs. See example.
    \itemize{
      \item Type: \code{matrix}.
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
    If true, remove non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{F}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{GeneFilterAbstract}.
      \item Default value: instance of class \code{MeanThresholdGeneFilter}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}. \code{DE_log2_FC} = differential expression = log2 Fold Change.
}
\examples{
rna_data <- matrix(c(
3.000, 2.322, 2.807, 3.000,
9.676, 8.910, 9.006, 8.960,
4.954, 4.248, 3.907, 4.392,
1.000, 0.000, 0.000, 0.000,
0.000, 0.000, 0.000, 0.000,
1.000, 1.000, 1.585, 1.000,
0.000, 0.000, 0.000, 0.000,
5.883, 6.170, 6.459, 6.781
), nrow = 8, byrow = TRUE)
colnames(rna_data) <- c('GSM1', 'GSM2', 'GSM3', 'GSM4') # experiment name
rownames(rna_data) <- c(1, 2, 3, 9, 10, 11, 12, 13) # gene id


# Gene id  GSM1    GSM2    GSM3    GSM4
# 1        3.000   2.322   2.807   3.000
# 2        9.676   8.910   9.006   8.960
# 3        4.954   4.248   3.907   4.392
# 9        1.000   0.000   0.000   0.000
# 10       0.000   0.000   0.000   0.000
# 11       1.000   1.000   1.585   1.000
# 12       0.000   0.000   0.000   0.000
# 13       5.883   6.170   6.459   6.781

# the first column represents the gene id not the table's first column

sample_01_map <- "0X10"
# How the map is applied:
#          0	   X	   1	   0
# GeneID   GSM1    GSM2    GSM3    GSM4
# 1        3.000   2.322   2.807   3.000
# ...
#
#
# GSM1, GSM4 = IPF; GSM3 = control; GSM2 = excluded

test_sample_name <- "IPF"
filter_by_protein_coding <- FALSE

logarithmGeneFilter <- LogarithmGeneFilter$new(1)
dichotomicDGE <- DichotomicDGE$new(logarithmGeneFilter)
dichotomicDGE$compute(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding)

# Output:
# gene_id    DE_log2_FC   std.error      t.value         p.value        adj.p.value
# 1          0.193        0.005257356    36.7104702      0.005835270    0.014588174
# 11         -0.585       0.005257356    -111.2726688    0.001337216    0.006686082
# 13         -0.127       0.674621761    -0.1882536      0.875312240    0.875312240
# 2          0.312        0.537903769    0.5800294       0.644737671    0.805922089
# 3          0.766        0.422221949    1.8142117       0.270563280    0.450938800

}
