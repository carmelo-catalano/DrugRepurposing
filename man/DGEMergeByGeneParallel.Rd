\name{DGEMergeByGeneParallel}
\alias{DGEMergeByGeneParallel}
\title{Reorganize Gene-Wise DGEs into Drug-Wise DGEs in Parallel}
\description{
This class reorganizes gene-wise DGEs into drug-wise DGEs for connectivity score computation. It works only on Unix-like systems and leverages parallel computation for efficiency.
}
\usage{
DGEMergeByGeneParallel$new()
DGEMergeByGeneParallel$compute(gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, 
                               drug_field_name, gene_dge_filename_pattern)
}
\arguments{
  \item{gene_list}{
    Gene list to reorganize.
    \itemize{
      \item Type: \code{vector}
    }
  }
  \item{drug_list}{
    Drug list to reorganize.
    \itemize{
      \item Type: \code{string vector}
    }
  }
  \item{input_dge_dir}{
    Directory containing the DGE files by gene.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{output_drugs_dge_dir}{
    Directory where the drug-wise DGE files will be saved.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{drug_field_name}{
    The column name in the DGE table that contains the drug name.
    \itemize{
      \item Type: \code{string}
    }
  }
  \item{gene_dge_filename_pattern}{
    The filename pattern for the gene-wise DGE files.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{"#id.Rds"}
    }
  }
}
\value{
A list of files in RDS format, each containing drug-specific DGE data. 
Each file includes columns: \code{drug}, \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
gene_list <- c(140, 780, 2101, 2597, 54812)
drug_list <- c("3-matida", "AG-592", "AG-957")
input_dge_dir <- "/home/user/gene_dges"
output_drugs_dge_dir <- "/home/user/drug_dges"
drug_field_name <- "drug"
gene_dge_filename_pattern <- "#id.Rds"

dgeMergeBy