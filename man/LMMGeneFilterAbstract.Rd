\name{LMMGeneFilterAbstract}
\alias{LMMGeneFilterAbstract}
\title{Abstract base class for implementing RNA data filtering suitable for LMM analysis}
\description{
Typically, this class implementation filters non-significant genes from RNA data and samples associated with low-level grouping variables of a random effect.
\cr
This package provides three implementation: \code{\link{LMMLogarithmGeneFilter}}, \code{\link{LMMLowCountsGeneFilter}}, and \code{\link{LMMNoGeneFilter}}.
\cr
Base class for constructor parameter \code{lmmGeneFilter} of the classes \code{\link{GEORNASeqLMMDataMetadataLoader}}, \code{\link{GEORNASeqLMMVoomDGECore}},
\code{\link{GEORNASeqLMMVoomDGELmer}}, \code{\link{GEORNASeqLMMVoomDGECore}}, \code{\link{GEORNASeqLMMVoomDGEDream}}, \code{\link{GEORNASeqLMMVoomDGEDreamWithEBayes}},
and \code{\link{GEORNASeqLMMVoomDGEJulia}}.
}
\usage{
LMMGeneFilterImpl <- R6Class(
  "LMMGeneFilterImpl",
  inherit = LMMGeneFilterAbstract,
  public = list(
    filter = function(rna_data, rna_metadata, random_effect_column_names, sample_status_column_name) {
      # do something
    }
  )
)
}
\arguments{
  \item{rna_data}{
    Table of RNA data analysis, which may include RNA-Seq, Microarray data, or other types, depending on the derived class.
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
      \item Type: \code{string}.
    }
  }
  \item{sample_status_column_name}{
    This argument specifies the name of the samples status column used to filter out non-significant genes.
    \cr
    See \code{\link{LowCountsGeneFilter}} for more information.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_status"}
    }
  }
}
\value{
    Filtered \code{rna_data}.
}
\examples{
LMMGeneFilterImpl <- R6Class(
  "LMMGeneFilterImpl",
  inherit = LMMGeneFilterAbstract,
  public = list(
    filter = function(rna_data, rna_metadata, random_effect_column_names, sample_status_column_name) {
      # do something
    }
  )
)
}

