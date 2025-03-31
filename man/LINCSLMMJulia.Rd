\name{LINCSLMMJulia}
\alias{LINCSLMMJulia}
\title{Execute julia_call to compute LMM using the formula: gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}
\description{
Execute \code{julia_call} to compute Linear Mixed Models (LMM) using the formula:
\cr
\code{gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}.
\cr
To use this function, the Julia environment must be installed on the system.
}
\usage{
lincsLMMJulia <- LINCSLMMJulia$new()
lincsLMMJulia$compute(rna_data_metadata)
}
\arguments{
  \item{rna_data_metadata}{
    Table containing RNA data analysis and metadata. The \code{gene_expression} column stores gene expression values under different conditions, while all other columns contain metadata for the LMM.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
}
\examples{
rna_data_metadata <- data.frame(
  inst_id = c("AML001", "AML002", "AML003", "AML004", "AML005", "AML006", "AML007", "AML008"),
  rna_plate = c("XA34", "XA34", "XA34", "XA34", "XA35", "XA35", "XA35", "XA35"),
  pert_iname = c("DMSO", "AM-251", "AM-251", "AM-404", "AM-404", "AM-580", "DMSO", "AM-580"),
  cell_id = c("CD33", "CD33", "CD33", "CD35", "CD35", "CD34", "CD34", "CD34"),
  gene_expression = c(8.308500, 8.333750, 7.146400, 7.538700, 8.561700, 7.506200, 8.372150, 9.003900)
)

lincsLMMJulia <- LINCSLMMJulia$new()
lincsLMMJulia$compute(rna_data_metadata)

}
