\name{LogarithmGeneFilter}
\alias{LogarithmGeneFilter}
\title{Filter out non-significant genes based on a logarithmic threshold}
\description{
Filters out non-significant genes based on a logarithmic threshold.
\cr
The filtering formula is:
\cr
\code{rowMeans(log(gene_expressions + 1, 2)) > threshold}.
\cr
This class is a derived class of \code{GeneFilterAbstract}.
}
\usage{
logarithmGeneFilter <- LogarithmGeneFilter$new(threshold)
logarithmGeneFilter$filter(gene_expressions)
}
\arguments{
  For filter function arguments, refer to GeneFilterAbstract.
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
