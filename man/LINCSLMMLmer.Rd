\name{LINCSLMMLmer}
\alias{LINCSLMMLmer}
\title{Execute lmer to compute LMM using the formula:
gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}
\description{
Executes the \code{lmer} function from the \pkg{lme4} package to fit a Linear Mixed Model (LMM) defined by the following formula:
\cr
\code{gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}
}
\usage{
lincsLMMLmer <- LINCSLMMLmer$new()
lincsLMMLmer$compute(rna_data_metadata)
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
}
\value{
\code{lmerMod} containing output of lmer computation.
}
\examples{
drug_names <- c("DMSO", "AM-251", "AM-251", "AM-404", "AM-404", "AM-580", "DMSO", "AM-580")

uniques_drug_names <- unique(drug_names)
uniques_drug_names <- c("DMSO", uniques_drug_names[uniques_drug_names != "DMSO"])

drug_names_factor <- factor(drug_names, levels = uniques_drug_names)
rna_data_metadata <- data.frame(
  inst_id = c("AML001", "AML002", "AML003", "AML004", "AML005", "AML006", "AML007", "AML008"),
  rna_plate = c("XA34", "XA34", "XA34", "XA34", "XA35", "XA35", "XA35", "XA35"),
  pert_iname = drug_names_factor,
  cell_id = c("CD33", "CD33", "CD33", "CD35", "CD35", "CD34", "CD34", "CD34"),
  gene_expression = c(8.308500, 8.333750, 7.146400, 7.538700, 8.561700, 7.506200, 8.372150, 9.003900)
)

lincsLMMLmer <- LINCSLMMLmer$new()
lincsLMMLmer$compute(rna_data_metadata)
}
