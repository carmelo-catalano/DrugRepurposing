\name{LMMLmerToDataFrameMapper}
\alias{LMMLmerToDataFrameMapper}
\title{Maps the output of lmer to a data frame}
\description{
Maps the output of \code{lmer} to a \code{data frame}. The output of \code{lmer} is an object of class \code{merMod}.
When the \code{LMM} fixed effect assumes more than two values, the fields \code{sample_type_field_name} and \code{sample_type_field_name_mapped} should be specified.
This class is derived from \code{LMMToDataFrameMapperAbstract}.
}
\usage{
lmmLmerToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
lmmLmerToDataFrameMapper$map(LMM_output, gene_id, sample_type_field_name, sample_type_field_name_mapped)
}
\arguments{
  \item{LMM_output}{
    Output of \code{lmer}.
    \itemize{
      \item Type: \code{merMod}.
    }
  }
  \item{gene_id}{
    Gene id. If present, a column called \code{gene_id} is added. The column is populated with the same value \code{"gene_id"}.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{sample_type_field_name}{
    The name of the field in \code{LMM_output} that contains the type of RNA analysis sample (e.g., "tissue_type"). This represents the fixed effect.
    It is not necessary when the fixed effect has only two values.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{sample_type_field_name_mapped}{
    If \code{sample_type_field_name} is specified, this argument defines the output column name that contains the values of the fixed effect (\code{sample_type_field_name} in \code{LMM_output}).
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_type"}.
    }
  }
}
\value{
\code{Data frame}. Columns: \code{sample_type_field_name_mapped} (optional), \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}.
The \code{lmer} function does not return the parameter \code{p-value}; hence, the output does not contain the columns \code{p.value} and \code{adj.p.value}.
}
\examples{
LMM_output <- merMod
gene_id <- "DDR1"
sample_type_field_name <- "pert_iname"
sample_type_field_name_mapped <- "drug"
lmmLmerToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
lmmLmerToDataFrameMapper$map(LMM_output, gene_id, sample_type_field_name, sample_type_field_name_mapped)
# Output example:
# drug            gene_id   DE_log2_FC   std.error   t.value
# AM-251          DDR1      -0.047038    0.073635    -0.639
# AM-404          DDR1      -0.199576    0.071673    -2.785
# AM-580          DDR1       0.051221    0.055126     0.929
}
