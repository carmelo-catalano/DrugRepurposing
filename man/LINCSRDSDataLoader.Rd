\name{LINCSRDSDataLoader}
\alias{LINCSRDSDataLoader}
\title{Loads LINCS gene expression level from RDS file}
\description{
Loads \link{LINCS} gene expression level from RDS file. The Rds file is the output of \code{\link{LINCSExport}}.
}
\usage{
lincs_splitted_level3_dir <- "/home/user/lincs_data"
lincsRDSDataLoader <- LINCSRDSDataLoader$new(lincs_splitted_level3_dir)
result <- lincsRDSDataLoader$load(gene_id, metadata)
}
\arguments{
  \item{gene_id}{
    Gene id to load.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{metadata}{
    Metadata for selecting RNA analysis.
    \itemize{
      \item Type: \code{data frame}.
    }
  }
  \item{lincs_splitted_level3_dir (constructor argument)}{
    Folder containing the RDS files exported from LINCS archive.
    Each file contains RNA data for a specific gene_id, and its name corresponds to the gene_id.
    \itemize{
      \item Type: \code{string}.
    }
  }
}
\value{
Data frame. A metadata matrix consisting of the original metadata matrix with an additional
column for RNA gene expression data retrieved from the RDS LINCS archive.
}
\examples{
gene_id <- 15
metadata <- data.frame(
  inst_id = c("F1B10:B05", "F1B10:E03", "F1B10:E07", "F1B10:E09", "F1B10:G10"),
  rna_plate = c("24H_X1", "24H_X1", "24H_X2", "24H_X2", "24H_X3"),
  pert_iname = c("DMSO", "carbacyclin", "carbacyclin", "iloprost", "DMSO"),
  pert_time = c(24, 24, 24, 24, 24)
)

# Example of RDS gene_id file content:
# F1B10:B01   F1B10:E02	 ...  F1B10:E023   F1B10:E24
# --------------------------------------------------
# 8.42569     7.948492   ...  9.148722     8.499799

lincs_splitted_level3_dir <- "/home/user/lincs_data"
lincsRDSDataLoader <- LINCSRDSDataLoader$new(lincs_splitted_level3_dir)
result <- lincsRDSDataLoader$load(gene_id, metadata)

# output
# inst_id       rna_plate   pert_id        pert_time   gene_expression
# --------------------------------------------------------------------
# F1B10:B01     24H_X1      DMSO           24          8.42569
# F1B10:E02     24H_X1      BRD-K27499107  24          7.948492
# F1B10:E07     24H_X2      BRD-K27499107  24          9.847269
# F1B10:E09     24H_X2      BRD-K57391913  24          7.918341
# F1B10:G24     24H_X3      DMSO           24          8.499799
}
