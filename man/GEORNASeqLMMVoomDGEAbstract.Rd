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
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_names, sample_status_column_name, filter_by_protein_coding) {
      # do something
    }
  )
)
}
\arguments{
  \item{rna_seq_data_filename}{
    Name of the file containing the RNA-Seq data.
    \cr
    The file must be in TSV (tab-separated values) format, optionally compressed in GZ format, and must comply with the GEO NCBI specification.
    \cr
    The file contains a table of RNA-Seq data.\cr
    The table should have gene IDs in the first column (named \code{GeneID}) and RNA-Seq analysis identifiers (sample IDs) as subsequent column headers.
    Each row represents a gene, and each column represents an RNA-Seq sample.
    \cr
    The filename can be a local path (e.g., \file{/user/rna/raw_counts.tsv}) or a URL (e.g., \url{https://www.ncbi.gov/geo/download/raw_counts.tsv.gz}).
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{rna_seq_metadata}{
    RNA-seq metadata table associated with the RNA-seq data table.\cr
    The metadata contains the control/altered state of the samples, along with additional conditions (e.g., sample origin).\cr
    For each RNA-seq sample column in the RNA-seq data table, there must be a corresponding row in the \code{rna_seq_metadata} table.\cr
    One column of \code{rna_seq_metadata} must be named \code{"sample_id"} and must contain the sample IDs of the RNA-seq experiments.
    This column is used to filter \code{rna_seq_data}: \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}.\cr
    The status column must be a factor, and the first level of the factor must correspond to the \code{"control"} state.\cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    See example below.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula}{
    The formula used for LMM computation. The formula may include both fixed and random effects to account for the conditions under which the RNA-seq experiments were performed.
    \cr
    Because data and metadata are stored in separate tables, the dependent variable (to the left of the \code{~} operator) must not be specified.
    For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{formula}.
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
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
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
# ---------------------------------------------------------------
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
# -------------------------------------------------------------------
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
    compute = function(rna_seq_data_filename, rna_seq_metadata, formula, random_effect_column_names, sample_status_column_name, filter_by_protein_coding) {
      # do something
    }
  )
)
}
