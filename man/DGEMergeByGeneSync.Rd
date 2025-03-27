\name{DGEMergeByGeneSync}
\alias{DGEMergeByGeneSync}
\title{Reorganize Gene-Wise DGEs into Drug-Wise DGEs Synchronously}
\description{
This class reorganizes gene-wise DGEs into drug-wise DGEs for connectivity score computation. It performs synchronous computation and works on all systems.
}
\usage{
DGEMergeByGeneSync$new()
DGEMergeByGeneSync$compute(gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, 
                           drug_field_name, gene_dge_filename_pattern)
}
\arguments{
  \item{Same arguments as \code{DGEMergeByGeneParallel}.}
}
\value{
Same as \code{DGEMergeByGeneParallel}.
}
\examples{
gene_list <- c(140, 780, 2101, 2597, 54812)
drug_list <- c("3-matida", "AG-592", "AG-957")
input_dge_dir <- "/home/user/gene_dges"
output_drugs_dge_dir <- "/home/user/drug_dges"
drug_field_name <- "drug"
gene_dge_filename_pattern <- "#id.Rds"

dgeMergeByGeneSync <- DGEMergeByGeneSync$new()
dgeMergeByGeneSync$compute(gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, 
                            drug_field_name, gene_dge_filename_pattern)
}
