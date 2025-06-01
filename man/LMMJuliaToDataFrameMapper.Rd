\name{LMMJuliaToDataFrameMapper}
\alias{LMMJuliaToDataFrameMapper}
\title{Maps the output of LMMJulia to a data frame}
\description{
Maps the output of \code{LMMJulia} to a \code{data frame}. Since the output of a Julia call is an R environment, it needs to be mapped.
When the LMMfixed effect takes on more than two values, the fields \code{sample_type_field_name} and \code{sample_type_field_name_mapped} must be specified.
This class is derived from \code{LMMToDataFrameMapperAbstract}.
To use this function, the Julia environment must be installed on the system.
}
\usage{
lmmJuliaToDataFrameMapper <- LMMJuliaToDataFrameMapper$new()
lmmJuliaToDataFrameMapper$map(LMM_output, gene_id, sample_type_field_name, sample_type_field_name_mapped)
}
\arguments{
  \item{LMM_output}{
    Output of julia_call.
    \itemize{
      \item Type: \code{R environment}.
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
    If \code{sample_type_field_name} is specified, this argument defines the output column name that contains the values of fixed effect (\code{sample_type_field_name} in \code{LMM_output}).
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_type"}.
    }
  }
}
\value{
Data frame. Columns: \code{sample_type_field_name_mapped} (optional), \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
# For a complete example see LMMJulia

LMM_output <- new.env() # R environment
gene_id <- "DDR1"
sample_type_field_name <- "pert_iname"
sample_type_field_name_mapped <- "drug"
lmmJuliaToDataFrameMapper <- LMMJuliaToDataFrameMapper$new()
lmmJuliaToDataFrameMapper$map(LMM_output, gene_id, sample_type_field_name, sample_type_field_name_mapped)
# Output example:
# drug            gene_id   DE_log2_FC   std.error   t.value      p.value     adj.p.value
# AM-251          DDR1      -0.600250    0.7667697   -0.7828296   0.4337272   0.9114472
# AM-404          DDR1      -0.290125    0.7667697   -0.3783731   0.7051535   0.9114472
# AM-580          DDR1      -0.085275    0.7667697   -0.1112133   0.9114472   0.9114472
}
