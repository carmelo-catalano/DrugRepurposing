\name{LMMJulia}
\alias{LMMJulia}
\title{Computes a Linear Mixed Model (LMM) for differential gene expression (DGE) analysis under different conditions}
\description{
Computes a Linear Mixed Model (LMM) for differential gene expression (\code{DGE}) analysis under different conditions.
This class is derived from \code{LMMAbstract}.
The formula is set via the constructor to facilitate its use as a collaborator in other classes.
The \code{lmer} function from the \code{lme4} package and the \code{dream} function from \code{variancePartition} have very low performance.
In contrast, the \code{fit} function from the Julia environment is approximately 60–70 times faster than \code{lmer} and 100 times faster than \code{dream}.
To use this function, the Julia environment must be installed on the system.
}
\usage{
juliaLMM <- LMMJulia$new(formula)
juliaLMM$compute(rna_data_metadata)
}
\arguments{
  \item{rna_data_metadata}{
    Table containing RNA data analysis and metadata. The \code{gene_expression} column stores gene expression values under different conditions, while all other columns contain metadata for the LMM.
    \itemize{
      \item Type: \code{data frame}.
    }
  }
  \item{formula (constructor argument)}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA experiments were performed.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
}
\value{
The output of a Julia call is an R Environment. This package provides the class \code{JuliaLMMToDataFrameMapper} to extract the content.
}
\examples{
rna_data_metadata <- data.frame(
  inst_id = c("AML001", "AML002", "AML003", "AML004", "AML005", "AML006", "AML007", "AML008"),
  rna_plate = c("XA34", "XA34", "XA34", "XA34", "XA35", "XA35", "XA35", "XA35"),
  pert_iname = c("DMSO", "AM-251", "AM-251", "AM-404", "AM-404", "AM-580", "DMSO", "AM-580"),
  cell_id = c("CD33", "CD33", "CD33", "CD35", "CD35", "CD34", "CD34", "CD34"),
  gene_expression = c(8.308500, 8.333750, 7.146400, 7.538700, 8.561700, 7.506200, 8.372150, 9.003900)
)
# rna_data_metadata =
# inst_id     rna_plate   pert_iname   cell_id   gene_expression
# AML001      XA34        DMSO         CD33      8.308500
# AML002      XA34        AM-251       CD33      8.333750
# AML003      XA34        AM-251       CD33      7.146400
# AML004      XA34        AM-404       CD35      7.538700
# AML005      XA35        AM-404       CD35      8.561700
# AML006      XA35        AM-580       CD34      7.506200
# AML007      XA35        DMSO         CD34      8.372150
# AML008      XA35        AM-580       CD34      9.003900

formula <- gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)
juliaLMM <- LMMJulia$new(formula)
result <- juliaLMM$compute(rna_data_metadata)
lmmJuliaToDataFrameMapper <- LMMJuliaToDataFrameMapper$new()
dge <- lmmJuliaToDataFrameMapper$map(result, "DDR1", "pert_iname", "drug")

# dge output example:
# drug            gene_id   DE_log2_FC   std.error   t.value   p.value   adj.p.value
# AM-251          DDR1      -0.047038    0.073635    -0.639    0.523     0.653
# AM-404          DDR1      -0.199576    0.071673    -2.785    0.00536   0.0268
# AM-580          DDR1       0.051221    0.055126     0.929    0.353     0.588
}
