\name{DGEMetanalysisByMatrix}
\alias{DGEMetanalysisByMatrix}
\title{Perform meta-analysis on two DGEs using RMA function}
\description{
This class allows the creation of a consensus DGE from two distinct DGE results.
Fold change and standard error estimates are combined using meta-analysis techniques via
the \code{rma} function from the \pkg{metafor} package.
\cr
Given two matrices (data.frame) containing two DGEs, this class performs meta-analysis using
the \code{rma} function from the \code{metafor} package.
\cr
The input DGEs matrices must met the following conditions:
  \itemize{
    \item They must contain the following columns (no other columns are allowed): \code{drug}, \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, and \code{t.value}, \code{p.value}, and \code{adj.p.value}.
    \item They must have the same size.
    \item For each row in matrix A, the corresponding row in matrix B must have the same drug and gene ID.
    \item DGE matrix (data.frame) is defined as described in section "DGE output format" of "DrugRepurposing" vignette.
  }
  The output matrix (data.frame) includes all columns from matrices A and B, plus the meta-analysis results in
  \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}, \code{adj.p.value_A_B}.
  For more information about meta-analysis see \code{DGEMetanalysisByRow}
  See example below.
}
\usage{
dgeMetanalysisByMatrix <- DGEMetanalysisByMatrix$new()
dgeMetanalysisByMatrix$compute(dge_A, dge_B)
}
\arguments{
  \item{dge_A}{
    First DGE matrix.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
    }
  }
  \item{dge_B}{
    Second DGE matrix.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
    }
  }
}
\value{
Matrix containing the columns of the first matrix, the columns of the second matrix, and the meta-analysis results.
Columns: \code{gene_id}, \code{drug}, \code{DE_log2_FC_A}, \code{std.error_A}, \code{t.value_A}, \code{p.value_A}, \code{adj.p.value_A}, \code{DE_log2_FC_B}, \code{std.error_B}, \code{t.value_B}, \code{p.value_B}, \code{adj.p.value_B}, \code{DE_log2_FC_A_B}, \code{std.error_A_B}, \code{t.value_A_B}, \code{p.value_A_B}, \code{adj.p.value_A_B}.
}
\examples{

# dge_A
# drug     gene_id    DE_log2_FC    std.error   t.value      p.value     adj.p.value
------------------------------------------------------------------------------------
# AG-370   2          0.18762536    0.2214814   0.8471383    0.3969181   0.7443946
# AG-490   2          -0.07646016   0.1538573   -0.4969552   0.6192206   0.8846641
# AG-494   2          0.19295867    0.2215244   0.8710492    0.3837273   0.7345071

dge_A <- data.frame(
  drug = c("AG-370", "AG-490", "AG-494"),
  gene_id = c(2, 2, 2),
  DE_log2_FC = c(0.187625359, -0.076460164, 0.192958666),
  std.error = c(0.22148139, 0.15385726, 0.22152442),
  t.value = c(0.847138262, -0.496955204, 0.871049189),
  p.value = c(0.3969181, 0.6192206, 0.3837273),
  adj.p.value = c(0.7443946, 0.8846641, 0.7345071)
)

# dge_B
# drug     gene_id   DE_log2_FC   std.error    t.value      p.value     adj.p.value
-----------------------------------------------------------------------------------
# AG-370   2         0.2877854    0.42148139   0.9634614    0.3789181   0.8113946
# AG-490   2         -0.1764582   0.07899726   -0.5456520   0.7474812   0.9533641
# AG-494   2         0.3456478    0.31657524   15.235.189   0.2903727   0.5572071

dge_B <- data.frame(
  drug = c("AG-370", "AG-490", "AG-494"),
  gene_id = c(2, 2, 2),
  DE_log2_FC = c(0.287785359, -0.176458164, 0.345647771),
  std.error = c(0.42148139, 0.07899726, 0.31657524),
  t.value = c(0.963461382, -0.545652041, 1.523518934),
  p.value = c(0.3789181, 0.7474812, 0.2903727),
  adj.p.value = c(0.8113946, 0.9533641, 0.5572071)
)

dgeMetanalysisByMatrix <- DGEMetanalysisByMatrix$new()
dgeMetanalysisByMatrix$compute(dge_A, dge_B)
# output
# gene_id   drug    DE_log2_FC_A   std.error_A   t.value_A      p.value_A   adj.p.value_A   DE_log2_FC_B   std.error_B   t.value_B      p.value_B   adj.p.value_B   DE_log2_FC_A_B   std.error_A_B   t.value_A_B   p.value_A_B   adj.p.value_A_B
# 2         AG-370  0.187625359    0.22148139    0.847138262    0.3969181   0.7443946       0.287785359    0.42148139    0.963461382    0.3789181   0.8113946       0.067178223      0.22620093      0.296984731   0.7664782     0.7664782
# 2         AG-490  -0.076460164   0.15385726    -0.496955204   0.6192206   0.8846641       -0.176458164   0.07899726    -0.545652041   0.7474812   0.9533641       -0.018701297     0.15764428      -0.11862972   0.9055687     0.9055687
# 2         AG-494  0.192958666    0.22152442    0.871049189    0.3837273   0.7345071       0.345647771    0.31657524    1.523518934    0.2903727   0.5572071       0.067178223      0.22620093      0.296984731   0.7664782     0.7664782
}
