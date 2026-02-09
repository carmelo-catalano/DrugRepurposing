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
        random_effect_column_names, counts_filter_column_name, disease_name,
        drug_perturbation_time, parallel_computation, filter_by_protein_coding,
        signature_mapper_parameter
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
    \code{rna_seq_metadata} must contain a column called "\code{sample_id}",
    this column is used as a filter for rna_seq_data: rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]
    \cr
    The metadata contain the control/altered status of each sample, along with additional conditions.
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
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-seq experiments were performed.
    Because data and metadata are in separate files, the dependent variable to the left of the ~ operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{R formula}.
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
      \item Default value: \code{"sample_status"}
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
    Enable parallel computation. Only for Unix-like systems.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, remove non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the constructor argument \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping.
    If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{geoRNASeqLMMVoomDGE (constructor argument)}{
    Instance of a class for computing LMM with Voom-transformed data.
    \itemize{
      \item Type: Derived class of \code{GEORNASeqLMMVoomDGEAbstract}.
      \item Default value: Instance of class \code{GEORNASeqLMMVoomDGEDream}.
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming \code{disease_dge} to a disease signature.
    \itemize{
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}.
      \item Default value: Instance of class \code{MostSignificantGenesSignatureMapper}.
    }
  }
    \item{drugSignatureLoader (constructor argument)}{
    Loader for drug DGEs in the argument \code{drugs}.
    \itemize{
      \item Type: \code{class derived from DrugSignatureLoaderAbstract}.
      \item Default value: Instance of class \code{DrugSignatureLoaderByFilename}.
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
counts_filter_column_name <- "tissue_status"
disease_name <- "ALS"
drug_perturbation_time <- "6h"
parallel_computation <- FALSE
filter_by_protein_coding <- FALSE
signature_mapper_parameter <- 150

geoRNASeqLMMVoomDGELmer <- GEORNASeqLMMVoomDGELmer$new()
geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqLMMVoomDrugRepurpose$new(geoRNASeqLMMVoomDGELmer)
geoRNASeqLMMVoomDrugRepurpose$compute(rna_seq_data_filename,
        rna_seq_metadata, formula, drugs, drugs_genes, random_distribution_size,
        random_effect_column_names, counts_filter_column_name, disease_name,
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
