\name{LINCSLMMLmerToDataFrameMapper}
\alias{LINCSLMMLmerToDataFrameMapper}
\title{Maps the output of LINCS lmer to a data frame}
\description{
Maps the output of \link{LINCS} \code{lmer} to a \code{data.frame}. The output of \code{lmer} is an object of class \code{merMod}.
\cr
When the LMM fixed effect assumes more than two values, the \link{DGE} is computed for
each value of the fixed effect except for the control state. In this case,
\code{fixed_effect_column_name} and \code{fixed_effect_new_column_name} should be specified.
\cr
This class is derived from \code{LINCSLMMToDataFrameMapperAbstract}.
}
\usage{
lincsLMMLmerToDataFrameMapper <- LINCSLMMLmerToDataFrameMapper$new()
lincsLMMLmerToDataFrameMapper$map(LMM_output, gene_id, fixed_effect_column_name, fixed_effect_new_column_name, LINCS_drug_rename_column_name)
}
\arguments{
  \item{LMM_output}{
    Output of \code{lmer}.
    \itemize{
      \item Type: \code{merMod}.
    }
  }
  \item{gene_id}{
    Gene id. If specified, it is added to the output table. The column is populated with the same value \code{"gene_id"}.
    \cr
    It is not used for the computation.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{fixed_effect_column_name}{
    This field is needed when fixed effect assumes more then two values.
    \code{fixed_effect_column_name} specifies the name of the fixed effect of the LMM.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{NA}.
    }
  }
  \item{fixed_effect_new_column_name}{
    When the \code{LMM} fixed effect assumes more than two values, the \link{DGE} is computed for
    each value of the fixed effect except for the control state.
    \cr
    \code{fixed_effect_new_column_name} specify the name of the column containing the DGE in
    the LMM output table.
    \cr
    If \code{fixed_effect_new_column_name = NULL} then \code{fixed_effect_column_name} will be used.
    \cr
    This field is needed when fixed effect assumes more then two values.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{NA}.
    }
  }
  \item{LINCS_drug_rename_column_name}{
    The drug names in \link{LINCS} are prefixed by the string "pert_iname".
    The default value is "pert_iname", set it to \code{NA} for not removing the prefix or change.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{pert_iname}.
    }
  }
}
\value{
\code{Data frame}. Columns: \code{fixed_effect_new_column_name} (optional), \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
LMM_output <- merMod
gene_id <- "DDR1"
fixed_effect_column_name <- "pert_iname"
fixed_effect_new_column_name <- "drug"
lincsLMMLmerToDataFrameMapper <- LINCSLMMLmerToDataFrameMapper$new()
lincsLMMLmerToDataFrameMapper$map(LMM_output, gene_id, fixed_effect_column_name, fixed_effect_new_column_name)
# Output example:
# drug            gene_id   DE_log2_FC   std.error   t.value
# ----------------------------------------------------------
# AM-251          DDR1      -0.047038    0.073635    -0.639
# AM-404          DDR1      -0.199576    0.071673    -2.785
# AM-580          DDR1       0.051221    0.055126     0.929
}
