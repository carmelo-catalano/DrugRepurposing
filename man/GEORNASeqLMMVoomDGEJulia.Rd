\name{GEORNASeqLMMVoomDGEJulia}
\alias{GEORNASeqLMMVoomDGEJulia}
\title{Computes differential gene expression analysis using LMM with Voom-transformed data}
\description{
Derived class of \code{GEORNASeqLMMVoomDGEAbstract}.
\cr
This implementation is up to 60 times faster than the other two implementations.
\cr
Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom-transformed data.
\cr
The entire computation is performed using \code{GEORNASeqLMMVoomDGECore}. \code{GEORNASeqLMMVoomDGECore} is instantiated with the constructor argument \code{lmmVoomDGE} of type \code{LMMVoomDGEJulia}.
\cr
See \code{GEORNASeqLMMVoomDGECore} for more information.
}
\usage{
geoRNASeqLMMVoomDGEJulia <- GEORNASeqLMMVoomDGEJulia$new()
result <- geoRNASeqLMMVoomDGEJulia$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  sample_status_column_name,
  filter_by_protein_coding
)
}
\arguments{
  The \code{compute} function arguments are identical to those in \code{\link{GEORNASeqLMMVoomDGEAbstract}}.

  \item{lmmGeneFilter (constructor argument)}{
    Instance of a class used to filter RNA data suitable for LMM analysis.\cr
    See \code{\link{LMMGeneFilterAbstract}} for more information.
    \itemize{
      \item Type: a class derived from \code{\link{LMMGeneFilterAbstract}}.
      \item Default value: an instance of \code{\link{LMMLowCountsGeneFilter}}.
    }
  }
}
\value{
Same as in GEORNASeqLMMVoomDGEAbstract.
}
\examples{
# Input data are the same as in GEORNASeqLMMVoomDGECore.

geoRNASeqLMMVoomDGEJulia <- GEORNASeqLMMVoomDGEJulia$new()
result <- geoRNASeqLMMVoomDGEJulia$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  sample_status_column_name,
  filter_by_protein_coding
)

# output is the same as in GEORNASeqLMMVoomDGECore
}
