DGEMergeByGeneSync <- R6Class(
  "DGEMergeByGeneSync",
  public = list(
    initialize = function() {
      private$filenameBuilder <- FilenameBuilder$new()
    },
    merge = function(gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, drug_field_name, dge_filename_pattern = "#id.Rds") {
      if (!private$filenameBuilder$valid_filename_pattern(dge_filename_pattern)) {
        stop("dge_filename_pattern should contain \"#id\" patten")
      }
      dgrpLogger$log("starting differential gene expressions reading")
      processorCores$initCores()
      total_genes <- length(gene_list)
      merged_dges <- data.frame()
      for (i in 1:total_genes) {
        filename <- private$filenameBuilder$build(dge_filename_pattern, gene_list[i])
        dgrpLogger$log(paste0(i, " - ", filename))
        filename <- paste0(input_dge_dir, filename)
        dge <- readRDS(filename)
        merged_dges <- rbind(merged_dges, subset(dge, dge[[drug_field_name]] %in% drug_list))
      }
      dgrpLogger$log("ending differential gene expressions reading")
      dgrpLogger$log("starting differential gene expressions group saving")
      total_drugs <- length(drug_list)
      for (i in 1:total_drugs) {
        selected_drug <- subset(merged_dges, merged_dges[[drug_field_name]] %in% drug_list[i])
        filename <- paste0(output_drugs_dge_dir, drug_list[i], ".Rds")
        rownames(selected_drug) <- NULL
        saveRDS(selected_drug, filename)
        dgrpLogger$log(paste0(i, " - ", drug_list[i]))
      }
      dgrpLogger$log("ending differential gene expressions group saving")
    }
  ),
  private = list(
    filenameBuilder = NA
  )
)
