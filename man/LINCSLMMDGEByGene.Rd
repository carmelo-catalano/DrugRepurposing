\name{LINCSLMMDGEByGene}
\alias{LINCSLMMDGEByGene}
\title{Compute the differential gene expression (DGE) of a gene under different conditions using a Linear Mixed Model (LMM)}
\description{
Given a gene ID and the associated RNA gene expression data and metadata from \link{LINCS}, computes the differential
gene expression (\link{DGE}) under different conditions using a Linear Mixed Model (LMM).
The metadata contain information about the RNA experiment (conditions). See example below.
\cr
It combines a derived class from \code{LMMAbstract} for LMM computation and a derived
class from \code{LMMToDataFrameMapperAbstract} to map the results into a \code{data frame}.
\cr
This class serves as the core component for the following classes:
\code{\link{LINCSGCTXLMMDrugDGELmer}}, \code{\link{LINCSRDSLMMDrugDGELmer}}, and \code{\link{LINCSRDSLMMDrugDGEJulia}}.
}
\arguments{
  \item{rna_data_metadata}{
    Table composed of \link{LINCS} metadata (GSE92742_Broad_LINCS_inst_info.txt) and the corresponding
    gene expression levels from GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx.
    \cr
    RNA data follow a normal distribution.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{gene_id}{
    Gene id. If specified, it is added to the output table. The column is populated with the same value \code{"gene_id"}.
    \cr
    It is not used for the computation.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{NA}.
    }
  }
  \item{fixed_effect_new_column_name}{
    This package performs \link{LINCS} differential gene expression analysis for multiple drugs against
    a single gene, as shown in the example below.
    \cr
    The Linear Mixed Model is fitted using the formula: \code{gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}
    (the fixed effect "pert_iname" corresponds to the drug name).
    \cr
    With this configuration, the DGE is computed for each input drug.
    \code{fixed_effect_new_column_name} specifies the name of the drug column in the output table.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{"drug"}.
    }
  }
  \item{lmm (constructor argument)}{
    Instance of a class for LMM computation. Two implementations are available: \code{LMMJulia}, and \code{LMMLmer}.
    \cr
    This class instance must be compatible with the constructor argument \code{lmmToDataFrameMapper}.
    If \code{lmm = LMMJulia}, then \code{lincsLMMToDataFrameMapper = LINCSLMMJuliaToDataFrameMapper}.
    If \code{lmm = LMMLmer}, then \code{lincsLMMToDataFrameMapper = LINCSLMMLmerToDataFrameMapper}.
    \itemize{
      \item Type: Derived class of \code{LMMAbstract}.
    }
  }
  \item{lincsLMMToDataFrameMapper (constructor argument)}{
    Instance class for mapping the output of the LMM computation into a \code{data frame}.
    This class instance must be compatible with \code{lmm}.
    \itemize{
      \item Type: \code{Derived class of LINCSLMMToDataFrameMapperAbstract}.
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
# rna_data_metadata
# inst_id         rna_plate   pert_iname   cell_id   gene_expression
# ------------------------------------------------------------------
# AML001          XA34        DMSO         CD33      8.308500
# AML002          XA34        AM-251       CD33      8.333750
# AML003          XA34        AM-251       CD33      7.146400
# AML004          XA34        AM-404       CD35      7.538700
# AML005          XA35        AM-404       CD35      8.561700
# AML006          XA35        AM-580       CD34      7.506200
# AML007          XA35        DMSO         CD34      8.372150
# AML008          XA35        AM-580       CD34      9.003900

gene_id <- 780
sample_name_column_name <- "drug"
lmm <- LINCSLMMJulia$new() # LINCSLMMJulia uses the formula: gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)
lmmToDataFrameMapper <- JuliaLMMToDataFrameMapper$new()
lincsLMMDGEByGene <- LINCSLMMDGEByGene$new(lmm, lmmToDataFrameMapper)
result <- lincsLMMDGEByGene$compute(rna_data_metadata, gene_id, sample_name_column_name)
print(result)
# Output example:
# drug            gene_id   DE_log2_FC   std.error   t.value   p.value   adj.p.value
# -----------------------------------------------------------------------------------
# AM-251          DDR1      -0.047038    0.073635    -0.639    0.523     0.653
# AM-404          DDR1      -0.199576    0.071673    -2.785    0.00536   0.0268
# AM-580          DDR1       0.051221    0.055126     0.929    0.353     0.588
}
