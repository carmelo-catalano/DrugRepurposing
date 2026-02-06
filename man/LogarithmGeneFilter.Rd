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
    Table of RNA data. Each column represents an RNA data sample, and each row represents a gene.
    Row names are gene IDs, and column names are experiment identifiers.
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
      \item Default value: \code{6}.
    }
  }
}
\value{
A filtered data frame. Rows correspond to genes passing the logarithmic threshold filtering.
}
\examples{
threshold <- 7
logarithmGeneFilter <- LogarithmGeneFilter$new(threshold)
logarithmGeneFilter$filter(gene_expressions)
}
