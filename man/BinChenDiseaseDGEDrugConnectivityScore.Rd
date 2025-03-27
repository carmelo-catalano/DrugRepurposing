\name{BinChenDiseaseDGEDrugConnectivityScore}
\alias{BinChenDiseaseDGEDrugConnectivityScore}
\title{Calculate Connectivity Score Between Disease and Drug DGE}
\description{
Given a disease Differential Gene Expression (DGE) and a drug DGE, computes the connectivity score between them.
}
\usage{
BinChenDiseaseDGEDrugConnectivityScore$new()
BinChenDiseaseDGEDrugConnectivityScore$compute(disease_dge, drug_dge,
drug_dge_t_value_column_name, random_distribution_size, compute_p_value,
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
  \item{drug_dge}{
    A table containing a subset of the drug's DGE. For connectivity score computation, only the t-value is required. The sign of the t-value indicates the gene's status: positive = upregulated, negative = downregulated.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{t.value}
    }
  }
  \item{drug_dge_t_value_column_name}{
    Specifies the column name of the t-value in the drug DGE table.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{"t.value"}
    }
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution. Higher values provide more precise p-values.
    \itemize{
      \item Type: \code{integer}
      \item Default value: \code{10^5}
    }
  }
  \item{compute_p_value}{
    Indicates whether the p-value of the connectivity score should be computed.
    \itemize{
      \item Type: \code{boolean}
      \item Default value: \code{FALSE}
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping. If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}.
    \itemize{
      \item Default value: \code{NA}
    }
  }
  \item{dgeToSignatureMapper}{
    Mapper for transforming \code{disease_dge} into a disease signature.
    \itemize{
      \item Type: class derived from \code{DGEToSignatureMapperAbstract}
      \item Default value: \code{NA}
    }
  }
  \item{parallel_computation}{
    Enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}
      \item Default value: \code{FALSE}
    }
  }
}
\value{
A two-element vector: connectivity score, p-value.
}
\examples{
disease_dge <- data.frame(gene_id = c(1, 2, 3, 9, 11, 15),
                          t.value = c(-9.26, -10.37, 8.17, 5.60, -8.44, 7.13))
drug_dge <- data.frame(gene_id = c(1, 2, 3, 1, 11, 13),
                       t.value = c(-2.26, 1.37, 3.17, -4.60, -2.19, 4.20))
drug_dge_t_value_column_name <- "t.value_6h"
random_distribution_size <- 1e4
compute_p_value <- TRUE
signature_mapper_parameter <- 150

binChenDiseaseDGEDrugConnectivityScore <- BinChenDiseaseDGEDrugConnectivityScore$new()
result <- binChenDiseaseDGEDrugConnectivityScore$compute(disease_dge, drug_dge,
                                                         drug_dge_t_value_column_name,
                                                         random_distribution_size,
                                                         compute_p_value,
                                                         signature_mapper_parameter)
print(result)
}
