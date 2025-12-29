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
  rna_seq_data_filename, rna_seq_metadata, formula,
  filter_by_protein_coding
)
}
\arguments{
  The \code{compute} function arguments are identical to those in GEORNASeqLMMVoomDGEAbstract.

  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{GeneFilterAbstract}.
      \item Default value: Instance of class \code{LowCountsGeneFilter}.
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
  rna_seq_data_filename, rna_seq_metadata, formula,
  filter_by_protein_coding
)

# output is the same as in GEORNASeqLMMVoomDGECore
}
