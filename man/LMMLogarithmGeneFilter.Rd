\name{LMMLogarithmGeneFilter}
\alias{LMMLogarithmGeneFilter}
\title{Filter out non-significant genes based on a logarithmic threshold and samples associated with low-level grouping variables of a random effect}
\description{
Typically, this filter is used for RNA data coming from microarray experiments.
\cr
This classes applies two filters:
1)
Filters out non-significant genes based on a logarithmic threshold.
\cr
The filtering formula is:
\cr
\code{rowMeans(log(rna_data + 1, 2)) > logarithm_threshold}.
\cr
Input values must be greater than or equal to 0.
\cr
2)
Filters out samples associated with grouping variables that has fewer levels than the
specified threshold. Please note that this class currently supports only one random effect.
\cr
The filters are applied through the classes \code{LogarithmGeneFilter} and \code{LMMGeneFilterByLowLevelRandomEffects}.
\cr
This class is a derived class of \code{LMMGeneFilterAbstract}.
}
\usage{
logarithmGeneFilter <- LMMLogarithmGeneFilter$new(logarithm_threshold, random_effects_level_threshold)
logarithmGeneFilter$filter(rna_data, rna_metadata, random_effect_column_name, sample_status_column_name)
}
\arguments{
  \item{rna_data}{
    Table of RNA data analysis. Each column represents an RNA analysis sample, and each row corresponds to a gene.
    \cr
    RNA data must follow the "normal distribution", usually data from microarray-like analysis.
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
    Not used.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{logarithm_threshold (constructor argument)}{
    Logarithm threshold.
    \itemize{
      \item Type: \code{float}.
      \item Default value: \code{1.5}.
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
A filtered data frame. Rows correspond to genes passing the logarithmic threshold filtering.
}
\examples{
logarithm_threshold <- 3
random_effects_level_threshold <- 5
random_effect_column_name <- "tissue"

# rna_data
#  GeneID   GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7   GSM8
# ---------------------------------------------------------------
# 1         9.67   8.91   9.00   8.96   6.71   6.94   8.83   7.93
# 2         8.82   8.30   8.93   9.28   9.57   7.93   9.16   7.87
# 9         9.63   9.25   9.13   9.19   9.89   8.77   9.69   9.94
# 12        7.78   7.93   8.14   8.66   8.76   7.61   8.29   7.81
# 13        7.15   7.84   7.91   8.45   8.38   7.35   7.90   8.34
# 14        9.41   8.97   8.47   9.39   9.49   9.02   9.10   9.56
# 21        7.85   7.06   9.70   7.31   6.99   7.58   7.54   6.64
# 25        6.67   9.24   7.94   8.52   9.25   9.20   9.35   9.66

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

lmmLogarithmGeneFilter <- LMMLogarithmGeneFilter$new(logarithm_threshold, random_effects_level_threshold)
lmmLogarithmGeneFilter$filter(rna_data, rna_metadata, random_effect_column_name)
}
