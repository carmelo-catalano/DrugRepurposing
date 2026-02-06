\name{LMMLowCountsGeneFilter}
\alias{LMMLowCountsGeneFilter}
\title{Filters non-significant genes from RNA-seq data and samples associated with low-level grouping variables of a random effect}
\description{
Typically, this filter is used for RNA-seq data.
\cr
This class applies two filter:
1) Filters out non-significant genes by keeping those with at least \code{counts_threshold} counts greater than the specified threshold, where \code{counts_threshold} equals the size of the smallest group.
\cr
The filtering formula is:
\cr
\code{keep <- rowSums(gene_expressions >= counts_threshold) >= min(table(sample_statuses))}.
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
lmmLowCountsGeneFilter$filter(gene_expressions, metadata, random_effect_column_name, counts_filter_column_name)
}

\arguments{
  \item{gene_expressions}{
    Table of RNA-seq data. Each column represents an RNA data sample, and each row represents a gene.
    Row names are gene IDs, and column names are sample identifiers.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{metadata}{
    \code{metadata} is a data frame containing metadata for \code{gene_expressions}.
    \cr
    \code{metadata} must contain a column named \code{"sample_id"}, which is used to filter \code{gene_expressions}:
    \code{gene_expressions <- gene_expressions[, metadata$sample_id]}.
    \cr
    \code{metadata} must also contain a column whose name is given by \code{random_effect_column_name}, which is used to filter low-level grouping variables.
    \cr
    See example below.
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

# gene_expressions
#  GeneID   GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7   GSM8
# ---------------------------------------------------------------
1	9.67	8.91	9.00	8.96	6.71	6.94	8.83	7.93
2	8.82	8.30	8.93	9.28	9.57	7.93	9.16	7.87
9	9.63	9.25	9.13	9.19	9.89	8.77	9.69	9.94
12	7.78	7.93	8.14	8.66	8.76	7.61	8.29	7.81
13	7.15	7.84	7.91	8.45	8.38	7.35	7.90	8.34
14	9.41	8.97	8.47	9.39	9.49	9.02	9.10	9.56
21	7.85	7.06	9.70	7.31	6.99	7.58	7.54	6.64
25	6.67	9.24	7.94	8.52	9.25	9.20	9.35	9.66

# metadata
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
counts_filter_column_name <- "status"

lmmLowCountsGeneFilter <- LowCountsGeneFilter$new(counts_threshold, random_effects_level_threshold)
lmmLowCountsGeneFilter$filter(gene_expressions, metadata, random_effect_column_name, counts_filter_column_name)
}
