\name{DGEMergeByGene}
\alias{DGEMergeByGene}
\title{Reorganize gene-wise DGEs into drug-wise DGEs}
\description{
Differential gene expression (\link{DGE}) analysis using linear mixed models (LMM) is sometimes performed gene-by-gene across different conditions.
In this case, a function like \code{LMMDGEByGene$compute} returns the DGE analysis for a single gene across different conditions, meaning the output is grouped by gene.
\cr
When analyzing the LINCS database, DGE is not calculated from the entire sequencing of a drug's effect but rather by examining the effect of all drugs on a single gene.
\cr
To calculate the connectivity score, the DGE for each gene relative to the drug is required.
\cr
\code{DGEMergeByGene} reorganizes the gene-wise DGEs into drug-wise DGEs.
}
\usage{
dgeMergeByGene <- DGEMergeByGene$new()
dgeMergeByGene$compute(
  gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, drug_field_name, gene_dge_filename_pattern
)
}
\arguments{
  \item{gene_list}{
    Gene list to reorganize.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{drug_list}{
    Drug list to reorganize.
    \itemize{
      \item Type: \code{string vector}.
    }
  }
  \item{input_dge_dir}{
    Directory containing the DGE gene files. The filenames are described by the \code{dge_filename_pattern} argument and contain the gene_id. The files are in RDS format.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{output_drugs_dge_dir}{
    Output directory. The filenames match the drug names.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drug_field_name}{
    The column name in the gene DGE table that contains the drug name.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{gene_dge_filename_pattern}{
    The filename pattern of the gene DGE.
    \itemize{
      \item Type: \code{string}.
      \item Default value: "#id.Rds".
    }
  }
}
\value{
List of files in RDS format. Each file contains a drug DGE. The data are saved as a data frame.
\cr
Columns: \code{drug}, \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
gene_list <- c(140, 780, 2101, 2597, 54812)
drug_list <- c("3-matida", "AG-592", "AG-957")
input_dge_dir <- "/home/user/gene_dges"
output_drugs_dge_dir <- "/home/user/drug_dges"
drug_field_name <- "drug"
gene_dge_filename_pattern <- "#id.Rds"

dgeMergeByGene <- DGEMergeByGene$new()
dgeMergeByGene$compute(
  gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, drug_field_name, gene_dge_filename_pattern
)
# output
# drug      gene_id    DE_log2_FC    std.error    t.value     p.value     adj.p.value
# 3-matida  140        -0.0510758    0.11917072   -0.428593   0.668218    0.924787
# 3-matida  780        -0.0078762    0.12499224   -0.0630141  0.949755    0.993189
# 3-matida  2101       -0.0058122    0.08224453   -0.0706701  0.943660    0.986571
# 3-matida  2597        0.00710451   0.10404212    0.06828492 0.945558    0.999256
# 3-matida  54812      -0.1922592    0.11767320   -1.8237562  0.102292    0.430841
}
