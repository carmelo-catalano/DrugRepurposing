\name{DrugSignatureLoaderByDrugName}
\alias{DrugSignatureLoaderByDrugName}
\title{Load drug DGE by drug name}
\description{
Derived class of \code{DrugSignatureLoaderAbstract}. Loads drug DGE from an RDS file using the drug name. The drug DGE is assumed to be the drug signature.
}
\usage{
drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, t_value_column_name, disease_drug_common_genes)
drugSignatureLoaderByDrugName$load(drug_name)
}
\arguments{
  \item{drug_name}{
    Name of the drug DGE to load. The file to load is named \code{drug_name + ".Rds"}.
    \itemize{
      \item Type: \code{string}.
    }
  }
}
\section{Constructor arguments}{
  \item{\code{drug_dge_dir}}{
    Directory containing the drug DGE files.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{\code{t_value_column_name}}{
    The t-value is the drug DGE parameter used for connectivity score computation. This field specifies the name of the column containing the t-value in the DGE table.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"t.value"}.
    }
  }
  \item{\code{disease_drug_common_genes}}{
    List of genes to load from the drug DGE.
    \itemize{
      \item Type: \code{vector}.
      \item Default value: \code{NA}.
    }
  }
}
\value{
Same as \code{DrugSignatureLoaderAbstract}.
}
\examples{
drug_name <- "AG-490"
drug_dge_dir <- "/home/user/dge"
t_value_column_name <- "t.value_6h"
disease_drug_common_genes <- c(2, 9, 14, 16)

drugSignatureLoaderByDrugName <- DrugSignatureLoaderByDrugName$new(drug_dge_dir, t_value_column_name, disease_drug_common_genes)
drugSignatureLoaderByDrugName$load(drug_name)
}
