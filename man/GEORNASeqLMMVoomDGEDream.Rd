\name{GEORNASeqLMMVoomDGEDream}
\alias{GEORNASeqLMMVoomDGEDream}
\title{Computes differential gene expression analysis using LMM with Voom-transformed data}
\description{
Derived class of \code{GEORNASeqLMMVoomDGEAbstract}.
\cr
Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom-transformed data.
The entire computation is performed using \code{GEORNASeqLMMVoomDGECore}, instantiated with the constructor argument \code{lmmVoomDGE} of type \code{LMMVoomDGEDream}.
\cr
For more details, see \code{GEORNASeqLMMVoomDGECore}.
}
\usage{
geoRNASeqLMMVoomDGEDream <- GEORNASeqLMMVoomDGEDream$new()
result <- geoRNASeqLMMVoomDGEDream$compute(
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

geoRNASeqLMMVoomDGEDream <- GEORNASeqLMMVoomDGEDream$new()
geoRNASeqLMMVoomDGEDream$compute(
    rna_seq_data_filename, rna_seq_metadata, formula,
    filter_by_protein_coding
 )

# output is the same as in GEORNASeqLMMVoomDGECore
}
