\name{DichotomicVoomDrugRepurpose}
\alias{DichotomicVoomDrugRepurpose}
\title{Compute the connectivity score between a disease and a list of drugs}
\description{
Given a disease RNA-Seq analysis and a list of drug DGEs, \code{DichotomicVoomDrugRepurpose} computes the
connectivity score between the disease and the drugs. This class composes the
classes \code{DichotomicDGE} and \code{BinChenDiseaseDGEDrugListConnectivityScore}
through the \code{DichotomicDrugRepurposeCore} class.
\cr
Disease RNA-Seq data must be expressed as counts.
}
\usage{
dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(
  rna_seq, sample_01_map, drugs, drugs_genes, random_distribution_size, disease_name,
  drug_perturbation_time, filter_by_protein_coding, parallel_computation,
  signature_mapper_parameter
)
}
\arguments{
  \item{rna_seq}{
    Table of RNA-Seq data. Each column represents an RNA-Seq sample, and each row represents a gene.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_seq} table.
    Each character represents the type of the corresponding column in \code{rna_seq}
    table (i.e., the group): 0 = control sample, 1 = test sample, X = excluded sample.
    Instead of using 0 and 1, you can label samples as C (control) and T (test).
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
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}.
      \item Default value: Instance of class \code{MostSignificantGenesSignatureMapper}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The column \code{drug_perturbation_time} is optional.
}
\examples{
rna_seq <- matrix(
  c(
    262, 281897, 463, 12301, 284, 2966, 4842, 9966,
    116, 337026, 261, 3277, 132, 2006, 3699, 12406,
    111, 111736, 193, 862, 88, 1371, 2536, 1531,
    162, 219471, 281, 5990, 280, 2241, 4527, 12941
  ),
  nrow = 8,
  ncol = 4,
  dimnames = list(
    c(1, 2, 3, 9, 10, 11, 12, 13),
    c("GSM1", "GSM2", "GSM3", "GSM4")
  )
)

sample_01_map <- "1X01"
drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("drugs_dge/A-23187.Rds", "drugs_dge/A-443644.Rds", "drugs_dge/AG-490.Rds",
               "drugs_dge/AG-494.Rds", "drugs_dge/AG-957.Rds", "drugs_dge/AM-404.Rds")
)
drugs_genes <- c(1, 2, 3, 9, 10, 11, 12, 13, 6158)

dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(
  rna_seq = rna_seq,
  sample_01_map = sample_01_map,
  drugs = drugs,
  drugs_genes = drugs_genes,
  random_distribution_size = 10^5,
  disease_name = "IPF",
  drug_perturbation_time = "6h"
  filter_by_protein_coding = FALSE,
  parallel_computation = FALSE,
  signature_mapper_parameter = 8
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
