\name{GEORNASeqLMMVoomDGEAbstract}
\alias{GEORNASeqLMMVoomDGEAbstract}
\title{Base class for computing differential gene expression using Linear Mixed Models and Voom-transformed data}
\description{
Base class for the constructor parameter \code{lmmVoomDGE} of the class \code{GEORNASeqLMMVoomDGE}.
\cr
This class computes differential gene expression analysis using the Linear Mixed Model (LMM) with
Voom-transformed data.
\cr
RNA-seq data and metadata files are sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
GEORNASeqLMMVoomDGEImpl <- R6Class(
  "GEORNASeqLMMVoomDGEImpl",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_names, counts_filter_column_name, filter_by_protein_coding) {
      # do something
    }
  )
)
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
    rna_seq_data_filename can be either a local path or a remote URL (typically hosted by NCBI), example:
    https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE92592&file=GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz\cr
    See example below.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{rna_seq_metadata}{
    \code{rna_seq_metadata} contain metadata for \code{rna_seq_data}.
    The first column of \code{rna_seq_metadata} must be named "\code{sample_id}" and must contain the sample IDs of the RNA-seq experiments.
    This column is used to filter \code{rna_seq_data}: \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}.
    \cr
    The metadata contains the status control/altered state of the sample and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \cr
    See example below
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-seq experiments were performed.
    \cr
    Because data and metadata are in separate files, the dependent variable to the left of the ~ operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{random_effect_column_name}{
    This argument specifies the name of the random effect column used to filter out low-level grouping variables.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{counts_filter_column_name}{
    This argument specifies the name of the samples status column used to filter out non-significant genes.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} represents differential expression = log2 fold change.
\cr
\code{Lmer} does not return p-value fields. Therefore, when LMM is computed using \code{lmer}, the fields \code{p.value} and \code{adj.p.value} are not included.
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

GEORNASeqLMMVoomDGEImpl <- R6Class(
  "GEORNASeqLMMVoomDGEImpl",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_names, counts_filter_column_name, filter_by_protein_coding) {
      # do something
    }
  )
)
}
