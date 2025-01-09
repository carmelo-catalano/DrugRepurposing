library(R6)
library(edgeR)
library(variancePartition)

IlluminaLMMVoomDGE <- R6Class(
  "IlluminaLMMVoomDGE",
  public = list(
    initialize = function(geneFilter = NA) {
      private$illuminaRNASeqLoader <- IlluminaRNASeqLoader$new(geneFilter)
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
      private$lmmVoomDGE <- LMMVoomDGE$new()
    },
    compute = function(rna_seq_metadata_filename, rna_seq_data_filename, tissue_statuses_to_be_tested, tissue_statuses_map, formula, filter_by_protein_coding = F) {
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start differential gene expression computation"))
      rna_seq <- private$illuminaRNASeqLoader$load(rna_seq_metadata_filename, rna_seq_data_filename, tissue_statuses_to_be_tested, tissue_statuses_map)
      if (filter_by_protein_coding) {
        rna_seq$data <- private$geneFilterByProteinCoding$filterById(rna_seq_data)
        data_size <- dim(rna_seq$data)
        dgrpLogger$log(sprintf("RNA seq data size after filtering by protein coding genes: %s X %s", data_size[1], data_size[2]))
      }
      dge <- private$lmmVoomDGE$compute(rna_seq$data, rna_seq$metadata, formula)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(dge)
    }
  ),
  private = list(
    illuminaRNASeqLoader = NA,
    geneFilterByProteinCoding = NA,
    lmmVoomDGE = NA
  )
)