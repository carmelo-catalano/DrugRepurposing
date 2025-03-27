\name{BinChenDiseaseDGEDrugListConnectivityScore}
\alias{BinChenDiseaseDGEDrugListConnectivityScore}
\title{Calculate Connectivity Score Between Disease DGE and Drug List DGEs}
\description{
Given a disease Differential Gene Expression (DGE) and a list of drug DGEs, computes the connectivity score between the disease and each drug.
}
\usage{
BinChenDiseaseDGEDrugListConnectivityScore$new()
BinChenDiseaseDGEDrugListConnectivityScore$compute(disease_dge, drugs, drugs_genes,
random_distribution_size, disease_name, drug_perturbation_time, parallel_computation,
signature_mapper_parameter)
}
\arguments{
  \item{disease_dge}{
    A table containing a subset of the disease's DGE. For connectivity score computation, only the t-value is required. The sign of the t-value indicates the gene's status: positive = upregulated, negative = downregulated.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{t.value}
    }
  }
  \item{drugs}{
    Drug signatures.
    A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name}, \code{filename}
    }
  }
  \item{drugs_genes}{
    The gene ID list used for connectivity score computation. Typically, a subset of the full DGE is used, excluding certain genes.
    \itemize{
      \item Type: \code{vector}
    }
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution. Higher values provide more precise p-values.
    \itemize{
      \item Type: \code{integer}
      \item Default value: \code{10^5}
    }
  }
  \item{disease_name}{
    Disease name. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{NA}
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{NA}
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
    Parameter used by the constructor argument \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping. If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}
    }
  }
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug DGEs in the argument \code{drugs}.
    \itemize{
      \item Type: class derived from \code{DrugSignatureLoaderAbstract}
      \item Default value: \code{NA}
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming \code{disease_dge} into a disease signature.
    \itemize{
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}
      \item Default value: \code{NA}
    }
  }
}
\value{
A data frame with the following columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{gene_selection_strategy}, \code{drug_perturbation_time}.
}
\examples{
disease_dge <- data.frame(gene_id = c(1, 2, 3, 9, 11, 15),
                          t.value = c(-9.26, -10.37, 8.17, 5.60, -8.44, 7.13))
drugs <- data.frame(name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
                    filename = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"))
drugs_genes <- c(780, 7849, 2049, 2101, 8717, 10594, 826, 11224, 6158)
random_distribution_size <- 1e4
disease_name <- "IPF"
drug_perturbation_time <- "6h"
parallel_computation <- TRUE
signature_mapper_parameter <- 150

binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new()
result <- binChenDiseaseDGEDrugListConnectivityScore$compute(disease_dge, drugs, drugs_genes,
                                                             random_distribution_size,
                                                             disease_name,
                                                             drug_perturbation_time,
                                                             parallel_computation,
                                                             signature_mapper_parameter)
print(result)
}
