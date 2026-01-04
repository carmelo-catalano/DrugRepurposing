\name{MeanThresholdGeneFilter}
\alias{MeanThresholdGeneFilter}
\title{Filter out non-significant genes by mean expression threshold}
\description{
Filters out non-significant genes by removing rows where the average expression value is below the specified threshold.
\cr
The filtering formula is:
\cr
\code{mean <- rowMeans(gene_expressions)}.
\cr
This class is a derived class of \code{GeneFilterAbstract}.
\cr
Input values must be greater than or equal to 0.
}
\usage{
meanThresholdGeneFilter <- MeanThresholdGeneFilter$new(threshold)
meanThresholdGeneFilter$filter(gene_expressions)
}

\arguments{
  For filter function arguments, refer to GeneFilterAbstract.

  \item{threshold (constructor argument)}{
    Mean threshold for filtering.
    \itemize{
      \item Type: \code{float}.
      \item Default value: \code{3}.
    }
  }
}
\value{
A filtered data frame. Rows correspond to genes passing the mean expression threshold filtering.
}
\examples{
threshold <- 8
meanThresholdGeneFilter <- MeanThresholdGeneFilter$new(threshold)
meanThresholdGeneFilter$filter(gene_expressions)
}
