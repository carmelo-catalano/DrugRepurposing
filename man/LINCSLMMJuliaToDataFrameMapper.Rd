\name{LINCSLMMToDataFrameMapperAbstract}
\alias{LINCSLMMToDataFrameMapperAbstract}
\title{Maps the LINCS julia_call fit output to a data frame}
\description{
Maps the output of \link{LINCS} \code{LMMJulia} to a \code{data.frame}. Since the output of a
Julia call is an R environment, it needs to be mapped.
\cr
When the LMM fixed effect assumes more than two values, the \link{DGE} is computed for
each value of the fixed effect except for the control state. In this case,
\code{fixed_effect_column_name} and \code{fixed_effect_new_column_name} should be specified.
\cr
This class is derived from \code{LMMToDataFrameMapperAbstract}.
\cr
To use this function, the Julia environment must be installed on the system.
}
\usage{
lincsLMMJuliaToDataFrameMapper <- LINCSLMMJuliaToDataFrameMapper$new()
lincsLMMJuliaToDataFrameMapper$map(LMM_output, gene_id, fixed_effect_column_name, fixed_effect_new_column_name, LINCS_drug_rename_column_name)
}
\arguments{
  \item{LMM_output}{
    Output of \code{julia_call}.
    \itemize{
      \item Type: \code{R environment}.
    }
  }
  \item{gene_id}{
    Gene id. If specified, it is added to the output table. The column is populated with the same value \code{"gene_id"}.
    \cr
    It is not used for the computation.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{fixed_effect_column_name}{
    This field is needed when fixed effect assumes more then two values.
    \code{fixed_effect_column_name} specifies the name of the fixed effect of the LMM.
    \itemize{
      \item Type: \code{string}.
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
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{LINCS_drug_rename_column_name}{
    The drug names in \link{LINCS} are prefixed by the string "pert_iname".
    The default value is "pert_iname", set it to \code{NA} for not removing the prefix or change.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{pert_iname}.
    }
  }
}
\value{
\code{Data frame}. Columns: \code{fixed_effect_new_column_name} (optional), \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
# For a complete example see LMMJulia

LMM_output <- new.env() # R environment
gene_id <- "DDR1"
fixed_effect_column_name <- "pert_iname"
fixed_effect_new_column_name <- "drug"
lincsLMMJuliaToDataFrameMapper <- LINCSLMMJuliaToDataFrameMapper$new()
lincsLMMJuliaToDataFrameMapper$map(LMM_output, gene_id, fixed_effect_column_name, fixed_effect_new_column_name)
# Output example:
# drug            gene_id   DE_log2_FC   std.error   t.value      p.value     adj.p.value
# ----------------------------------------------------------------------------------------
# AM-251          DDR1      -0.600250    0.7667697   -0.7828296   0.4337272   0.9114472
# AM-404          DDR1      -0.290125    0.7667697   -0.3783731   0.7051535   0.9114472
# AM-580          DDR1      -0.085275    0.7667697   -0.1112133   0.9114472   0.9114472
}
