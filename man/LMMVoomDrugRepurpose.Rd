\name{LMMVoomDrugRepurpose}
\alias{LMMVoomDrugRepurpose}
\title{Computes the connectivity score between RNA-Seq data of a disease and a list of drugs}
\description{
Given a disease RNA-Seq data analysis and a list of drug DGEs, \code{LMMVoomDrugRepurpose} computes the
connectivity score between the disease and the drugs.
\cr
\code{LMMVoomDrugRepurpose} calculates differential gene expression from RNA-seq data using a
Linear Mixed Model, and then computes the connectivity score between the disease DGE and the drug DGEs.
\cr
RNA data must follow a negative binomial distribution, typically data from RNA-Seq-like analyses.
\cr
This class creates an instance of \code{LMMDrugRepurposeCore} and uses it for the computation.
}
\usage{
lmmVoomDrugRepurpose <- LMMVoomDrugRepurpose$new()
lmmVoomDrugRepurpose$compute(
  rna_seq_data, rna_seq_metadata, formula, drugs, drugs_genes,
  random_distribution_size, disease_name, drug_perturbation_time,
  parallel_computation, filter_by_protein_coding, signature_mapper_parameter
)

}
\arguments{
  \item{rna_seq_data}{
    Table of RNA-seq data. Each column represents an RNA analysis, and each row represents a gene.
    Row names are gene IDs, and column names are experiment IDs.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{rna_seq_metadata}{
    For each RNA-seq data analysis column in \code{rna_data}, there is a row in \code{rna_metadata}.
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula (constructor argument)}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-seq experiments were performed. Because data and metadata are in separate data frames, the dependent variable to the left of the \code{~} operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
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
    The gene id list to use for connectivity score computation. Usually, we use a subset of the entire DGE; some genes are excluded.
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
    Parameter used by the constructor argument \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping. If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{lmmVoomDGE (constructor argument)}{
    Instance class used for computing the disease DGE.
    \itemize{
      \item Type: \code{derived class of LMMVoomDGEAbstract}.
      \item Default value: Instance of class \code{LMMVoomDreamDGE}.
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
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time} (optional).
}
\examples{
rna_seq_data <- data.frame(
  GSM1 = c(262, 281897, 463, 12301, 284, 2966, 4842, 9966),
  GSM2 = c(116, 337026, 261, 3277, 132, 2006, 3699, 12406),
  GSM3 = c(111, 111736, 193, 862, 88, 1371, 2536, 1531),
  GSM4 = c(162, 219471, 281, 5990, 280, 2241, 4527, 12941),
  GSM5 = c(82, 471, 981, 590, 380, 241, 427, 941),
  GSM6 = c(92, 9471, 201, 1990, 80, 41, 1527, 2941),
  GSM7 = c(192, 2191, 181, 3990, 480, 1241, 7527, 1941)
)
rownames(rna_seq_data) <- c(1, 2, 3, 9, 10, 11, 12, 13) # gene id

# rna_seq_data =
#      GSM1     GSM2      GSM3     GSM4     GSM5   GSM6   GSM7
# 2    262      116       111      162      82     92     192
# 2    281897   337026    111736   219471   471    9471   2191
# 3    463      261       193      281      981    201    181
# 9    12301    3277      862      5990     590    1990   3990
# 10   284      132       88       280      380    80     480
# 11   2966     2006      1371     2241     241    41     1241
# 12   4842     3699      2536     4527     427    1527   7527
# 13   9966     12406     1531     12941    941    2941   1941

rna_seq_metadata <- data.frame(
  accession = c("GSM1", "GSM2", "GSM3", "GSM4", "GSM5", "GSM6", "GSM7"),
  tissue = c("Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar",
             "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Cerebellum", "Cerebellum"),
  subject_id = c("NEUEL133AK6", "NEUYV496XLP", "NEUZU200WEQ", "NEUEC006FND",
                 "NEUKM699KKH", "NEUJZ255ZC5", "NEUJZ233ZL3"),
  tissue_status = c("ALS Spectrum MND", "ALS Spectrum MND", "ALS Spectrum MND",
                    "Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND",
                    "Non-Neurological Control")
)

# rna_seq_metadata =
# accession   tissue                  subject_id     tissue_status
# GSM1        Spinal Cord Lumbar      NEUEL133AK6    ALS Spectrum MND
# GSM2        Spinal Cord Lumbar      NEUYV496XLP    ALS Spectrum MND
# GSM3        Spinal Cord Lumbar      NEUZU200WEQ    ALS Spectrum MND
# GSM4        Spinal Cord Lumbar      NEUEC006FND    Non-Neurological Control
# GSM5        Spinal Cord Lumbar      NEUKM699KKH    ALS Spectrum MND
# GSM6        Cerebellum              NEUJZ255ZC5    ALS Spectrum MND
# GSM7        Cerebellum              NEUJZ233ZL3    Non-Neurological Control

formula <- ~ tissue_status + (1 | tissue)
drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("/drug_signatures/A-23187.Rds", "/drug_signatures/A-443644.Rds",
  "/drug_signatures/AG-490.Rds", "/drug_signatures/AG-494.Rds",
  "/drug_signatures/AG-957.Rds", "/drug_signatures/AM-404.Rds")
)

# drugs =
# name        filename
# A-23187     /drug_signatures/A-23187.Rds
# A-443644    /drug_signatures/A-443644.Rds
# AG-490      /drug_signatures/AG-490.Rds
# AG-494      /drug_signatures/AG-494.Rds
# AG-957      /drug_signatures/AG-957.Rds
# AM-404      /drug_signatures/AM-404.Rds

drugs_genes <- c(780, 7849, 2049, 2101, 8717, 10594, 826, 11224, 6158)
random_distribution_size <- 10^5
disease_name <- "ALS"
drug_perturbation_time <- "6h"
parallel_computation <- FALSE
filter_by_protein_coding <- FALSE
signature_mapper_parameter <- 150
lmmVoomDGEJulia <- LMMVoomDGEJulia$new()
lmmVoomDrugRepurpose <- LMMVoomDrugRepurpose$new(lmmVoomDGE = lmmVoomDGEJulia)
lmmVoomDrugRepurpose$compute(
  rna_seq_data, rna_seq_metadata, formula, drugs, drugs_genes,
  random_distribution_size, disease_name, drug_perturbation_time,
  parallel_computation, filter_by_protein_coding, signature_mapper_parameter
)

# output
# drug        connectivity_score   p.value     adj.p.value    disease   disease_signature_type       drug_perturbation_time
# A-23187     -0.00684643          1.44E-16    1.49E-12       ALS       150 MostSignificantGenes    6h
# A-443644    0.042984999          2.35E-14    6.98E-11       ALS       150 MostSignificantGenes    6h
# AG-490      0.320787632          3.35E-14    6.98E-11       ALS       150 MostSignificantGenes    6h
# AG-494      -0.07737998          4.43E-14    7.69E-11       ALS       150 MostSignificantGenes    6h
# AG-957      0.380783267          1.13E-11    9.87E-09       ALS       150 MostSignificantGenes    6h
# AM-404      0.164675860          4.28E-11    3.18E-08       ALS       150 MostSignificantGenes    6h
}
