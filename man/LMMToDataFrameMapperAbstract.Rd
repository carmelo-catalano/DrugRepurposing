\name{LMMToDataFrameMapperAbstract}
\alias{LMMToDataFrameMapperAbstract}
\title{Base class for mapping LMM output to a data frame}
\description{
Base class for mapping the output of an LMM computation to a \code{data frame}, enabling easy usage with functions in this package.
\code{LMMToDataFrameMapperAbstract} is also used as a base class for the \code{lmmToDataFrameMapper} constructor parameter in the \code{LMMDGEByGene} class.
This package provides two implementations: \code{LMMJuliaToDataFrameMapper} and \code{LMMLmerToDataFrameMapper}.
}
\usage{
LMMToDataFrameMapperImpl <- R6Class(
  "LMMToDataFrameMapperImpl",
  inherit = LMMToDataFrameMapperAbstract,
  public = list(
    map = function(LMM_output, gene_symbol = NA, sample_type_field_name, sample_type_field_name_mapped) {
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
    Gene ID. If present, a column called \code{gene_id} is added. The column is populated with the same value \code{"gene_id"}.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{sample_type_field_name}{
    The name of the field in \code{LMM_output} that contains the type of RNA analysis sample (e.g., \code{"tissue_type"}). This represents the fixed effect.
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
\code{Data frame}. Columns: \code{sample_type_field_name_mapped} (optional), \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}

