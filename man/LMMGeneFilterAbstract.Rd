\name{LMMGeneFilterAbstract}
\alias{LMMGeneFilterAbstract}
\title{Abstract base class for implementing RNA data filtering suitable for LMM analysis}
\description{
Typically, this class implementation filters non-significant genes from RNA data and samples associated with low-level grouping variables of a random effect.
\cr
This package provides three implementation: \code{LMMLogarithmGeneFilter}, \code{LMMLowCountsGeneFilter}, and \code{LMMNoGeneFilter}.
\cr
Base class for constructor parameter \code{lmmGeneFilter} of the classes \code{GEORNASeqLMMDataMetadataLoader}, \code{GEORNASeqLMMVoomDGECore},
\code{GEORNASeqLMMVoomDGELmer}, \code{GEORNASeqLMMVoomDGECore}, \code{GEORNASeqLMMVoomDGEDream}, \code{GEORNASeqLMMVoomDGEDreamWithEBayes},
and \code{GEORNASeqLMMVoomDGEJulia}.
}
\usage{
LMMGeneFilterImpl <- R6Class(
  "LMMGeneFilterImpl",
  inherit = LMMGeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, metadata, random_effect_column_names, counts_filter_column_name) {
      # do something
    }
  )
)
}
\arguments{
  \item{gene_expressions}{
    Table of RNA data. Each column represents an RNA data sample, and each row represents a gene.
    Row names are gene IDs, and column names are experiment identifiers.
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
  \item{sample_statuses}{
    Each element in the \code{sample_statuses} vector represents the status of the corresponding RNA data sample column (by position) in the expression matrix.
    \itemize{
      \item Type: \code{vector}.
    }
  }
}
\value{
Filtered \code{gene_expressions}.
}
\examples{
LMMGeneFilterImpl <- R6Class(
  "LMMGeneFilterImpl",
  inherit = LMMGeneFilterAbstract,
  public = list(
    filter = function(gene_expressions, metadata, random_effect_column_names, counts_filter_column_name) {
      # do something
    }
  )
)
}

