\name{LINCSGCTXDataLoader}
\alias{LINCSGCTXDataLoader}
\title{Loads RNA gene expression for a given gene from LINCS GCTX archive}
\description{
Loads RNA gene expression for a specified gene from the \link{LINCS} GCTX archive GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx.
\cr
The output is equal to the input metadata plus a column containing the gene expression.
See exemple below.
\cr
Loads RNA gene expression for a specified gene from the \link{LINCS} GCTX archive GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx.
\cr
The output consists of the input metadata with an additional column containing the gene expression values. See example below.
\cr
Metadata are prepared using the \code{\link{LINCSMetadataSetuper}} class.
}
\usage{
gctx_archive_filename <- "GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"
lincsGCTXDataLoader <- LINCSGCTXDataLoader$new(gctx_archive_filename)
lincsGCTXDataLoader$load(gene_id, metadata)
}
\arguments{
  \item{gene_id}{
    Gene id to load.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{metadata}{
    Metadata for selecting RNA analysis. The metadata are prepared using the \code{\link{LINCSMetadataSetuper}} class.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{gctx_archive_filename (constructor argument)}{
    The full file path of the GCTX archive.
    \itemize{
      \item Type: \code{character}.
    }
  }
}
\value{
A metadata matrix consisting of the original metadata matrix with an additional column for RNA gene expression data retrieved from the LINCS archive.
}
\examples{
gene_id <- "780"
metadata <- data.frame(
  inst_id = c("AML001_CD34_24H_X1_F1B10:B05", "AML001_CD34_24H_X1_F1B10:E03", "AML001_CD34_24H_X1_F1B10:E07"),
  rna_plate = c("AML001_CD34_24H_X1", "AML001_CD34_24H_X1", "AML001_CD34_24H_X1"),
  pert_id = c("DMSO", "BRD-K27499107", "BRD-K27499107"),
  pert_iname = c("DMSO", "carbacyclin", "carbacyclin"),
  pert_time = c(24, 24, 24),
  cell_id = c("CD34", "CD34", "CD34")
)

# metadata
# inst_id                      rna_plate             pert_id        pert_iname     pert_time   cell_id
# ----------------------------------------------------------------------------------------------------
# AML001_CD34_24H_X1_F1B10:B05 AML001_CD34_24H_X1    DMSO           DMSO           24          CD34
# AML001_CD34_24H_X1_F1B10:E03 AML001_CD34_24H_X1    BRD-K27499107  carbacyclin    24          CD34
# AML001_CD34_24H_X1_F1B10:E07 AML001_CD34_24H_X1    BRD-K27499107  carbacyclin    24          CD34


gctx_archive_filename <- "GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"
lincsGCTXDataLoader <- LINCSGCTXDataLoader$new(gctx_archive_filename)
lincsGCTXDataLoader$load(gene_id, metadata)

# Output:
# inst_id                      rna_plate             pert_id        pert_iname     pert_time   cell_id      gene_expression
# -------------------------------------------------------------------------------------------------------------------------
# AML001_CD34_24H_X1_F1B10:B05 AML001_CD34_24H_X1    DMSO           DMSO           24          CD34         8.30850
# AML001_CD34_24H_X1_F1B10:E03 AML001_CD34_24H_X1    BRD-K27499107  carbacyclin    24          CD34         8.33375
# AML001_CD34_24H_X1_F1B10:E07 AML001_CD34_24H_X1    BRD-K27499107  carbacyclin    24          CD34         7.14640
}
