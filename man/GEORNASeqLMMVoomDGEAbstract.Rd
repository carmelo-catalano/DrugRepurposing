\name{GEORNASeqLMMVoomDGEAbstract}
\alias{GEORNASeqLMMVoomDGEAbstract}
\title{Compute differential gene expression analysis using LMM with Voom transformed data}
\description{
Base class for constructor parameter \code{lmmVoomDGE} of the class \code{GEORNASeqLMMVoomDGECore}. Compute differential gene expression analysis using the Linear Mixed Model (LMM) with Voom transformed RNA-seq data. This method supports experimental conditions described in metadata files.
The input RNA-seq data and metadata files are sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
lmmVoomDGE <- GEORNASeqLMMVoomDGEAbstract$new()
lmmVoomDGE$compute(rna_seq_data_filename, rna_seq_metadata_filename, formula,
                   tissue_status_field_name, tissue_statuses_to_be_tested,
                   tissue_statuses_map, sample_id_field_name, additional_fields,
                   filter_by_protein_coding)
}
\arguments{
  \item{rna_seq_data_filename}{
    Filename of RNA-seq data compatible with GEO format. The file must be in TSV format and may also be compressed as \code{*.gz}.
    First column contains the gene ID; other columns contain RNA-Seq analysis data.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{rna_seq_metadata_filename}{
    Filename of RNA-seq metadata file in CSV format. The file uses \code{;} as the separator.
    Each row corresponds to a sample in the RNA-seq data file, describing tissue status and additional experimental conditions.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{formula}{
    Formula for LMM computation, including mixed effects and random effects (e.g., \code{~ tissue_status + (1 | tissue)}).
    \itemize{
      \item Type
