\name{DGEMetanalysisByRow}
\alias{DGEMetanalysisByRow}
\title{Perform Meta-Analysis on a Single Row of DGE Data}
\description{
Given a single-row data frame containing two DGE datasets, this class performs a meta-analysis using the RMA (Random-Effects Model) function.
}
\usage{
DGEMetanalysisByRow$new()
DGEMetanalysisByRow$compute(dge_A_B)
}
\arguments{
  \item{dge_A_B}{
    Single-row data frame containing two DGEs.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{drug}, \code{DE_log2_FC_A}, \code{std.error_A}, \code{t.value_A}, \code{DE_log2_FC_B}, \code{std.error_B}, \code{t.value_B}
    }
  }
}
\value{
A single-row data frame containing the original columns plus the meta-analysis results. Columns include:
\itemize{
  \item \code{gene_id}, \code{drug}, \code{DE_log2_FC_A}, \code{std.error_A}, \code{t.value_A}
  \item \code{DE_log2_FC_B}, \code{std.error_B}, \code{t.value_B}
  \item \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}, \code{adj.p.value_A_B}
}
}
\examples{
dge_A_B <- data.frame(
  gene_id = c(2197),
  drug = c("AM-251"),
  DE_log2_FC_A = c(-0.02839),
  std.error_A = c(0.05199),
  t.value_A = c(-0.5461),
  DE_log2_FC_B = c(-0.05193),
  std.error_B = c(0.05581),
  t.value_B = c(-0.9303)
)

dgeMetanalysisByRow <- DGEMetanalysisByRow$new()
result <- dgeMetanalysisByRow$compute(dge_A_B)
print(result)
}
