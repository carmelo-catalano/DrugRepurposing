\name{GEORNASeqDichotomicVoomDrugRepurpose}
\alias{GEORNASeqDichotomicVoomDrugRepurpose}
\title{Compute connectivity score between disease and drugs using RNA-Seq data}
\description{
Compute the connectivity score between an RNA-Seq dataset of a disease and a list of drugs. This class computes the differential gene expression (DGE) of the disease and then computes the connectivity scores. The disease DGE is computed by \code{GEORNASeqDichotomicVoomDGE}. The connectivity scores are computed by \code{BinChenDiseaseDGEDrugListConnectivityScore}.
RNA data must follow a negative binomial distribution, typically data from RNA-seq-like analyses.
The input RNA-seq data file is sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
geoRNASeqDichotomicVoomDrugRepurpose <- GEORNASeqDichotomicVoomDrugRepurpose$new()
geoRNASeqDichotomicVoomDrugRepurpose$compute(rna_seq_filename, sample_01_map,
                                              drug_dge_dir, drugs, drugs_genes,
                                              drug_dge_t_value_column_name,
                                              random_distribution_size, disease_name,
                                              drug_perturbation_time, parallel_computation,
                                              filter_by_protein_coding, signature_mapper_parameter)
}
\arguments{
  \item{rna_seq_filename}{
    Filename of Illumina RNA-Seq file. The file must be in TSV (tab-separated value) format.
    The file may also be compressed in gz format.
    The file contains a table of RNA data. Each column represents an RNA-Seq sample, and each row represents a gene.
    Row names are gene IDs, and column names are experiment identifiers.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_seq} table. Each character represents the type of the corresponding column in the \code{rna_seq} table (i.e., the group): \code{0} = test sample, \code{1} = control sample, \code{X} = excluded sample.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drug_dge_dir}{
    Directory containing the drug DGE files.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drugs}{
    Drug signatures: A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: \code{name} = drug name, \code{filename} = drug DGE filename.
    }
  }
  \item{drugs_genes}{
    The gene ID list to use for connectivity score computation. Usually, we use a subset of the entire DGE, some genes are excluded.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{drug_dge_t_value_column_name}{
    The drug DGE parameter used for connectivity score computation is the t-value. This field contains the column name of the t-value in the DGE table.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"t.value
