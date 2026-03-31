\name{LINCSMetadataSetuperAbstract}
\alias{LINCSMetadataSetuperAbstract}
\title{Base class for the constructor parameter lincsMetadataSetuper of the class LINCSExport}
\description{
Base class for the constructor parameter \code{lincsMetadataSetuper} of the class \code{LINCSExport}.
\cr
Configure the metadata in GSE92742_Broad_LINCS_inst_info.txt to read gene RNA experiments data from the
LINCS archive.
\cr
See \code{\link{LINCSMetadataSetuper}} for more information.
\cr
The package includes one implementation: \code{\link{LINCSMetadataSetuper}}.
}
\usage{
LINCSMetadataSetuperImpl <- R6Class(
  "LINCSMetadataSetuperImpl",
  inherit = LINCSMetadataSetuperAbstract,
  public = list(
    setup = function(drug_perturbation_times, rna_plates, cell_types, drugs) {
      # do something
    }
  )
)
}
\arguments{
  \item{drug_perturbation_times}{
    List of drug perturbation times.
    Drug perturbation time is the duration for which the sample is treated with the drug.
    \itemize{
      \item Type: \code{character vector}.
    }
  }
  \item{drugs_filter}{
    List of drugs for which the DGE will be computed.
    \itemize{
      \item Type: \code{vector}.
    }
  }
}
\value{
Data frame containing configured LINCS metadata. Columns: \code{inst_id},
\code{rna_plate}, \code{pert_id}, \code{pert_iname}, \code{pert_time}, \code{and cell_id}.
}
\examples{
LINCSMetadataSetuperImpl <- R6Class(
  "LINCSMetadataSetuperImpl",
  inherit = LINCSMetadataSetuperAbstract,
  public = list(
    setup = function(drug_perturbation_times, rna_plates, cell_types, drugs) {
      # do something
    }
  )
)
}
