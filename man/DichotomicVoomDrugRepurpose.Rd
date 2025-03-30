\name{DichotomicVoomDrugRepurpose}
\alias{DichotomicVoomDrugRepurpose}
\title{Compute the connectivity score between a disease and a list of drugs}
\description{
Given a disease RNA-Seq analysis and a list of drug DGEs, \code{DichotomicVoomDrugRepurpose} computes the
connectivity score between the disease and the drugs. This class composes the
classes \code{DichotomicDGE} and \code{BinChenDiseaseDGEDrugListConnectivityScore}
through the \code{DichotomicDrugRepurposeCore} class.
}
\usage{
dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(
  rna_seq, sample_01_map, drug_dge_dir, drugs, drugs_genes,
  drug_dge_t_value_column_name, random_distribution_size, disease_name,
  drug_perturbation_time, filter_by_protein_coding, parallel_computation,
  signature_mapper_parameter
)
}
\arguments{
  \item{rna_seq}{
    Table of RNA-Seq data. Each column represents an RNA-Seq sample, and each row represents a gene.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: First column = gene ID; other columns: RNA-Seq sample data. Typically, the first column name is \code{GeneID}, and the remaining column names correspond to the RNA-Seq sample identifiers.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_seq} table. Each character represents the type of the corresponding column in \code{rna_seq} table (i.e., the group): 0 = test sample, 1 = control sample, X = excluded sample.
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
    The gene ID list to use for connectivity score computation. Typically, a subset of the entire DGE is used, excluding certain genes.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{drug_dge_t_value_column_name}{
    The drug DGE parameter used for connectivity score computation is the t-value. This field contains the column name of the t-value in the DGE table.
    \itemize{
      \item Type: \code{string}.
      \item Default value: “t.value”.
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
    Test sample name argument for \code{DichotomicVoomDGE}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. If specified, it is added to the output table but isn’t used for the computation.
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
    Parameter used by the constructor argument \code{dgeToSignatureMapper (constructor argument)}. The mapper may use this parameter for mapping. If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: Derived class of \code{GeneFilterAbstract}.
      \item Default value: Instance of class \code{LowCountsGeneFilter}.
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming \code{disease_dge} to a disease signature.
    \itemize{
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}.
      \item Default value: Instance of class \code{MostSignificantGenesSignatureMapper}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The column \code{drug_perturbation_time} is optional.
}
\examples{
rna_seq <- data.frame(
  GeneID = c(1, 2, 3, 9, 10, 11, 12, 13),
  GSM1 = c(262, 116, 111, 162, 284, 2966, 4842, 9966),
  GSM2 = c(281897, 337026, 261, 3277, 132, 2006, 3699, 12406),
  GSM3 = c(111736, 193, 88, 862, 88, 1371, 2536, 1531),
  GSM4 = c(219471, 281, 193, 5990, 280, 2241, 4527, 12941)
)

sample_01_map <- "0X10"
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
parallel_computation <- FALSE
signature_mapper_parameter <- 150

dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(
  rna_seq, sample_01_map, drug_dge_dir, drugs, drugs_genes,
  drug_dge_t_value_column_name, random_distribution_size, disease_name,
  drug_perturbation_time, filter_by_protein_coding, parallel_computation,
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
