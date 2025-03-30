\name{DGEMetanalysisByRow}
\alias{DGEMetanalysisByRow}
\title{Perform meta-analysis on a one-row data frame containing two DGE datasets}
\description{
Given a one-row data frame containing two DGE datasets, this class performs meta-analysis using the rma function.
}
\usage{
dgeMetanalysisByRow <- DGEMetanalysisByRow$new()
dgeMetanalysisByRow$compute(dge_A_B)
}
\arguments{
  \item{dge_A_B}{
    One-row data frame containing two DGEs.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{gene_id}, \code{drug}, \code{DE_log2_FC_A}, \code{std.error_A}, \code{t.value_A}, \code{DE_log2_FC_B}, \code{std.error_B}, \code{t.value_B}.
    }
  }
}
\value{
One-row data frame containing the original columns plus the columns with meta-analysis results.
\cr
Columns: \code{gene_id}, \code{drug}, \code{DE_log2_FC_A}, \code{std.error_A}, \code{t.value_A}, \code{p.value_A}, \code{adj.p.value_A}, \code{DE_log2_FC_B}, \code{std.error_B}, \code{t.value_B}, \code{p.value_B}, \code{adj.p.value_B}, \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}, \code{adj.p.value_A_B}.
}
\examples{
dge_A_B <- data.frame(
  gene_id = 2197,
  drug = "AM-251",
  DE_log2_FC_A = -0.02839397,
  std.error_A = 0.05199355,
  t.value_A = -0.5461057,
  DE_log2_FC_B = -0.0519323668,
  std.error_B = 0.05581761,
  t.value_B = -0.93039389
)

dgeMetanalysisByRow <- DGEMetanalysisByRow$new()
dgeMetanalysisByRow$compute(dge_A_B)
# output
# gene_id   drug      DE_log2_FC_A   std.error_A   t.value_A   DE_log2_FC_B   std.error_B   t.value_B   DE_log2_FC_A_B   std.error_A_B   t.value_A_B   p.value_A_B   adj.p.value_A_B
# 2197      AM-251   -0.02839397     0.05199355    -0.54611    -0.05193237    0.05581761    -0.93039    -0.08061236      0.21665491     -0.37208       0.7098354     0.7098354
}
