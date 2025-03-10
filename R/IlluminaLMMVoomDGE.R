IlluminaLMMVoomDGE <- R6Class(
  "IlluminaLMMVoomDGE",
  public = list(
    initialize = function(lmmVoomDGE, geneFilter = NA) {
      if (!"LMMVoomDGEAbstract" %in% class(lmmVoomDGE))
        stop("the lmmVoomDGE instance must by of type LMMVoomDGEAbstract")
      private$lmmVoomDGE <- lmmVoomDGE
      private$illuminaLMMRNASeqLoader <- IlluminaLMMRNASeqLoader$new(geneFilter)
    },
    compute = function(rna_seq_data_filename, rna_seq_metadata_filename, formula, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name = "accession", additional_fields = NA, filter_by_protein_coding = F) {
      if (length(tissue_statuses_to_be_tested) != 2) {
        stop("Error: LMM voom computation requires exactly two tissue statuses")
      }
      if (length(tissue_statuses_to_be_tested) != length(tissue_statuses_map)) {
        stop("Error: tissue_statuses_to_be_tested and tissue_statuses_map must have same length")
      }
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start differential gene expression computation"))
      rna_seq <- private$illuminaLMMRNASeqLoader$load(rna_seq_data_filename, rna_seq_metadata_filename, tissue_status_field_name, tissue_statuses_to_be_tested, tissue_statuses_map, sample_id_field_name, additional_fields)
      dge <- private$lmmVoomDGE$compute(rna_seq$data, rna_seq$metadata, formula, filter_by_protein_coding)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end differential gene expression computation, time: %s %s", totalTime, attr(totalTime, "units")))
      return(dge)
    }
  ),
  private = list(
    lmmVoomDGE = NA,
    illuminaLMMRNASeqLoader = NA
  )
)
