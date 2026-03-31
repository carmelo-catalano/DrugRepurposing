\name{LogarithmGeneFilter}
\alias{LogarithmGeneFilter}
\title{Filter out non-significant genes based on a logarithmic threshold}
\description{
Filters out non-significant genes based on a logarithmic threshold.
\cr
Typically, this filter is used for RNA data coming from microarray experiments.
\cr
The filtering formula is:
\cr
\code{rowMeans(log(gene_expressions + 1, 2)) > threshold}.
\cr
Input values must be greater than or equal to 0.
\cr
This class is a derived class of \code{GeneFilterAbstract}.
}
\usage{
logarithmGeneFilter <- LogarithmGeneFilter$new(threshold)
logarithmGeneFilter$filter(gene_expressions)
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
    Not used.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{threshold (constructor argument)}{
    Logarithm threshold.
    \itemize{
      \item Type: \code{float}.
      \item Default value: \code{1.5}.
    }
  }
}
\value{
A filtered data frame. Rows correspond to genes passing the logarithmic threshold filtering.
}
\examples{
threshold <- 7

# gene_expressions
#  GeneID   GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7   GSM8
# ---------------------------------------------------------------
# 1         9.67   8.91   9.00   8.96   6.71   6.94   8.83   7.93
# 2         8.82   8.30   8.93   9.28   9.57   7.93   9.16   7.87
# 9         9.63   9.25   9.13   9.19   9.89   8.77   9.69   9.94
# 12        7.78   7.93   8.14   8.66   8.76   7.61   8.29   7.81
# 13        7.15   7.84   7.91   8.45   8.38   7.35   7.90   8.34
# 14        9.41   8.97   8.47   9.39   9.49   9.02   9.10   9.56
# 21        7.85   7.06   9.70   7.31   6.99   7.58   7.54   6.64
# 25        6.67   9.24   7.94   8.52   9.25   9.20   9.35   9.66

logarithmGeneFilter <- LogarithmGeneFilter$new(threshold)
logarithmGeneFilter$filter(gene_expressions)
}
