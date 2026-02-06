\name{MeanThresholdGeneFilter}
\alias{MeanThresholdGeneFilter}
\title{Filter out non-significant genes by mean expression threshold}
\description{
Typically, this filter is used for RNA-seq data.
\cr
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
   \item{gene_expressions}{
    Table of RNA-seq data. Each column represents an RNA data sample, and each row represents a gene.
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
