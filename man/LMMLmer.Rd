\name{LMMLmer}
\alias{LMMLmer}
\title{Computes a Linear Mixed Model (LMM) for differential gene expression (DGE) analysis under different conditions}
\description{
Computes a Linear Mixed Model (LMM) for differential gene expression (\link{DGE}) analysis under different conditions.
This class is derived from \code{\link{LMMAbstract}}.
The formula is set via the constructor (constructor argument) to facilitate its use as a collaborator in other classes.
The LMM is computed using the \code{lmer} function from the \code{lme4} package.
}
\usage{
lmmLmer <- LMMLmer$new(formula)
lmmLmer$compute(rna_data_metadata)
}
\arguments{
  \item{rna_data_metadata}{
    Data frame containing RNA expression values and associated metadata. The \code{gene_expression} column stores the gene expression levels, while all other columns provide experimental metadata used in the LMM computation.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula (constructor argument)}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account
    for all the conditions under which the RNA experiments were performed.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
}
\value{
An object of class \code{merMod}. This package provides the class \code{LmerLMMToDataFrameMapper} to map the \code{lmer} result into a \code{data frame}.
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

# rna_data_metadata =
# inst_id     rna_plate   pert_iname   cell_id   gene_expression
# ---------------------------------------------------------------
# AML001      XA34        DMSO         CD33      8.308500
# AML002      XA34        AM-251       CD33      8.333750
# AML003      XA34        AM-251       CD33      7.146400
# AML004      XA34        AM-404       CD35      7.538700
# AML005      XA35        AM-404       CD35      8.561700
# AML006      XA35        AM-580       CD34      7.506200
# AML007      XA35        DMSO         CD34      8.372150
# AML008      XA35        AM-580       CD34      9.003900


formula <- gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)
# pert_iname is a factor and represents the fixed effect; DMSO (first element of the factor) is the control.
# cell_id and rna_plate are random effects.

lmmLmer <- LMMLmer$new(formula)
result <- lmmLmer$compute(rna_data_metadata)
lmmLmerToDataFrameMapper <- LMMLmerToDataFrameMapper$new()
dge <- lmmLmerToDataFrameMapper$map(result, "DDR1", "pert_iname", "drug")

# Output =
# drug            gene_id   DE_log2_FC   std.error   t.value
# ------------------------------------------------------------
# AM-251          DDR1      -0.600250    0.7667697   -0.7828296
# AM-404          DDR1      -0.290125    0.7667697   -0.3783731
# AM-580          DDR1      -0.085275    0.7667697   -0.1112133
}
