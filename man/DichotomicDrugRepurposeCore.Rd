\name{DichotomicDrugRepurposeCore}
\alias{DichotomicDrugRepurposeCore}
\title{Computes the connectivity score between a disease and a list of drug DGEs}
\description{
Given a disease RNA data analysis and a list of drug DGEs, \code{DichotomicDrugRepurposeCore} computes the connectivity score between the disease and the drugs.
\cr
This class composes the classes \code{DichotomicDGE} and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
\cr
\code{DichotomicDrugRepurposeCore} may process different types of disease RNA data depending on
the \code{dichotomicCustomTypeDGE} parameter.
}
\usage{
dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicDrugRepurposeCore <- DichotomicDrugRepurposeCore$new(dichotomicVoomDGE)
dichotomicDrugRepurposeCore$compute(rna_data, sample_01_map,
        drug_dge_dir, drugs, drugs_genes, drug_dge_t_value_column_name,
        random_distribution_size, disease_name, drug_perturbation_time,
        filter_by_protein_coding, parallel_computation,
        signature_mapper_parameter
)
}
\arguments{
  \item{rna_data}{
    Table of RNA data analysis, which may include RNA-Seq, Microarray data, or other types, depending on the \code{dichotomicCustomTypeDGE} constructor argument.
    \cr
    Each column represents an RNA data analysis sample, and each row corresponds to a gene.
    \itemize{
      \item Type: matrix.
      \item Columns: Typically, the column names correspond to the RNA data analysis sample identifiers.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_data} table. Each character represents the type of the corresponding column in \code{rna_data} table (i.e., the group): 0 = test sample, 1 = control sample, X = excluded sample.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drug_dge_dir}{
    Directory containing the drug DGEs.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drugs}{
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
  \item{drug_dge_t_value_column_name}{
    The drug DGE parameter used for connectivity score computation is the t-value. This field contains the column name of the t-value in the DGE table.
    \itemize{
      \item Type: \code{string}.
      \item Default value: "t.value".
    }
  }
  \item{random_distribution_size}{
    Parameter needed for p-value connectivity score computation. It is the size of the random connectivity score distribution.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
    }
  }
  \item{disease_name}{
    Disease name. If specified, a column containing the disease name will be added to the output table. It is not used for the computation.
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
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{parallel_computation}{
    If true, enables parallel computation (Unix-like systems only).
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
  \item{dichotomicCustomTypeDGE (constructor argument)}{
    Instance of a class used to compute disease DGE.
    \itemize{
      \item Type: derived class of \code{DichotomicDGEAbstract}.
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
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}.
The column \code{drug_perturbation_time} is optional.
}
\examples{
rna_data <- matrix(
  c(
    6.930737, 6.643856, 5.247928, 7.169925, 7.303781, 6.375039, 6.108524, 7.055282,
    6.554589, 6.741467, 7.721099, 6.247928, 7.139551, 6.569856, 5.554589, 6.392317,
    6.643856, 5.392317, 7.348728, 7.491853, 6.044394, 5.700440, 6.169925, 5.247928,
    5.954196, 6.672425, 6.614710, 5.169925, 6.988685, 7.357552, 6.954196, 6.285402
  ),
  nrow = 8,
  ncol = 4,
  dimnames = list(
    c(1, 2, 3, 9, 10, 11, 12, 13),
    c("GSM1", "GSM2", "GSM3", "GSM4")
  )
)

sample_01_map <- "0X10"

# How the map is applied:
#           0      X      1      0
# GeneID   GSM1   GSM2   GSM3   GSM4
# 1        262    116    111    162
# ...
#
#
# GSM1, GSM4 = IPF; GSM3 = control; GSM2 = excluded

drug_dge_dir <- "/drugs_dge/"
drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404")
)
drugs_genes <- c(780, 7849, 2049, 2101, 8717, 10594, 826, 11224, 6158)
drug_dge_t_value_column_name <- "t.value_6h"
random_distribution_size <- 10^5
disease_name <- "IPF"
drug_perturbation_time <- "6h"
filter_by_protein_coding <- FALSE
parallel_computation <- TRUE
signature_mapper_parameter <- 150

dichotomicVoomDGE <- DichotomicVoomDGE$new()
dichotomicDrugRepurposeCore <- DichotomicDrugRepurposeCore$new(dichotomicVoomDGE)
dichotomicDrugRepurposeCore$compute(rna_data, sample_01_map,
        drug_dge_dir, drugs, drugs_genes, drug_dge_t_value_column_name,
        random_distribution_size, disease_name, drug_perturbation_time,
        filter_by_protein_coding, parallel_computation,
        signature_mapper_parameter
)

# Output:
# drug        connectivity_score   disease  disease_signature_type  drug_perturbation_time
# A-23187     0.0006964073         ipf      100 MostSignificantGenes  6h
# A-443644    -0.0753171062        ipf      100 MostSignificantGenes  6h
# AG-490      0.0047974725         ipf      100 MostSignificantGenes  6h
# AG-494      0.3687839200         ipf      100 MostSignificantGenes  6h
# AG-957      -0.2329153916        ipf      100 MostSignificantGenes  6h
# AM-404      0.4272237341         ipf      100 MostSignificantGenes  6h
}
