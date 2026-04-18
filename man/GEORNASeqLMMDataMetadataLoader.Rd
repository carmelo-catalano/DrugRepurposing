\name{GEORNASeqLMMDataMetadataLoader}
\alias{GEORNASeqLMMDataMetadataLoader}
\title{Load RNA-Seq data from files sourced from NCBI along with the corresponding metadata}
\description{
Load RNA-Seq data from files sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}) along with the corresponding metadata.
These data and metadata must be suitable for Linear Mixed Model (LMM) analysis.
}
\usage{
geoRNASeqLMMDataMetadataLoader <- GEORNASeqLMMDataMetadataLoader$new()
geoRNASeqLMMDataMetadataLoader$load(rna_seq_data_filename, rna_seq_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name, additional_columns)
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
    This package has been tested on Illumina RNA-Seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{rna_seq_metadata_filename}{
    Filename of a CSV file delimited by ";".
    The file contains metadata for the RNA-Seq data in \code{rna_seq_data_filename}.\cr
    One column of the CSV must contain the sample IDs. This column is used to subset the rna_seq_data object:
    (assuming the sample ID column is named "sample_id")
    \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}
    \cr
    The metadata contains the control/altered state of the samples, along with additional conditions (e.g., sample origin).\cr
    \cr
    This package has been tested on Illumina RNA-Seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{random_effect_column_name}{
    This argument specifies the name of the random effect column used to filter out low-level grouping variables.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_status_column_name}{
    Name of the column containing the sample statuses. The status represents the clinical condition of each sample (e.g., control, disease). Example of column values: "Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND, Other Neurological Disorders", "Other Neurological Disorders".
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_statuses_to_be_tested}{
    Vector containing the names of the sample statuses to be tested. The statuses are stored in the column \code{sample_status_column_name}.
    The “Control” status must be the first element of \code{sample_statuses_to_be_tested}; see \code{sample_statuses_map}.
    \cr
    Example: c("Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND, Other Neurological Disorders").
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{sample_statuses_map}{
    Vector specifying the type (Control or Disease) for each element in \code{sample_statuses_to_be_tested}.
    The “Control” status must be the first element of \code{sample_statuses_map}, and \code{sample_statuses_to_be_tested} must be ordered accordingly.
    \cr
    Example: for the vector in the example \code{sample_statuses_to_be_tested}, the map could be c("Control","ALS","ALS").
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{sample_id_column_name}{
    Each row in the metadata matrix represents the metadata for a single RNA-Seq experiment.
    \code{sample_id_column_name} is the column name containing the RNA-Seq experiment IDs.
    See example below.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"accession"}.
    }
  }
  \item{additional_columns}{
    Names of additional columns, other than \code{sample_status_column_name}, to be used in the LMM computation.
    \itemize{
      \item Type: \code{vector}.
      \item Default value: \code{NA}.
    }
  }
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
List containing two items:
\cr
1) \code{rna_seq_metadata}:\cr
Data frame containing data extracted from the file \code{rna_seq_metadata_filename}.
\cr
The data frame includes the columns \code{"sample_id"}, \code{sample_status_column_name}, and \code{additional_columns}.
\cr
\code{"sample_id"} is the first column.
\cr
\code{sample_status_column_name} is a factor, with the “Control” status as the first level.
\cr
\cr
2) \code{rna_seq_data}:\cr
Matrix containing RNA-Seq analysis data. It corresponds to the content of the file \code{rna_seq_data_filename}, except that rows and columns may be filtered, and the first column of \code{rna_seq_data_filename} is used as column names.
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

# rna_seq_metadata file content example:
#
# accession   tissue            subject_id    tissue_status                                    library_method
# ------------------------------------------------------------------------------------------------------------------
# GSM1        Cerebellum        NEUEL133AK6   ALS Spectrum MND                                 Manual KAPA Total
# GSM2        Cerebellum        NEUYV496XLP   ALS Spectrum MND, Other Neurological Disorders   Manual KAPA Total
# GSM3        Cortex Sensory    NEUZU200WEQ   ALS Spectrum MND                                 Manual KAPA Total
# GSM4        Cortex Frontal    NEUEC006FND   Non-Neurological Control                         Manual KAPA Total
# GSM5        Cortex Sensory    NEUKM699KKH   Non-Neurological Control                         Automated KAPA Total
# GSM6        Cortex Frontal    NEUJZ255ZC5   ALS Spectrum MND                                 Automated KAPA Total
# GSM7        Cerebellum        NEUXT979EZV   ALS Spectrum MND, Other Neurological Disorders   Automated KAPA Total

#
# sample_id column is used as a filter for rna_seq_data:
# rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]
# the GSM8 column of rna_seq_data will be discarded before computation.

rna_seq_data_filename <- "GSE153960_raw_counts_GRCh38.p13_NCBI_first_50.tsv"
rna_seq_metadata_filename <- "gse153960_metadata.csv"
sample_status_column_name <- "tissue_status"
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND, Other Neurological Disorders")
sample_statuses_map <- c("Control", "ALS", "ALS")
sample_id_column_name <- "accession"
additional_columns <- "tissue"

geoRNASeqLMMDataMetadataLoader <- GEORNASeqLMMDataMetadataLoader$new()
rna_seq_metadata <- geoRNASeqLMMDataMetadataLoader$load(
    rna_seq_data_filename,
    rna_seq_metadata_filename,
    sample_status_column_name,
    sample_statuses_to_be_tested,
    sample_statuses_map,
    sample_id_column_name,
    additional_columns
)
# output

# rna_seq_metadata
# sample_id   tissue               tissue_status
# ----------------------------------------------
# GSM1        Cerebellum           ALS
# GSM2        Cerebellum           ALS
# GSM3        Cortex Sensory       ALS
# GSM4        Cortex Frontal       Control
# GSM5        Cortex Sensory       Control
# GSM6        Cortex Frontal       ALS
# GSM7        Cerebellum           ALS

# rna_seq_data
#           GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7
# --------------------------------------------------------
#  1        817    480    513    497    105    123    455
#  2        451    315    489    620    762    244    572
#  9        792    608    560    585    952    436    823
#  12       220    244    283    404    434    196    314
#  13       142    229    240    350    332    163    239
#  14       682    501    354    669    721    520    550
#  21       230    133    830    159    127    191    186
#  25       102    605    246    368    611    588    654

}
