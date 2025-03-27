\name{DrugSignatureLoaderByFilename}
\alias{DrugSignatureLoaderByFilename}
\title{Load drug DGE by filename}
\description{
Derived class of \code{DrugSignatureLoaderAbstract}. Loads drug DGE by filename. The drug DGE is assumed to be the drug signature.
}
\usage{
drugSignatureLoaderByFilename <- DrugSignatureLoaderByFilename$new(t_value_column_name, disease_drug_common_genes)
drugSignatureLoaderByFilename$load(filename)
}
\arguments{
  \item{filename}{
    Filename of the drug DGE to load. The file must be in RDS format.
    \itemize{
      \item Type: \code{string}.
    }
  }
}
\section{Constructor arguments}{
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
    }
  }
}
\value{
Same as \code{DrugSignatureLoaderAbstract}.
}
\examples{
filename <- "/home/user/drugs_dge/AG-490.Rds"
t_value_column_name <- "t.value_6h"
disease_drug_common_genes <- c(2, 9, 14, 16)

drugSignatureLoaderByFilename <- DrugSignatureLoaderByFilename$new(t_value_column_name, disease_drug_common_genes)
drugSignatureLoaderByFilename$load(filename)
}
