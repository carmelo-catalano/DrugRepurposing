GEORNASeqDichotomicVoomDGE <- R6Class(
  "GEORNASeqDichotomicVoomDGE",
  public = list(
    initialize = function(geneFilter = NA) {
      private$dichotomicVoomDGE <- DichotomicVoomDGE$new(geneFilter)
    },
    compute = function(rna_seq_filename, sample_01_map, filter_by_protein_coding = FALSE) {
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start differential gene expression computation"))
      rna_seq <- as.matrix(data.table::fread(rna_seq_filename, header = TRUE, colClasses = "integer"), rownames = "GeneID")
      dge <- private$dichotomicVoomDGE$compute(rna_seq, sample_01_map, filter_by_protein_coding)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end %s differential gene expression computation, time: %s", totalTime, attr(totalTime, "units")))
      return(dge)
    }
  ),
  private = list(
    dichotomicVoomDGE = NA
  )
)
