\name{BinChenCMapScoreByDrugDGE}
\alias{BinChenCMapScoreByDrugDGE}
\title{Compute Connectivity Score Between Disease and Drug}
\description{
Computes the connectivity score between a disease and a drug. The connectivity score represents the correlation
between the disease and the drug. The score ranges from -1 to +1.\cr
A positive value indicates that the drug behaves similarly to the disease.\cr
A negative value indicates that the drug behaves conversely to the disease.\cr
A higher positive score implies stronger correlation, while a higher negative score
indicates greater anticorrelation.
}
\usage{
BinChenCMapScoreByDrugDGE$new()
BinChenCMapScoreByDrugDGE$compute(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature)
}
\arguments{
  \item{disease_signature_down_regulated_genes}{
    Disease signature down-regulated genes. The genes are ordered by decreasing absolute value of the estimate.\cr
    See \link{Gene-expression-signature} for more details.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{disease_signature_up_regulated_genes}{
    Disease signature up-regulated genes. The genes are ordered by decreasing absolute value of the estimate.\cr
    See \link{Gene-expression-signature} for more details.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{drug_signature}{
    Drug signature.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{estimate} (estimate = t-value)
    }
  }
}
\value{
Float number ranging from -1 to +1, representing the connectivity score.
}
\examples{
disease_signature_down_regulated_genes <- data.frame(gene_id = c(1, 2, 18))
disease_signature_up_regulated_genes <- data.frame(gene_id = c(3, 17))
drug_signature <- data.frame(gene_id = c(1, 2, 3, 9, 10, 17, 18),
                              estimate = c(1.13360404, 0.41307894, -1.08978928, 0.93707215, -1.22276393, 0.79162811, -0.59307306))
binChenCMapScoreByDrugDGE <- BinChenCMapScoreByDrugDGE$new()
binChenCMapScoreByDrugDGE$compute(disease_signature_down_regulated_genes, disease_signature_up_regulated_genes, drug_signature)
# Output: -0.7142857
}
