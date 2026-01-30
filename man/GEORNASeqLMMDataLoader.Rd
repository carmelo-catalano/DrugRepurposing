\name{GEORNASeqLMMDataLoader}
\alias{GEORNASeqLMMDataLoader}
\title{Load RNA-seq data from files sourced from NCBI}
\description{
Load RNA-seq data from files sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
These data must be suitable for Linear Mixed Model (LMM) analysis.
The files can be either local or remote (typically hosted by NCBI).
See example.
}
\usage{
geoRNASeqLMMDataLoader <- GEORNASeqLMMDataLoader$new()
geoRNASeqLMMDataLoader$load(rna_seq_data_filename, rna_seq_metadata)
}
\arguments{
  \item{rna_seq_data_filename}{
    Filename for RNA-seq data compatible with the Gene Expression Omnibus (GEO) format. The file must be in tsv (tab-separated value) format.
    \cr
    The file may also be compressed in gz format.
    \cr
    The first column contains the gene ID; the other columns contain the RNA-Seq analysis. The first column name is \code{GeneID}, and the rest of the columns are titled according to the RNA analysis identifiers (sample id).
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    See example below.
    Type: \code{string}.
  }
    \item{rna_seq_metadata}{
    \code{rna_seq_metadata} contain metadata for \code{rna_seq_data}.
    \code{rna_seq_metadata} must contain a column called "\code{sample_id}",
    this column is used as a filter for rna_seq_data: rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]
    \cr
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \cr
    See example below.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{GeneFilterAbstract}.
      \item Default value: instance of class \code{LowCountsGeneFilter}.
    }
  }
}
\value{
Data frame. Table of RNA data. Each column represents an RNA analysis, and each row represents a gene.
Row names are gene IDs; column names are experiment IDs. See example.
}
\examples{

# rna_seq file content example:
#
#  GeneID   GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7   GSM8
#  1        817    480    513    497    105    123    455    244
#  2        451    315    489    620    762    244    572    234
#  9        792    608    560    585    952    436    823    981
#  12       220    244    283    404    434    196    314    225
#  13       142    229    240    350    332    163    239    324
#  14       682    501    354    669    721    520    550    755
#  21       230    133    830    159    127    191    186    100
#  25       102    605    246    368    611    588    654    811

# rna_seq_metadata example:
#
# sample_id      tissue                subject_id     tissue_status
# GSM1           Spinal Cord Lumbar    NEUEL133AK6   ALS Spectrum MND
# GSM2           Spinal Cord Lumbar    NEUYV496XLP   ALS Spectrum MND
# GSM3           Spinal Cord Lumbar    NEUZU200WEQ   ALS Spectrum MND
# GSM4           Spinal Cord Lumbar    NEUEC006FND   Non-Neurological Control
# GSM5           Spinal Cord Lumbar    NEUKM699KKH   ALS Spectrum MND
# GSM6           Cerebellum            NEUJZ255ZC5   ALS Spectrum MND
# GSM7           Cerebellum            NEUJZ233ZL3   Non-Neurological Control
#
# sample_id column is used as a filter for rna_seq_data:
# rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]
# the GSM8 column of rna_seq_data will be discarded before computation.

rna_seq_metadata_filename <- "unit_test_data/voom/gse153960_metadata.csv"
geoRNASeqLMMDataLoader <- GEORNASeqLMMDataLoader$new()
geoRNASeqLMMDataLoader$load(rna_seq_data_filename, rna_seq_metadata)

}
