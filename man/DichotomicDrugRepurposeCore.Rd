\name{DichotomicDrugRepurposeCore}
\alias{DichotomicDrugRepurposeCore}
\title{Compute Connectivity Score Between Disease RNA Analysis and Drug DGEs}
\description{
Given a disease RNA data analysis and a list of drug DGEs, this class computes the connectivity score between the disease and drugs. The class composes the classes \code{DichotomicDGE} and \code{BinChenDiseaseDGEDrugListConnectivityScore}.
The RNA data analysis type can vary based on the \code{dichotomicCustomTypeDGE} constructor parameter.
}
\usage{
DichotomicDrugRepurposeCore$new()
DichotomicDrugRepurposeCore$compute(rna_data, sample_01_map, disease_n_most_significant_genes,
                                     drug_dge_dir, drugs, drugs_genes, drug_dge_t_value_column_name,
                                     random_distribution_size, disease_name, drug_perturbation_time,
                                     filter_by_protein_coding, parallel_computation, signature_mapper_parameter)
}
\arguments{
  \item{rna_data}{
    Table of RNA data analysis. Each column represents a sample, and each row corresponds to a gene.
    \itemize{
      \item Type: \code{data.frame}
    }
  }
  \item{sample_01_map}{
    Map indicating the group of each sample: \code{0} = test sample, \code{1} = control sample, \code{X} = excluded sample.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{disease_n_most_significant_genes}{
    Number of significant genes representing the disease signature.
    \itemize{
      \item Type: \code{integer}
    }
  }
  \item{drug_dge_dir}{
    Directory containing the drug DGE files.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{drugs}{
    Table of drug signatures with their respective filenames.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name}, \code{filename}
    }
  }
  \item{drugs_genes}{
    List of gene IDs used for computing the connectivity score.
    \itemize{
      \item Type: \code{vector}
    }
  }
  \item{drug_dge_t_value_column_name}{
    Column name for the drug DGE t-value.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{"t.value"}
    }
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution.
    \itemize{
      \item Type: \code{integer}
      \item Default value: \code{10^5}
    }
  }
  \item{disease_name}{
    Name of the disease.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{NA}
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein-coding genes.
    \itemize{
      \item Type: \code{boolean}
      \item Default value: \code{FALSE}
    }
  }
  \item{parallel_computation}{
    If true, enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}
      \item Default value: \code{FALSE}
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used for signature mapping computation.
    \itemize{
      \item Default value: \code{NA}
    }
  }
  \item{dichotomicCustomTypeDGE (constructor argument)}{
    Instance for computing differential gene expression analysis.
    \itemize{
      \item Type: derived class of \code{DichotomicDGEAbstract}
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming disease DGE into a signature.
    \itemize{
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}
    }
  }
}
\value{
A \code{data.frame} with columns: \code{drug}, \code{connectivity_score}, \code{disease}, \code{gene_selection_strategy}, \code{drug_perturbation_time}.
}
\examples{
rna_data <- data.frame(
  GeneID = c(1, 2, 3, 9, 10),
  GSM1 = c(3000, 9676, 4954, 1000, 0),
  GSM2 = c(2322, 8910, 4248, 0, 0)
)
rownames(rna_data) <- c(1, 2, 3, 9, 10)

sample_01_map <- "0X10"
disease_n_most_significant_genes <- 150
drug_dge_dir <- "/path/to/drug_dge"
drugs <- data.frame(name = c("A-23187", "A-443644"), filename = c("A23187.rds", "A443644.rds"))
drugs_genes <- c(780, 7849, 2049)
drug_dge_t_value_column_name <- "t.value_6h"
random_distribution_size <- 1e5
disease_name <- "IPF"

dichotomicDrugRepurposeCore <- DichotomicDrugRepurposeCore$new()
result <- dichotomicDrugRepurposeCore$compute(
  rna_data, sample_01_map, disease_n_most_significant_genes, drug_dge_dir, drugs,
  drugs_genes, drug_dge_t_value_column_name, random_distribution_size, disease_name,
  "6h", FALSE, TRUE, 150
)
print(result)
}
