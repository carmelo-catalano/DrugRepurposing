\name{DGEMetanalysisByMatrix}
\alias{DGEMetanalysisByMatrix}
\title{Perform Meta-Analysis on Two DGE Matrices}
\description{
Given two matrices containing Differential Gene Expression (DGE) datasets, this class performs a meta-analysis using the RMA (Random-Effects Model) function.
}
\usage{
DGEMetanalysisByMatrix$new()
DGEMetanalysisByMatrix$compute(dge_A, dge_B)
}
\arguments{
  \item{dge_A}{
    First DGE matrix.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}
    }
  }
  \item{dge_B}{
    Second DGE matrix.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}
    }
  }
}
\value{
A matrix containing the columns of the first matrix, the columns of the second matrix, and the meta-analysis results. Columns include:
\itemize{
  \item \code{gene_id}, \code{DE_log2_FC_A}, \code{std.error_A}, \code{t.value_A}, \code{p.value_A}, \code{adj.p.value_A}
  \item \code{DE_log2_FC_B}, \code{std.error_B}, \code{t.value_B}, \code{p.value_B}, \code{adj.p.value_B}
  \item \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}, \code{adj.p.value_A_B}
}
}
\examples{
dge_A <- data.frame(
  gene_id = c(1, 2, 3),
  DE_log2_FC = c(0.18, -0.07, 0.19),
  std.error = c(0.22, 0.15, 0.22),
  t.value = c(0.84, -0.49, 0.87),
  p.value = c(0.39, 0.62, 0.38),
  adj.p.value = c(0.74, 0.88, 0.73)
)

dge_B <- data.frame(
  gene_id = c(1, 2, 3),
  DE_log2_FC = c(0.28, -0.17, 0.34),
  std.error = c(0.42, 0.08, 0.31),
  t.value = c(0.96, -0.54, 1.52),
  p.value = c(0.37, 0.74, 0.29),
  adj.p.value = c(0.81, 0.95, 0.55)
)

dgeMetanalysisByMatrix <- DGEMetanalysisByMatrix$new()
result <- dgeMetanalysisByMatrix$compute(dge_A, dge_B)
print(result)
}
