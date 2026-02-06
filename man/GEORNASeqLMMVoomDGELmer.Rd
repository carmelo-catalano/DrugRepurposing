\name{GEORNASeqLMMVoomDGELmer}
\alias{GEORNASeqLMMVoomDGELmer}
\title{Computes differential gene expression analysis using LMM with Voom-transformed data}
\description{
Derived class of \code{GEORNASeqLMMVoomDGEAbstract}.
\cr
Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom-transformed data.
\cr
The entire computation is performed using \code{GEORNASeqLMMVoomDGECore}.
\code{GEORNASeqLMMVoomDGECore} is instantiated with the constructor argument \code{lmmVoomDGE} of
type \code{LMMVoomDGEJulia}.
\cr
See \code{GEORNASeqLMMVoomDGECore} for more information.
}
\usage{
geoRNASeqLMMVoomDGELmer <- GEORNASeqLMMVoomDGELmer$new()
result <- geoRNASeqLMMVoomDGELmer$compute(
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
\cr
\code{Lmer} does not return p-value fields. Therefore, when LMM is computed using \code{lmer}, the fields \code{p.value} and \code{adj.p.value} are not included.
}
\examples{
# Input data are the same as in GEORNASeqLMMVoomDGECore.

geoRNASeqLMMVoomDGELmer <- GEORNASeqLMMVoomDGELmer$new()
result <- geoRNASeqLMMVoomDGELmer$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  counts_filter_column_name,
  filter_by_protein_coding
)

# output is the same as in GEORNASeqLMMVoomDGECore
}
