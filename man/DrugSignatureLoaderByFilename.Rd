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
  \item{t_value_column_name (constructor argument)}{
    The t-value is the drug DGE parameter used for connectivity score computation. This field specifies the name of the column containing the t-value in the DGE table.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"t.value"}.
    }
  }
  \item{disease_drug_common_genes (constructor argument)}{
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

# drug DGE example:
# drug       gene_id   DE_log2_FC_6h  std.error_6h  t.value_6h   p.value_6h   adj.p.value_6h
# AG-490     2         -0.0764601637  0.15385726    -0.49695520  0.6192206    0.884664129
# AG-490     9          0.0193561890  0.11306140     0.17120068  0.864066    0.955067086
# AG-490     13         0.0057949795  0.08008110     0.07236388  0.9423123   0.990671730
# AG-490     14        -0.0763228770  0.05061015    -1.50805486  0.1315405   0.583778851
# AG-490     16         0.0881544343  0.07173374     1.22891166  0.219051    0.525862799
#
#
#
# output:
# gene_id   estimate
# 2         -0.49695520
# 9          0.17120068
# 14        -1.50805486
# 16         0.22891166
}
