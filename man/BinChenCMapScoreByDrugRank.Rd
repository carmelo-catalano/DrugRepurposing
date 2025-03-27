\name{BinChenCMapScoreByDrugRank}
\alias{BinChenCMapScoreByDrugRank}
\title{Compute Connectivity Score Between Disease and Drug Using Rank-Based Method}
\description{
Computes the connectivity score between a disease and a drug. The connectivity score represents
the correlation between the disease and the drug. The score ranges from -1 to +1.
A positive value indicates that the drug behaves similarly the disease. A negative value
indicates that the drug behaves conversely to the disease. A higher positive score implies
stronger correlation, while a higher negative score indicates greater anticorrelation.
\cr
This function has been developed by Bin Chen et al. in their paper: “Reversal of cancer
gene expression correlates with drug efficacy and reveals therapeutic targets” (2017).

}
\usage{
BinChenCMapScoreByDrugRank$new()
BinChenCMapScoreByDrugRank$compute(disease_signature_down_regulated_genes,
disease_signature_up_regulated_genes, drug_signature)
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
      \item Columns: \code{gene_id}, \code{rank}.\cr
      \code{rank} is the ranking of genes with respect to the estimate, is computed by:
      \code{rank(-1 * drug_signature$estimate, ties.method = "random")}
    }
  }
}
\value{
Float number value ranging from -1 to +1, representing the connectivity score.
}
\examples{
disease_signature_down_regulated_genes <- data.frame(gene_id = c(1, 2, 18))
disease_signature_up_regulated_genes <- data.frame(gene_id = c(3, 17))
drug_signature <- data.frame(gene_id = c(1, 2, 3, 9, 10, 17, 18),
                              rank = c(1, 4, 6, 2, 7, 3, 5))

binChenCMapScoreByDrugRank <- BinChenCMapScoreByDrugRank$new()
result <- binChenCMapScoreByDrugRank$compute(disease_signature_down_regulated_genes,
                                             disease_signature_up_regulated_genes,
                                             drug_signature)
print(result)  # Output: 0.1414551
}
