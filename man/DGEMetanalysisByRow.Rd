\name{DGEMetanalysisByRow}
\alias{DGEMetanalysisByRow}
\title{Perform meta-analysis on a one-row data frame containing two DGEs}
\description{
Given a one-row data frame containing two differential gene expression and corresponding standard error, this class performs meta-analysis using the \code{rma} function from the \code{metafor} package.
\cr
The input is a data.frame of one row containing the following columns:
\code{DE_log2_FC_A}, \code{std.error_A}, \code{DE_log2_FC_B}, and \code{std.error_B}.
\cr
Any additional columns present in the input data.frame will be retained in the output.
\cr
  The output consists of the input data frame plus the meta-analysis result columns:
  \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}.
\cr
The meta-analysis is computed by:\cr
rma_output <- rma(yi = c(dge_A_B$DE_log2_FC_A, dge_A_B$DE_log2_FC_B), sei = c(dge_A_B$std.error_A, dge_A_B$std.error_B))
\cr
The meta-analysis result columns are constructed as follows:\cr
\code{
    DE_log2_FC_A_B = ma_output$b[, 1] \cr
    std.error_A_B = ma_output$se \cr
    t.value_A_B = ma_output$zval \cr
    p.value_A_B = ma_output$pval \cr
}

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
      \item Columns: \code{DE_log2_FC_A}, \code{std.error_A}, \code{DE_log2_FC_B}, \code{std.error_B}.
    }
  }
}
\value{
One-row data frame containing the original columns plus the columns with meta-analysis results.
\cr
New columns: \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}.
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
# gene_id   drug      DE_log2_FC_A   std.error_A   t.value_A   DE_log2_FC_B   std.error_B   t.value_B   DE_log2_FC_A_B   std.error_A_B   t.value_A_B   p.value_A_B
# 2197      AM-251   -0.02839397     0.05199355    -0.54611    -0.05193237    0.05581761    -0.93039    -0.08061236      0.21665491     -0.37208       0.7098354
}
