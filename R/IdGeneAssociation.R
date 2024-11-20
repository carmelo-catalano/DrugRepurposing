library(R6)
library(data.table)
# source("modules/config.R")

IdGeneAssociation <- R6Class(
  "IdGeneAssociation",
  public = list(
    load = function() {
      HiSeq_annot_file <- absolute_package_filename(config$Illumina_HiSeq_annot_filename)
      id_gene_association <- data.table::fread(HiSeq_annot_file, header = T, quote = "", stringsAsFactors = F, data.table = F)
      colnames(id_gene_association)[1] <- "ID"
      colnames(id_gene_association)[2] <- "gene"
      id_gene_association <- id_gene_association[, c("ID", "gene")]
      return(id_gene_association)
    }
  )
)
