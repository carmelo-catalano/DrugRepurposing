\name{GEORNASeqLMMMetadataLoader}
\alias{GEORNASeqLMMMetadataLoader}
\title{Load RNA-Seq data from files sourced from NCBI along with the corresponding metadata}
\description{
Load RNA-Seq data from files sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}) along with the corresponding metadata.
These data and metadata must be suitable for Linear Mixed Model (LMM) analysis.
}
\usage{
geoRNASeqLMMDataLoader <- GEORNASeqLMMMetadataLoader$new()
geoRNASeqLMMDataLoader$load(rna_seq_metadata_filename, sample_status_column_name, sample_statuses_to_be_tested, sample_statuses_map, sample_id_column_name, additional_columns)
}
\arguments{
  \item{rna_seq_metadata_filename}{
    Filename of a CSV file delimited by ";".
    The file contains metadata for the RNA-Seq data in \code{rna_seq_data_filename}.
    One column of the CSV must contain the sample IDs. This column is used to subset the rna_seq_data object:
    (assuming the sample ID column is named "sample_id")
    \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}
    \cr
    The metadata contain the control/altered status of each sample, along with additional conditions.
    \cr
    This package has been tested on Illumina RNA-Seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \cr
    See example below.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{sample_status_column_name}{
    Name of the column containing the sample statuses. The status represents the clinical condition of each sample (e.g., control, disease). Example of column values: "Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND, Other Neurological Disorders", "Other Neurological Disorders".
    \itemize{
      \item Type: \code{character}.
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
      \item Type: \code{character}.
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
}
\value{
Data frame containing data extracted from the file \code{rna_seq_metadata_filename}.
\cr
The data frame includes the columns \code{"sample_id"}, \code{sample_status_column_name}, and \code{additional_columns}.
\cr
\code{"sample_id"} is the first column.
\cr
\code{sample_status_column_name} is a factor, with the “Control” status as the first level.
}
\examples{
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

rna_seq_metadata_filename <- "gse153960_metadata.csv"
sample_status_column_name <- "tissue_status"
sample_statuses_to_be_tested <- c("Non-Neurological Control", "ALS Spectrum MND")
sample_statuses_map <- c("Control", "ALS")
sample_id_column_name <- "accession"
additional_columns <- "tissue"

geoRNASeqLMMMetadataLoader <- GEORNASeqLMMMetadataLoader$new()
rna_seq_metadata <- geoRNASeqLMMMetadataLoader$load(
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
# GSM3        Cortex Sensory       ALS
# GSM4        Cortex Frontal       Control
# GSM5        Cortex Sensory       Control
# GSM6        Cortex Frontal       ALS

}
