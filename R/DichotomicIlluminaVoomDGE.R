
DichotomicIlluminaVoomDGE <- R6Class(
  "DichotomicIlluminaVoomDGE",
  public = list(
    initialize = function(geneFilter = NA) {
      private$dichotomicVoomDGE <- DichotomicVoomDGE$new()
      if (obj_is_na(geneFilter)) {
        geneFilter <- LowCountsGeneFilter$new()
      }
      private$dicotomicIlluminaRNASeqLoader <- DicotomicIlluminaRNASeqLoader$new(geneFilter)
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq_filename, sample_01_map, test_sample_name, filter_by_protein_coding = F) {
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start %s signature computation", test_sample_name))
      gene_experiments_data <- private$dicotomicIlluminaRNASeqLoader$load(rna_seq_filename, sample_01_map, test_sample_name)
      if (filter_by_protein_coding) {
        gene_experiments_data$gene_expressions <- private$geneFilterByProteinCoding$filterById(gene_experiments_data$gene_expressions)
      }
      signature <- private$dichotomicVoomDGE$compute(gene_experiments_data)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end %s signature computation, time: %s %s", test_sample_name, totalTime, attr(totalTime, "units")))
      return(signature)
    }
  ),
  private = list(
    dichotomicVoomDGE = NA,
    dicotomicIlluminaRNASeqLoader = NA,
    geneFilterByProteinCoding = NA
  )
)
