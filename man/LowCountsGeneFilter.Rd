\name{LowCountsGeneFilter}
\alias{LowCountsGeneFilter}
\title{Filter out non-significant genes based on counts threshold}
\description{
Typically, this filter is used for RNA-seq data.
\cr
Filters out non-significant genes by keeping those with at least \code{threshold} counts greater than the specified threshold, where \code{threshold} equals the size of the smallest group.
\cr
The filtering formula is:
\cr
\code{keep <- rowSums(gene_expressions >= threshold) >= min(table(sample_statuses))}.
\cr
This class is a derived class of \code{GeneFilterAbstract}.
}
\usage{
lowCountsGeneFilter <- LowCountsGeneFilter$new(threshold)
lowCountsGeneFilter$filter(gene_expressions, sample_statuses)
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
    Each element in the \code{sample_statuses} vector represents the type of the corresponding RNA data sample column (by position) in the expression matrix.
    \itemize{
      \item Type: \code{vector}.
    }
   }
  }
  \item{threshold (constructor argument)}{
    Counts threshold.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10}.
    }
  }
}
\value{
Data frame. Rows correspond to genes passing the counts threshold filtering.
}
\examples{
threshold <- 11
lowCountsGeneFilter <- LowCountsGeneFilter$new(threshold)
lowCountsGeneFilter$filter(gene_expressions, sample_statuses)
}
