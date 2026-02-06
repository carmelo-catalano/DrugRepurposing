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
# gene_expressions
#  GeneID   GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7   GSM8
# ---------------------------------------------------------------
#  1        817    480    513    497    105    123    455    244
#  2        451    315    489    620    762    244    572    234
#  9        792    608    560    585    952    436    823    981
#  12       220    244    283    404    434    196    314    225
#  13       142    229    240    350    332    163    239    324
#  14       682    501    354    669    721    520    550    755
#  21       230    133    830    159    127    191    186    100
#  25       102    605    246    368    611    588    654    811

lowCountsGeneFilter$filter(gene_expressions, sample_statuses)
}
