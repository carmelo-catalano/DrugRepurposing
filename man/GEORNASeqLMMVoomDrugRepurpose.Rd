\name{GEORNASeqLMMVoomDrugRepurpose}
\alias{GEORNASeqLMMVoomDrugRepurpose}
\title{Compute connectivity score between disease RNA-Seq dataset and a list of drugs}
\description{
Given a disease RNA-Seq analysis and a list of drug DGEs, \code{GEORNASeqLMMVoomDrugRepurpose}
computes the connectivity score between the disease and the drug DGEs.
\cr
\code{GEORNASeqLMMVoomDrugRepurpose} calculates differential gene expression from RNA-seq data using a
Linear Mixed Model, and then computes the connectivity score between the disease DGE and the drug DGEs.
\cr
This class composes the class BinChenDiseaseDGEDrugListConnectivityScore and an implementation
of \code{GEORNASeqLMMVoomDGEAbstract}.
\cr
RNA data must follow a negative binomial distribution, typically data from RNA-Seq-like analyses.
\cr
The input RNA-seq data and metadata files are sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqLMMVoomDrugRepurpose$new(geoRNASeqLMMVoomDGELmer)
geoRNASeqLMMVoomDrugRepurpose$compute(
        rna_seq_metadata, formula, drugs, drugs_genes, random_distribution_size,
        random_effect_column_names, sample_status_column_name, disease_name,
        drug_perturbation_time, parallel_computation, filter_by_protein_coding,
        signature_mapper_parameter
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
  \item{drug_signatures}{
    A table (data.frame) containing drug signatures.
    It must contain two columns:
    \itemize{
        \item \code{name}: The name of the drug.
        \item \code{signature_reference}: Either a data.frame containing the \link{Gene-expression-signature}, or a reference (e.g., a filename) used by the signature loader class to retrieve the data.
    }
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name} (drug name), \code{signature_reference}
    }
  }
  \item{drugs_genes}{
    The gene ID list to use for connectivity score computation. A subset of the signature may be used.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{random_distribution_size}{
    This parameter specifies the size of the random connectivity score distribution generated for p-value computation.
    Higher values provide more precise p-values. \cr
    See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
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
  \item{disease_name}{
    Disease name. If specified, a column containing the disease name will be added to the output table.
    \cr
    This parameter is optional and is ignored by the computation logic.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{drug_perturbation_time}{
      Drug perturbation time, i.e., the duration for which the sample is treated with the drug.
      If specified, a column containing the drug perturbation time will be added to the output table.
      \cr
      This parameter is optional and is ignored by the computation logic.
      \itemize{
        \item Type: \code{character}.
        \item Default value: \code{NA}.
      }
  }
  \item{parallel_computation}{
    If true, enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the class specified in the constructor argument \code{dgeToSignatureMapper}.
    \cr
    The mapper may use this parameter during the mapping process. If not specified, the default mapper is \code{\link{MostSignificantGenesSignatureMapper}};
    in this case, \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{MostSignificantGenesSignatureMapper}.
    }
  }
  \item{geoRNASeqLMMVoomDGE (constructor argument)}{
    Instance of a class for computing LMM with Voom-transformed data.
    \itemize{
      \item Type: Derived class of \code{\link{GEORNASeqLMMVoomDGEAbstract}}.
      \item Default value: Instance of class \code{\link{GEORNASeqLMMVoomDGEDream}}.
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming a disease \link{DGE} into a disease signature (see \link{Gene-expression-signature}).
    \itemize{
      \item Type: class derived from \code{\link{DGEToSignatureMapperAbstract}}.
      \item Default value: \code{\link{MostSignificantGenesSignatureMapper}}.
    }
  }
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug signatures provided in the \code{drug_signatures} argument.
    \cr
    This class uses the \code{signature_reference} column of the \code{drug_signatures} table to load the drug signature.
    \cr
    The \code{signature_reference} field may contain either the signature itself or a reference to it (e.g., a filename).
    \itemize{
      \item Type: class derived from \code{\link{DrugSignatureLoaderAbstract}}.
      \item Default value: Instance of class \code{\link{DrugSignatureLoaderByFilename}}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The field \code{drug_perturbation_time} is optional.
}
\examples{
rna_seq_data_filename <- "/home/user/rna/GSE153960_raw_counts_GRCh38.p13_NCBI.tsv.gz"
# File content example:
#
# GeneID   GSM1      GSM2      GSM3      GSM4      GSM5      GSM6      GSM7
# -------------------------------------------------------------------------
# 1        262       116       111       162       172       182       142
# 2        28189     33702     11173     21947     22147     20817     19117
# 3        463       261       193       281       351       291       231
# 9        12301     3277      862       5990      4890      5550      5110
# 10       284       132       88        280       270       220       210
# 11       2966      2006      1371      2241      2151      2012      1922
# 12       4842      3699      2536      4527      4347      4125      3825
# 13       9966      12406     1531      12941     11841     10121     11347


# rna_seq_metadata  content example:
#
# sample_id    tissue_status    tissue
# ------------------------------------------------
# GSM1         als              Spinal Cord Lumbar
# GSM2         als              Spinal Cord Lumbar
# GSM3         als              Spinal Cord Lumbar
# GSM4         Control          Spinal Cord Lumbar
# GSM5         als              Spinal Cord Cervical
# GSM6         als              Spinal Cord Cervical
# GSM7         Control          Spinal Cord Cervical

formula <- ~tissue_status + (1 | tissue)

drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("/drug_dges/A-23187.Rds", "/drug_dges/A-443644.Rds", "AG-490.Rds",
  "/drug_dges/AG-494.Rds", "/drug_dges/AG-957.Rds", "/drug_dges/AM-404.Rds")
)
drugs_genes <- c(780, 7849, 2049, 2101, 8717, 10594, 826, 11224, 6158)
random_distribution_size <- 10^5
random_effect_column_names <- "tissue"
sample_status_column_name <- "tissue_status"
disease_name <- "ALS"
drug_perturbation_time <- "6h"
parallel_computation <- FALSE
filter_by_protein_coding <- FALSE
signature_mapper_parameter <- 150

geoRNASeqLMMVoomDGELmer <- GEORNASeqLMMVoomDGELmer$new()
geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqLMMVoomDrugRepurpose$new(geoRNASeqLMMVoomDGELmer)
geoRNASeqLMMVoomDrugRepurpose$compute(rna_seq_data_filename,
        rna_seq_metadata, formula, drugs, drugs_genes, random_distribution_size,
        random_effect_column_names, sample_status_column_name, disease_name,
        drug_perturbation_time, parallel_computation, filter_by_protein_coding,
        signature_mapper_parameter
)

# output
# drug         connectivity_score   p.value                 adj.p.value             disease    disease_signature_type     drug_perturbation_time
# ----------------------------------------------------------------------------------------------------------------------------------------------
# A-23187      0.334653             0.1880556               0.2883341               ALS        4 MostSignificantGenes     6h
# A-443644     0.4163465            0.1994708               0.2791108               ALS        4 MostSignificantGenes     6h
# AG-490       0.4176343            0.38551284              0.45781284              ALS        4 MostSignificantGenes     6h
# AG-494      -0.253463             0.28081845              0.39761845              ALS        4 MostSignificantGenes     6h
# AG-957       0.5536333            0.479470                0.553470                ALS        4 MostSignificantGenes     6h
# AM-404      -0.524245             0.18694856              0.20896345              ALS        4 MostSignificantGenes     6h
}
