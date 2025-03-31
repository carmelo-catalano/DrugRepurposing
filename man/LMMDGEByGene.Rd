\name{LMMDGEByGene}
\alias{LMMDGEByGene}
\title{Compute the differential gene expression (DGE) of a gene under different conditions using a Linear Mixed Model (LMM)}
\description{
This function computes the differential gene expression (DGE) of a gene under different conditions
using a Linear Mixed Model (LMM). It combines a derived class from \code{LMMAbstract} for LMM
computation and a derived class from \code{LMMToDataFrameMapperAbstract} to map the results into
a \code{data frame}.
}
\arguments{
  \item{rna_data_metadata}{
    Table containing RNA data analysis and metadata. The \code{gene_expression} column stores gene expression values under different conditions, while all other columns contain metadata for the LMM.
    \itemize{
      \item Type: \code{data frame}.
    }
  }
  \item{gene_id}{
    Gene id. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{sample_type_column_name}{
    Sample type column name. For example, usually for LINCS analysis is \code{"drug"}.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_type"}.
    }
  }
  \item{lmm (constructor argument)}{
    Instance class from LMM computation. This class instance must be compatible with \code{lmmToDataFrameMapper}.
    \itemize{
      \item Type: Derived class of \code{LMMAbstract}.
    }
  }
  \item{lmmToDataFrameMapper (constructor argument)}{
    Instance class for mapping the output of the LMM computation into a \code{data frame}. This class instance must be compatible with \code{lmm}.
    \itemize{
      \item Type: \code{Derived class of LMMToDataFrameMapperAbstract}.
    }
  }
}
\value{
Data frame. Columns: \code{sample_type}, \code{gene_id} (optional), \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\code{lmer} does not return the parameter \code{p-value}, so if \code{lmm = LmerLMM}, the output does not contain the columns \code{p.value} and \code{adj.p.value}.
}
\examples{
rna_data_metadata <- data.frame(
  inst_id = c("AML001", "AML002", "AML003", "AML004", "AML005", "AML006", "AML007", "AML008"),
  rna_plate = c("XA34", "XA34", "XA34", "XA34", "XA35", "XA35", "XA35", "XA35"),
  pert_iname = c("DMSO", "AM-251", "AM-251", "AM-404", "AM-404", "AM-580", "DMSO", "AM-580"),
  cell_id = c("CD33", "CD33", "CD33", "CD35", "CD35", "CD34", "CD34", "CD34"),
  gene_expression = c(8.308500, 8.333750, 7.146400, 7.538700, 8.561700, 7.506200, 8.372150, 9.003900)
)
gene_id <- 780
sample_type_column_name <- "drug"
lmm <- LINCSLMMJulia$new()
lmmToDataFrameMapper <- JuliaLMMToDataFrameMapper$new()
lmmDGEByGene <- LMMDGEByGene$new(lmm, lmmToDataFrameMapper)
result <- lmmDGEByGene$compute(rna_data_metadata, gene_id, sample_type_column_name)
print(result)
# Output example:
# drug            gene_id   DE_log2_FC   std.error   t.value   p.value   adj.p.value
# AM-251          DDR1      -0.047038    0.073635    -0.639    0.523     0.653
# AM-404          DDR1      -0.199576    0.071673    -2.785    0.00536   0.0268
# AM-580          DDR1       0.051221    0.055126     0.929    0.353     0.588
}
