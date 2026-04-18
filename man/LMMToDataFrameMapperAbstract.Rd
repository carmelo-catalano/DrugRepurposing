\name{LMMToDataFrameMapperAbstract}
\alias{LMMToDataFrameMapperAbstract}
\title{Base class for mapping LMM output to a data frame}
\description{
Base class for mapping the output of an LMM computation to a \code{data frame}, enabling easy usage with functions in this package.
\cr
When the LMM fixed effect assumes more than two values, the \link{DGE} is computed for
each value of the fixed effect except for the control state. In this case,
\code{fixed_effect_column_name} and \code{fixed_effect_new_column_name} should be specified.
\cr
This package provides two implementations: \code{LMMJuliaToDataFrameMapper} and \code{LMMLmerToDataFrameMapper}.
}
\usage{
LMMToDataFrameMapperImpl <- R6Class(
  "LMMToDataFrameMapperImpl",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id = NA, fixed_effect_column_name, fixed_effect_new_column_name) {
      # do something
    }
  )
)
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
}
\value{
\code{Data frame}. Columns: \code{fixed_effect_new_column_name} (optional), \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
LMMToDataFrameMapperImpl <- R6Class(
  "LMMToDataFrameMapperImpl",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_id = NA, fixed_effect_column_name, fixed_effect_new_column_name) {
      # do something
    }
  )
)
}
