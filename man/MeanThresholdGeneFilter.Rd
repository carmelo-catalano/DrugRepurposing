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

meanThresholdGeneFilter <- MeanThresholdGeneFilter$new(threshold)
meanThresholdGeneFilter$filter(gene_expressions)
}
