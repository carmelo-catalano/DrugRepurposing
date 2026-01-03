\name{GEORNASeqDichotomicVoomDrugRepurpose}
\alias{GEORNASeqDichotomicVoomDrugRepurpose}
\title{Compute connectivity score between disease RNA-Seq dataset and a list of drugs}
\description{
Computes the connectivity score between an RNA-Seq dataset of a disease and a list of drugs.
\cr
This class computes the differential gene expression (DGE) of the disease and then computes the
connectivity scores. The disease DGE is computed by \code{GEORNASeqDichotomicVoomDGE}.
The connectivity scores are computed by \code{BinChenDiseaseDGEDrugListConnectivityScore}.
\cr
RNA data must follow a negative binomial distribution, typically data from RNA-Seq-like analyses.
The input RNA-Seq data file is sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
geoRNASeqDichotomicVoomDrugRepurpose <- GEORNASeqDichotomicVoomDrugRepurpose$new()
geoRNASeqDichotomicVoomDrugRepurpose$compute(rna_seq_filename,
        rna_seq_filename, sample_01_map, drugs,
        drugs_genes, random_distribution_size, disease_name,
        drug_perturbation_time, parallel_computation,
        filter_by_protein_coding, signature_mapper_parameter
)
}
\arguments{
  \item{rna_seq_filename}{
    Filename of the RNA seq file. The file must be in TSV (tab-separated values) format and comply with the GEO NCBI specification.
    \cr
    The file may also be compressed in gz format.
    \cr
    The file contains a table of RNA data. Each column represents an RNA-Seq sample, and each row represents a gene.
    \cr
    Row names are gene IDs, and column names are experiment identifiers.
    The file name may be a local path (e.g., /user/rna/raw_counts.tsv) or a URL (e.g., https://www.ncbi.gov/geo/download/raw_counts.tsv.gz).
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_seq_filename} table.
    Each character represents the type of the corresponding column in \code{rna_seq_filename}
    table (i.e., the group): 0 = control sample, 1 = test sample, X = excluded sample.
    Instead of using 0 and 1, you can label samples as C (control) and T (test).
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drugs}{
    Drug signatures.
    A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{name} = drug name, \code{filename} = drug DGE filename.
    }
  }
  \item{drugs_genes}{
    The gene ID list used for connectivity score computation. Typically, a subset of the full DGE is used, excluding certain genes.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution. Higher values provide more precise p-values.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
    }
  }
  \item{disease_name}{
    Disease name. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{parallel_computation}{
    Enable parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the constructor argument \code{dgeToSignatureMapper (constructor argument)}. The mapper may use this parameter for mapping.
    If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming \code{disease_dge} to a disease signature.
    \itemize{
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}.
      \item Default value: \code{MostSignificantGenesSignatureMapper}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The field \code{drug_perturbation_time} is optional.
}
\examples{
rna_seq_filename <- "/home/user/rna/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv"
# File content:
# GeneID GSM1    GSM2    GSM3    GSM4
# 1      262     116     111     162
# 2      281897  337026  111736  219471
# 3      463     261     193     281
# 9      12301   3277    862     5990
# 10     284     132     88      280
# 11     2966    2006    1371    2241
# 12     4842    3699    2536    4527
# 13     9966    12406   1531    12941

sample_01_map <- "1X01"

# How the map is applied:
#           1      X      0      1
# GeneID   GSM1   GSM2   GSM3   GSM4
# 1        262    116    111    162
# ...
#
#
# GSM1, GSM4 = IPF; GSM3 = control; GSM2 = excluded

drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404")
)
drugs_genes <- c(780, 7849, 2049, 2101, 8717, 10594, 826, 11224, 6158)
random_distribution_size <- 10^5
disease_name <- "IPF"
drug_perturbation_time <- "6h"
parallel_computation <- FALSE
filter_by_protein_coding <- FALSE
signature_mapper_parameter <- 150

drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir = "/drug_dges/", t_value_column_name = "t.value_6h")
geoRNASeqDichotomicVoomDrugRepurpose <- GEORNASeqDichotomicVoomDrugRepurpose$new(drugSignatureLoader = drugSignatureLoaderByDrugName)
geoRNASeqDichotomicVoomDrugRepurpose$compute(
        rna_seq_filename, sample_01_map, drugs,
        drugs_genes, random_distribution_size, disease_name,
        drug_perturbation_time, parallel_computation,
        filter_by_protein_coding, signature_mapper_parameter
)

# Output:
# drug        connectivity_score   p.value   adj.p.value    disease    disease_signature_type    drug_perturbation_time
# A-23187     -0.00684643         1.436e-16 1.494e-12      IPF        150 MostSignificantGenes  6h
# A-443644    0.042984999         2.351e-14 6.988e-11      IPF        150 MostSignificantGenes  6h
# AG-490      0.320787632         3.359e-14 6.988e-11      IPF        150 MostSignificantGenes  6h
# AG-494      -0.07737998         4.439e-14 7.695e-11      IPF        150
}
