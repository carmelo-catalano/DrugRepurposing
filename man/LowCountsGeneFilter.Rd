\name{LowCountsGeneFilter}
\alias{LowCountsGeneFilter}
\title{Filter out non-significant genes based on counts threshold}
\description{
Filters out non-significant genes by keeping those with at least \code{N} counts greater than the specified threshold, where \code{N} equals the size of the smallest group.
\cr
The filtering formula is:
\cr
\code{keep <- rowSums(gene_expressions >= private$threshold) >= min(table(sample_statuses))}.
\cr
This class is a derived class of \code{GeneFilterAbstract}.
}
\usage{
lowCountsGeneFilter <- LowCountsGeneFilter$new(threshold)
lowCountsGeneFilter$filter(gene_expressions, sample_statuses)
}

\arguments{
  For filter function arguments, refer to GeneFilterAbstract.

  \item{threshold (constructor argument)}{
    Counts threshold.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10}.
    }
  }
}
\value{
A filtered data frame. Rows correspond to genes passing the counts threshold filtering.
}
\examples{
threshold <- 11
lowCountsGeneFilter <- LowCountsGeneFilter$new(threshold)
lowCountsGeneFilter$filter(gene_expressions, sample_statuses)
}
