\name{ADJPValueAndFCThresholdSignatureMapper}
\alias{ADJPValueAndFCThresholdSignatureMapper}
\title{Extract the most significant genes based on adjusted p-value and differential gene expression}
\description{
  Extract the most significant genes from the input DGE table.
  Significance is determined based on the adjusted p-value and the differential gene expression.
  The DGE table’s rows with adjusted p-value greater than a given threshold and differential gene expression less than a given threshold are removed.
  The output will contain only one column, named \code{estimate}, which holds the t-values.
  Row names contain the gene IDs.
}

\usage{
  pValueAndFCThresholdSignatureMapper <- PValueAndFCThresholdSignatureMapper$new(p.value_threshold, DE_log2_FC_threshold)
  pValueAndFCThresholdSignatureMapper$map(dge)
  pValueAndFCThresholdSignatureMapper$getSignatureType()
}

\arguments{
  \item{dge}{
    A table containing a DGE.
    \itemize{
      \item Type: \code{data.frame}
      \item Required columns: \code{gene_id}, \code{t.value}.
    }
  }
  \item{adj.p.value_threshold (constructor argument)}{
    p-value threshold.
    \itemize{
      \item Type: \code{float}
      \item Required columns: \code{0.001}.
    }
  }
  \item{DE_log2_FC_threshold (constructor argument)}{
    Differential gene expression threshold expressed as base 2 logarithm of fold change.
      \itemize{
      \item Type: \code{float}
      \item Required columns: \code{1.5}.
    }
  }
}

\value{
  \code{data.frame}. Columns: \code{estimate} (t-value column of the DGE). Row names contain the gene IDs.
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

  adj.p.value_threshold <- 0.05
  DE_log2_FC_threshold <- 1.7

  pValueAndFCThresholdSignatureMapper <- PValueAndFCThresholdSignatureMapper$new(adj.p.value_threshold, DE_log2_FC_threshold)
  pValueAndFCThresholdSignatureMapper$map(dge)
  pValueAndFCThresholdSignatureMapper$getSignatureType()
}
