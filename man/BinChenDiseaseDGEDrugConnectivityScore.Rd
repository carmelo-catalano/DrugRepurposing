\name{BinChenDiseaseDGEDrugConnectivityScore}
\alias{BinChenDiseaseDGEDrugConnectivityScore}
\title{Compute the connectivity score between a disease DGE and a drug DGE}
\description{
Given a disease \link{DGE} and a drug \link{DGE}, computes the connectivity score between them.
}
\usage{
binChenDiseaseDGEDrugConnectivityScore <- BinChenDiseaseDGEDrugConnectivityScore$new()
binChenDiseaseDGEDrugConnectivityScore$compute(
  disease_dge, drug_dge, drug_dge_t_value_column_name,
  random_distribution_size, compute_p_value, signature_mapper_parameter
)
}
\arguments{
  \item{disease_dge}{
    A table containing the disease \link{DGE}.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{drug_dge}{
    A table containing the drug \link{DGE}.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{gene_id}, \code{t.value}.
    }
  }
  \item{drug_dge_t_value_column_name}{
    The t-value is the drug DGE parameter used for connectivity score computation. This field specifies the column name of the t-value in the \link{DGE} table.
    \itemize{
      \item Type: \code{character}.
      \item Default value: "t.value".
    }
  }
  \item{random_distribution_size}{
    This parameter specifies the size of the random connectivity score distribution generated for p-value computation.
    Higher values provide more precise p-values. \cr
    See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
    }
  }
  \item{compute_p_value}{
    If true, the function computes the connectivity score p-value.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: F.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the class specified in the constructor argument \code{dgeToSignatureMapper}.
    \cr
    The mapper may use this parameter during the mapping process. If not specified, the default mapper is \code{\link{MostSignificantGenesSignatureMapper}};
    in this case, \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{MostSignificantGenesSignatureMapper}.
    }
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming a disease \link{DGE} into a disease signature (see \link{Gene-expression-signature}).
    \cr
    In this class, it is used to process the \code{disease_dge} parameter.
    \itemize{
      \item Type: class derived from \code{\link{DGEToSignatureMapperAbstract}}.
      \item Default value: \code{\link{MostSignificantGenesSignatureMapper}}.
    }
  }
  \item{parallel_computation (constructor argument)}{
    If true, enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: F.
    }
  }
}
\value{
Two-element vector: connectivity score, p-value.
}
\examples{
disease_dge <- data.frame(
  gene_id = c(1, 2, 3, 9, 11, 15),
  t.value = c(-9.261609, -10.36986, 8.17305166, 5.60715925, -8.444215, 7.12957687)
)

drug_dge <- data.frame(
  gene_id = c(1, 2, 3, 10, 11, 13),
  t.value = c(-2.26559, 1.369012, 3.173466, -4.60136, -2.191482, 4.2035724)
)

drug_dge_t_value_column_name <- "t.value"
random_distribution_size <- 1e4
compute_p_value <- TRUE
signature_mapper_parameter <- 4

binChenDiseaseDGEDrugConnectivityScore <- BinChenDiseaseDGEDrugConnectivityScore$new()
result<-binChenDiseaseDGEDrugConnectivityScore$compute(
  disease_dge, drug_dge, drug_dge_t_value_column_name,
  random_distribution_size, compute_p_value, signature_mapper_parameter
)
# output
# c(0.5000, 0.7566)
}
