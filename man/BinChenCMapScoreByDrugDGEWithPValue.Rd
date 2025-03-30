\name{BinChenCMapScoreByDrugDGEWithPValue}
\alias{BinChenCMapScoreByDrugDGEWithPValue}
\title{Compute Connectivity Score and P-Value Between Disease and Drug}
\description{
Same as \code{BinChenCMapScoreByDrugDGE}, except for the computation of the p-value.
}
\usage{
BinChenCMapScoreByDrugDGEWithPValue$new()
BinChenCMapScoreByDrugDGEWithPValue$compute(disease_signature_down_regulated_genes,
disease_signature_up_regulated_genes, drug_signature,
random_connectivity_score_distribution)
}
\arguments{
  \item{disease_signature_down_regulated_genes}{
    Disease signature down-regulated genes.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{disease_signature_up_regulated_genes}{
    Disease signature up-regulated genes.
    \itemize{
      \item Type: \code{data.frame}
      \item Column: \code{gene_id}
    }
  }
  \item{drug_signature}{
    Drug signature.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{estimate} (\code{estimate} = log2 Fold Change)
    }
  }
  \item{random_connectivity_score_distribution}{
    Random connectivity score distribution. \code{random_connectivity_score_distribution}
    is compared with connectivity score for p-value computation.
    \itemize{
      \item Type: \code{numeric vector}
    }
  }
}
\value{
A two-element vector: \code{connectivity_score}, \code{p.value}.
}
\examples{
disease_signature_down_regulated_genes <- data.frame(gene_id = c(1, 2, 18))
disease_signature_up_regulated_genes <- data.frame(gene_id = c(3, 17))
drug_signature <- data.frame(gene_id = c(1, 2, 3, 9, 10, 17, 18),
                              estimate = c(1.13360404, 0.41307894, -1.08978928,
                                           0.93707215, -1.22276393, 0.79162811,
                                           -0.59307306))
random_connectivity_score_distribution <- c(0.123, -0.56789, 0.8912763, 0.1357, -0.4754)

binChenCMapScoreByDrugDGEWithPValue <- BinChenCMapScoreByDrugDGEWithPValue$new()
binChenCMapScoreByDrugDGEWithPValue$compute(disease_signature_down_regulated_genes,
                                                      disease_signature_up_regulated_genes,
                                                      drug_signature,
                                                      random_connectivity_score_distribution)
# Output: c(-0.5123520, 0.00134124)
}
