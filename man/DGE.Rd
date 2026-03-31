\name{DGE}
\alias{DGE}
\title{DGE table}
\description{
The DGE output or input format of DGE functions is a table (data.frame) containing the following columns:\cr
\code{gene_id} = Unique NCBI Gene ID\cr
\code{DE_log2_FC} = Differential expression expressed as the log2 fold change\cr
\code{std.error} = \code{DE_log2_FC / t.value}\cr
\code{t.value} = moderated t-statistic\cr
\code{p.value} = p-value\cr
\code{adj.p.value} = adjusted p-values calculated using the Benjamini-Hochberg (BH) method.\cr
\cr
\strong{Note: DGEs calculated using \code{lmer} from the \code{lme4} package do not include the \code{p.value} and \code{adj.p.value} columns due to limitations of \code{lmer}.}
\cr
}

\examples{
gene_id    DE_log2_FC    std.error    t.value     p.value     adj.p.value
-------------------------------------------------------------------------
140        -0.0510758    0.11917072   -0.428593   0.668218    0.924787
780        -0.0078762    0.12499224   -0.0630141  0.949755    0.993189
2101       -0.0058122    0.08224453   -0.0706701  0.943660    0.986571
2597        0.00710451   0.10404212    0.06828492 0.945558    0.999256
54812      -0.1922592    0.11767320   -1.8237562  0.102292    0.430841
}
