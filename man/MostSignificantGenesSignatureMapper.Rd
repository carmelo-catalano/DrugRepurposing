\name{MostSignificantGenesSignatureMapper}
\alias{MostSignificantGenesSignatureMapper}
\title{Extract the most significant genes from the input DGE}
\description{
Extracts the \code{n} most significant genes from the input Differential Gene Expression (DGE) table.
\cr
Significance is determined based on the absolute value of the \code{t.value}. Rows in the DGE table are ordered by the absolute \code{t.value}, and the top \code{n} rows are extracted.
\cr
The output contains only one column, named \code{estimate}, which holds the \code{t.value}. Row names correspond to the \code{gene_id}.
}
\usage{
mostSignificantGenesSignatureMapper <- MostSignificantGenesSignatureMapper$new()
mostSignificantGenesSignatureMapper$map(dge)
}
\arguments{
  \item{dge}{
    A table containing a DGE.
    \itemize{
      \item Type: \code{data.frame}.
      \item Required columns: \code{gene_id}, \code{t.value}.
    }
  }
  \item{n_most_significant_genes}{
    The connectivity score computation is based on the disease signature.
    \cr
    The disease's \code{n} most significant genes represent the signature.
    A typical \code{n} value ranges from 50 to 300.
    \cr
    If not specified, \code{n_most_significant_genes} constructor parameter is used.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{NA}.
    }
  }
  \item{n_most_significant_genes (constructor argument)}{
    The connectivity score computation is based on the disease signature.
    \cr
    The disease's \code{n} most significant genes represent the signature.
    A typical \code{n} value ranges from 50 to 300.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{100}.
    }
  }
}
\value{
Data frame with the following properties:
\itemize{
  \item Row names: \code{gene_id}.
  \item Column: \code{estimate} (corresponding to the \code{t.value} from the DGE).
}
}
\examples{
dge <- data.frame(
  gene_id = c(1, 10, 100, 1000, 10000, 10001, 10002, 10003, 10004, 10005),
  DE_log2_FC = c(0.4113099, 0.2016503, 0.2077629, 2.6180993, -0.1216854, -0.1024191, -0.8385437, -0.9246359, -0.1188855, -0.2438541),
  std.error = c(0.1568919, 0.2180894, 0.1691538, 0.3961157, 0.1124633, 0.0488181, 0.2487069, 0.1406999, 0.0831145, 0.1102017),
  t.value = c(2.621613, 0.924622, 1.228248, 6.609430, -1.082001, -2.097975, -3.371615, -6.571687, -1.430383, -2.212797),
  p.value = c(1.23E-04, 3.61E-05, 2.26E-05, 6.30E-02, 2.86E-05, 4.22E-04, 1.66E-03, 7.12E-02, 1.60E-05, 3.26E-04),
  adj.p.value = c(2.76E-04, 4.53E-05, 3.10E-05, 1.04E+00, 3.74E-05, 7.71E-04, 5.15E-03, 1.15E+00, 2.34E-05, 6.22E-04)
)

# dge =
# gene_id     DE_log2_FC    std.error    t.value      p.value      adj.p.value
# 1           0.4113099     0.1568919    2.6216134    1.23E+04     2.76E+04
# 10          0.2016503     0.2180894    0.9246224    3.61E+05     4.53E+05
# 100         0.2077629     0.1691538    1.2282485    2.26E+05     3.10E+05
# 1000        2.6180994     0.3961157    6.6094304    6.30E-02     1.04E+00
# 10000      -0.1216854     0.1124633   -1.0820009    2.86E+05     3.74E+05
# 10001      -0.1024191     0.0488181   -2.0979753    4.22E+04     7.71E+04
# 10002      -0.8385437     0.2487069   -3.3716146    1.66E+03     5.15E+03
# 10003      -0.9246359     0.1406999   -6.5716872    7.12E-02     1.15E+00
# 10004      -0.1188856     0.0831145   -1.4303833    1.60E+05     2.34E+05
# 10005      -0.2438541     0.1102017   -2.2127974    3.26E+04     6.22E+04

n_most_significant_genes <- 5
mostSignificantGenesSignatureMapper <- MostSignificantGenesSignatureMapper$new()
mostSignificantGenesSignatureMapper$map(dge, n_most_significant_genes)

# output =
# estimate
# 1000    6.609430
# 10003  -6.571687
# 10002  -3.371615
# 1       2.621613
# 10005  -2.212797
}
