\name{LINCSMetadataSetuperAbstract}
\alias{LINCSMetadataSetuperAbstract}
\title{Base class for the constructor parameter lincsMetadataSetuper of the class LINCSExport}
\description{
Base class for the constructor parameter \code{lincsMetadataSetuper} of the class \code{LINCSExport}.
\cr
Configure the metadata in GSE92742_Broad_LINCS_inst_info.txt to read gene RNA experiments data from the
LINCS archive.
\cr
The package includes one implementation: LINCSMetadataSetuper.
}
\usage{
LINCSMetadataSetuperImpl <- R6Class(
  "LINCSMetadataSetuperImpl",
  inherit = LINCSMetadataSetuperAbstract,
  public = list(
    setup = function(perturbation_times, rna_plates, cell_types, drugs) {
      # do something
    }
  )
)
}
\arguments{
  \item{perturbation_times}{
    List of perturbation times.
    \itemize{
      \item Type: \code{string vector}.
    }
  }
  \item{drugs_filter}{
    List of drugs for which the DGE will be computed.
    \itemize{
      \item Type: \code{vector}.
      \item Default value: NA.
    }
  }
}
\value{
Data frame containing configured LINCS metadata. Columns: \code{inst_id},
\code{rna_plate}, \code{pert_id}, \code{pert_iname}, \code{pert_time}, \code{and cell_id}.
}
