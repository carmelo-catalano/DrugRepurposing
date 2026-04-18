\name{LMMLowCountsGeneFilter}
\alias{LMMLowCountsGeneFilter}
\title{Filters non-significant genes from RNA-Seq data and samples associated with low-level grouping variables of a random effect}
\description{
Typically, this filter is used for RNA-Seq data.
\cr
This class applies two filter:
1) Filters out non-significant genes by keeping those with at least \code{counts_threshold} counts greater than the specified threshold, where \code{counts_threshold} equals the size of the smallest group.
\cr
The filtering formula is:
\cr
\code{keep <- rowSums(rna_data >= counts_threshold) >= min(table(sample_statuses))}.
\cr
2)
Filters out samples associated with grouping variables that has fewer levels than the
specified threshold. Please note that this class currently supports only one random effect.
\cr
The filters are applied through the classes \code{LowCountsGeneFilter} and \code{LMMGeneFilterByLowLevelRandomEffects}.
\cr
This class is a derived class of \code{LMMGeneFilterAbstract}.
}
\usage{
lmmLowCountsGeneFilter <- LMMLowCountsGeneFilter$new(counts_threshold, random_effects_level_threshold)
lmmLowCountsGeneFilter$filter(rna_data, rna_metadata, random_effect_column_name, sample_status_column_name)
}

\arguments{
  \item{rna_data}{
    Table of RNA data analysis. Each column represents an RNA analysis sample, and each row corresponds to a gene.
    \cr
    RNA data must follow a negative binomial distribution, typically data from RNA-Seq-like analyses.
    \cr
    Row names are gene IDs; column names are experiment IDs.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{rna_metadata}{
    RNA metadata table associated with the RNA data table.\cr
    The metadata contains the control/altered state of the samples, along with additional conditions (e.g., sample origin).\cr
    For each RNA sample column in the RNA data table, there must be a corresponding row in the \code{rna_metadata} table.\cr
    One column of \code{rna_metadata} must be named \code{"sample_id"} and must contain the sample IDs of the RNA experiments.
    This column is used to filter \code{rna_data}: \code{rna_data <- rna_data[, rna_metadata$sample_id]}.\cr
    The status column must be a factor, and the first level of the factor must correspond to the \code{"control"} state.\cr
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{random_effect_column_name}{
    This argument specifies the name of the random effect column used to filter out low-level grouping variables.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_status_column_name}{
    This argument specifies the name of the samples status column used to filter out non-significant genes.
    \cr
    See \code{\link{LowCountsGeneFilter}} for more information.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_status"}
    }
  }
  \item{counts_threshold (constructor argument)}{
    Counts threshold.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10}.
    }
  }
  \item{random_effects_level_threshold (constructor parameter)}{
    This argument specifies the minimum threshold for the number of levels in the grouping variable.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{5}.
    }
  }
}
\value{
A filtered data frame. Rows correspond to genes passing the counts threshold filtering.
}
\examples{
counts_threshold <- 11
random_effects_level_threshold <- 5

# rna_data
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


# rna_metadata
# sample_id   tissue               tissue_status
# ----------------------------------------------
# GSM1        Cerebellum           ALS
# GSM2        Cerebellum           ALS
# GSM3        Cerebellum           ALS
# GSM4        Cerebellum           Control
# GSM5        Cerebellum           Control
# GSM6        Cortex Sensory       ALS
# GSM7        Cortex Frontal       ALS
# GSM8        Cortex Frontal       Control

random_effect_column_name <- "tissue"
sample_status_column_name <- "tissue_status"

lmmLowCountsGeneFilter <- LowCountsGeneFilter$new(counts_threshold, random_effects_level_threshold)
lmmLowCountsGeneFilter$filter(rna_data, rna_metadata, random_effect_column_name, sample_status_column_name)
}
