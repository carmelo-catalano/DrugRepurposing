\name{LMMDrugRepurpose}
\alias{LMMDrugRepurpose}
\title{Compute the connectivity score between a disease and a list of drug DGEs}
\description{
Given a disease RNA data analysis and a list of drug DGEs, \code{LMMDrugRepurpose} computes the connectivity score between the disease and the drugs.
This class creates an instance of \code{LMMDrugRepurposeCore} and uses it for the computation.
}
\usage{
lmmDGE <- LMMDGEJulia$new()
lmmDrugRepurpose <- LMMDrugRepurpose$new(lmmDGE)
lmmDrugRepurpose$compute(
  rna_data, rna_metadata, formula, drugs, drugs_genes,
  random_distribution_size, disease_name, drug_perturbation_time,
  parallel_computation, filter_by_protein_coding, signature_mapper_parameter
)
}
\arguments{
  \item{rna_data}{
    Table of RNA data. Each column represents an RNA analysis, and each row represents a gene.
    Row names are gene IDs, and column names are experiment IDs.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{rna_metadata}{
    For each RNA data analysis column in \code{rna_data}, there is a row in \code{rna_metadata}.
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    \itemize{
      \item Type: \code{data frame}.
    }
  }
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA experiments were performed.
    Because data and metadata are in separate files, the dependent variable to the left of the \code{~} operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{drugs}{
    Drug signatures. A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    \itemize{
      \item Type: \code{data frame}.
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
    If true, enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{F}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, remove non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{F}.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the constructor argument \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping.
    If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{lmmDGE (constructor argument)}{
    Class instance for computing differential gene expression analysis using the Linear Mixed Model (LMM).
    \itemize{
      \item Type: \code{Derived class of LMMDGEAbstract}.
      \item Default value: \code{LMMDGEDream}.
    }
  }
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug DGEs in the argument \code{drugs}.
    \itemize{
      \item Type: \code{class derived from DrugSignatureLoaderAbstract}.
      \item Default value: Instance of class \code{DrugSignatureLoaderByFilename}.
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming \code{disease_dge} to a disease signature.
    \itemize{
      \item Type: \code{class derived from DGEToSignatureMapperAbstract}.
      \item Default value: Instance of class \code{MostSignificantGenesSignatureMapper}.
    }
  }
}
\value{
\code{Data frame}. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The field \code{drug_perturbation_time} is optional.
}
\examples{
rna_data <- matrix(
  c(
    6.930737, 6.643856, 5.247928, 7.169925, 7.303781, 6.375039, 6.108524, 7.055282,
    6.554589, 6.741467, 7.721099, 6.247928, 7.139551, 6.569856, 5.554589, 6.392317,
    6.643856, 5.392317, 7.348728, 7.491853, 6.044394, 5.700440, 6.169925, 5.247928,
    5.954196, 6.672425, 6.614710, 5.169925, 6.988685, 7.357552, 6.954196, 6.285402,
    6.539159, 6.727920, 6.845490, 7.592457, 6.491853, 6.554589, 5.426265, 6.475733,
    5.426265, 6.870365, 5.857981, 4.857981, 7.098032, 7.189825, 6.539159, 6.614710,
    13.230020, 12.707359, 12.294334, 15.276742, 13.226412, 12.772933, 11.352043, 14.134266
  ),
  nrow = 8,
  ncol = 7,
  dimnames = list(
    c(1, 2, 3, 9, 10, 11, 12, 13),
    c("GSM1", "GSM2", "GSM3", "GSM4", "GSM5", "GSM6", "GSM7")
  )
)

# rna_data =
#          GSM1        GSM2        GSM3        GSM4        GSM5        GSM6        GSM7
# 1        6.930737    6.554589    6.643856    5.954196    6.539159    5.426265    13.230020
# 2        6.643856    6.741467    5.392317    6.672425    6.727920    6.870365    12.707359
# 3        5.247928    7.721099    7.348728    6.614710    6.845490    5.857981    12.294334
# 9        7.169925    6.247928    7.491853    5.169925    7.592457    4.857981    15.276742
# 10       7.303781    7.139551    6.044394    6.988685    6.491853    7.098032    13.226412
# 11       6.375039    6.569856    5.700440    7.357552    6.554589    7.189825    12.772933
# 12       6.108524    5.554589    6.169925    6.954196    5.426265    6.539159    11.352043
# 13       7.055282    6.392317    5.247928    6.285402    6.475733    6.614710    14.134266

# the first column represents the row names (gene IDs)

tissue_status <- c("ALS Spectrum MND", "ALS Spectrum MND", "ALS Spectrum MND", "Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND", "Non-Neurological Control")
tissue_status_factor <- factor(tissue_status, levels = c("Non-Neurological Control", "ALS Spectrum MND"))
rna_metadata <- data.frame(
  accession = c("GSM1", "GSM2", "GSM3", "GSM4", "GSM5", "GSM6", "GSM7"),
  tissue = c("Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Cerebellum", "Cerebellum", "Cerebellum"),
  tissue_status = tissue_status_factor
)

# rna_metadata =
# accession   tissue                  tissue_status
# GSM1        Spinal Cord Lumbar      ALS Spectrum MND
# GSM2        Spinal Cord Lumbar      ALS Spectrum MND
# GSM3        Spinal Cord Lumbar      ALS Spectrum MND
# GSM4        Spinal Cord Lumbar      Non-Neurological Control
# GSM5        Cerebellum              ALS Spectrum MND
# GSM6        Cerebellum              ALS Spectrum MND
# GSM7        Cerebellum              Non-Neurological Control


formula <- ~tissue_status + (1 | tissue)

drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494"),
  filename = c("A-23187", "A-443644", "AG-490", "AG-494")
)

# drugs =
# name         filename
# A-23187      A-23187
# A-443644     A-443644
# AG-490       AG-490
# AG-494       AG-494

drugs_genes <- c(1, 2, 3, 9, 10, 11, 780, 7849, 2049, 2101)
random_distribution_size <- 10^4
disease_name <- "ALS"
drug_perturbation_time <- "6h"
parallel_computation <- TRUE
filter_by_protein_coding <- FALSE
signature_mapper_parameter <- 6

lmmDGE <- LMMDGEJulia$new()
lmmDrugRepurpose <- LMMDrugRepurpose$new(lmmDGE)
lmmDrugRepurpose$compute(
  rna_data, rna_metadata, formula, drugs, drugs_genes,
  random_distribution_size, disease_name, drug_perturbation_time,
  parallel_computation, filter_by_protein_coding, signature_mapper_parameter
)

# output =
# drug        connectivity_score   p.value      adj.p.value   disease   disease_signature_type   drug_perturbation_time
# A-23187     0.334653             0.1880556    0.2883341     ALS       6 MostSignificantGenes   6h
# A-443644    0.4163465            0.1994708    0.2791108     ALS       6 MostSignificantGenes   6h
# AG-490      0.4176343            0.38551284   0.45781284    ALS       6 MostSignificantGenes   6h
# AG-494      -0.253463            0.28081845   0.39761845    ALS       6 MostSignificantGenes   6h
}
