\name{LMMGeneFilterByLowLevelRandomEffects}
\alias{LMMGeneFilterByLowLevelRandomEffects}
\title{Filter samples associated with low-level grouping variables of a random effect}
\description{
A common guideline is that a random effect should have at least five levels for its associated grouping variable.
Since this requirement may vary depending on the experimental design, it is possible to adjust
this threshold using the \code{random_effects_level_threshold} argument.
\cr
This class filters out samples associated with grouping variables that has fewer levels than the
specified threshold. Please note that this class currently supports only one random effect.
\cr
If \code{random_effects_level_threshold = 0}, no data is filtered.
}
\usage{
lmmGeneFilterByLowLevelRandomEffects<-LMMGeneFilterByLowLevelRandomEffects$new()
lmmGeneFilterByLowLevelRandomEffects$filter(rna_data, rna_metadata, random_effect_column_name)
}
\arguments{
  \item{rna_data}{
    Table of RNA data analysis, which may include RNA-Seq, Microarray data, or other types, depending on the calling class.
    \cr
    Each column represents an RNA data analysis sample, and each row corresponds to a gene.
    \cr
    Row names are gene IDs; column names are experiment IDs.
    \itemize{
      \item Type: matrix.
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
      \item Type: \code{character}.
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
list.
The list contains 2 items:
1) rna_data
\cr
Matrix. Filtered \code{rna_data} without samples linked to filtered grouping variables.
\cr
\cr
2) rna_metadata
\cr
data.frame. Metadata after filtering out rows associated with low-level grouping variables.
}
\examples{

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

lmmGeneFilterByLowLevelRandomEffects <- LMMGeneFilterByLowLevelRandomEffects$new()
output <- lmmGeneFilterByLowLevelRandomEffects$filter(rna_data, rna_metadata, random_effect_column_name)

# output
# output$rna_data
#  GeneID   GSM1   GSM2   GSM3   GSM4   GSM5
# ------------------------------------------
#  1        817    480    513    497    105
#  2        451    315    489    620    762
#  9        792    608    560    585    952
#  12       220    244    283    404    434
#  13       142    229    240    350    332
#  14       682    501    354    669    721
#  21       230    133    830    159    127
#  25       102    605    246    368    611

# output$rna_metadata
# sample_id   tissue               tissue_status
# ----------------------------------------------
# GSM1        Cerebellum           ALS
# GSM2        Cerebellum           ALS
# GSM3        Cerebellum           ALS
# GSM4        Cerebellum           Control
# GSM5        Cerebellum           Control


}

