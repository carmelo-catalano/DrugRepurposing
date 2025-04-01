\name{LMMVoomDrugRepurpose}
\alias{LMMVoomDrugRepurpose}
\title{Computes the connectivity score between RNA-Seq data of a disease and a list of drugs}
\description{
Computes the connectivity score between RNA-Seq data of a disease and a list of drugs.
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
    RNA-seq data. The first column contains the gene id; the other columns contain the RNA-Seq analysis.
    The first column name is \code{"GeneID"}. The rest of the columns are titled according to the RNA analysis identifier (sample id).
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{rna_seq_metadata}{
    RNA-seq metadata. For each RNA-seq analysis column in the \code{rna_seq_data} table, there is a row in the \code{rna_seq_metadata} table.
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
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
  GeneID = c(1, 2, 3, 9, 10, 11, 12, 13),
  GSM1 = c(262, 281897, 463, 12301, 284, 2966, 4842, 9966),
  GSM2 = c(116, 337026, 261, 3277, 132, 2006, 3699, 12406),
  GSM3 = c(111, 111736, 193, 862, 88, 1371, 2536, 1531),
  GSM4 = c(162, 219471, 281, 5990, 280, 2241, 4527, 12941)
)

# rna_seq_data =
# GeneID   GSM1        GSM2        GSM3        GSM4
# 1        262         116         111         162
# 2        281897      337026      111736      219471
# 3        463         261         193         281
# 9        12301       3277        862         5990
# 10       284         132         88          280
# 11       2966        2006        1371        2241
# 12       4842        3699        2536        4527
# 13       9966        12406       1531        12941

rna_seq_metadata <- data.frame(
  accession = c("GSM1", "GSM2", "GSM3", "GSM4"),
  tissue = c("Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar"),
  tissue_status = c("ALS Spectrum MND", "ALS Spectrum MND", "ALS Spectrum MND", "Non-Neurological Control")
)

# rna_seq_metadata =
# accession   tissue                  subject_id     tissue_status
# GSM1        Spinal Cord Lumbar      NEUEL133AK6    ALS Spectrum MND
# GSM2        Spinal Cord Lumbar      NEUYV496XLP    ALS Spectrum MND
# GSM3        Spinal Cord Lumbar      NEUZU200WEQ    ALS Spectrum MND
# GSM4        Spinal Cord Lumbar      NEUEC006FND    Non-Neurological Control

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
