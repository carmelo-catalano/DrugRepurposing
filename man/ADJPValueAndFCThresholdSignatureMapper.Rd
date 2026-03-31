\name{ADJPValueAndFCThresholdSignatureMapper}
\alias{ADJPValueAndFCThresholdSignatureMapper}
\title{Extract the most significant genes based on adjusted p-value and differential gene expression}
\description{
    Extract the most significant genes from the input \code{\link{DGE}} table.\cr
    Significance is determined based on the adjusted p-value and the differential gene expression.\cr
    The \code{\link{DGE}} table’s rows with adjusted p-value greater than a given threshold and differential gene expression less than a given threshold are removed.\cr
    The output table is structured as a data.frame with two columns:
    \itemize{
            \item The first column, named "gene_id", contains the gene identifiers.
            \item The second column, named "estimate", contains the t-value.
    }
    The output represents the \link{Gene-expression-signature}.
}

\usage{
  adjPValueAndFCThresholdSignatureMapper <- ADJPValueAndFCThresholdSignatureMapper$new(p.value_threshold, DE_log2_FC_threshold)
  adjPValueAndFCThresholdSignatureMapper$map(dge)
  adjPValueAndFCThresholdSignatureMapper$getSignatureType()
}

\arguments{
  \item{dge}{
    A table containing a DGE.
    \itemize{
      \item Type: \code{data.frame}
    }
  }
  \item{adj.p.value_threshold (constructor argument)}{
    p-value threshold.
    \itemize{
      \item Type: \code{float}
      \item Default value: \code{0.001}.
    }
  }
  \item{DE_log2_FC_threshold (constructor argument)}{
    Differential gene expression threshold expressed as base 2 logarithm of fold change.
    \itemize{
      \item Type: \code{float}
      \item Default value: \code{1.5}.
    }
  }
}

\value{
  Data frame. Columns: \code{gene_id}, \code{estimate} (usually the t-value column of the DGE).
}

\examples{
  dge <- data.frame(
    gene_id = c(1, 10, 100, 1000, 10000, 10001, 10002, 10003, 10004, 10005),
    DE_log2_FC = c(3.411, 0.201, 0.207, 2.618, -1.921, -2.102, -0.838, -2.924, -3.118, -0.243),
    std.error = c(0.156, 0.218, 0.169, 0.396, 0.112, 0.048, 0.248, 0.140, 0.083, 0.110),
    t.value = c(2.621, 0.924, 1.228, 6.609, -1.082, -2.097, -3.371, -6.571, -1.430, -2.212),
    p.value = c(0.0003, 0.001, 0.0912, 0.123, 0.008, 0.00001, 0.002, 0.001, 0.02, 0.002),
    adj.p.value = c(0.002, 0.003, 0.1012, 0.213, 0.04, 0.0001, 0.005, 0.004, 0.04, 0.003)
  )

# dge =
# gene_id   DE_log2_FC   std.error   t.value   p.value   adj.p.value
--------------------------------------------------------------------
# 1         3.411        0.156       2.621     0.0003    0.0020
# 10        0.201        0.218       0.924     0.0010    0.0030
# 100       0.207        0.169       1.228     0.0912    0.1012
# 1000      2.618        0.396       6.609     0.1230    0.2130
# 10000     -1.921       0.112       -1.082    0.0080    0.0400
# 10001     -2.102       0.048       -2.097    0.00001   0.0001
# 10002     -0.838       0.248       -3.371    0.0020    0.0050
# 10003     -2.924       0.140       -6.571    0.0010    0.0040
# 10004     -3.118       0.083       -1.430    0.0200    0.0400
# 10005     -0.243       0.110       -2.212    0.0020    0.0030

  adj.p.value_threshold <- 0.05
  DE_log2_FC_threshold <- 1.7

  adjPValueAndFCThresholdSignatureMapper <- ADJPValueAndFCThresholdSignatureMapper$new(adj.p.value_threshold, DE_log2_FC_threshold)
  adjPValueAndFCThresholdSignatureMapper$map(dge)
  adjPValueAndFCThresholdSignatureMapper$getSignatureType()

  # output
  # gene_id   estimate
  # ----------------------
  # 1         2.621613414
  # 10000     -1.082000871
  # 10001     -2.097975261
  # 10003     -6.571687173
  # 10004     -1.430383326
}
