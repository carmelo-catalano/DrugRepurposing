DGEMergeByGene <- R6Class(
  "DGEMergeByGene",
  public = list(
    initialize = function() {
      private$filenameBuilder <- FilenameBuilder$new()
    },
    merge = function(gene_list, drug_list, input_dge_dir, output_drugs_dge_dir, drug_field_name, dge_filename_pattern = "#id.Rds") {
      if (!private$filenameBuilder$valid_filename_pattern(dge_filename_pattern)) {
        stop("dge_filename_pattern should contain \"#id\" patten")
      }
      input_dge_dir <- add_slash_to_directory_path(input_dge_dir)
      output_drugs_dge_dir <- add_slash_to_directory_path(output_drugs_dge_dir)
      dgrpLogger$log("starting differential gene expressions reading")
      total_genes <- length(gene_list)
      total_drugs <- length(drug_list)

      filename <- private$filenameBuilder$build(dge_filename_pattern, gene_list[1])
      filename <- paste0(input_dge_dir, filename)
      dgrpLogger$log(paste0("reading: ", 1, " - ", filename))
      dge <- readRDS(filename)
      merged_dges <- subset(dge, dge[[drug_field_name]] %in% drug_list)
      start_row <- dim(merged_dges)[1] + 1
      dge_total_columns <- dim(merged_dges)[2]
      merged_dges[total_genes * total_drugs,] <- NA
      merged_dges <- data.table(merged_dges)
      for (i in 2:total_genes) {
        filename <- private$filenameBuilder$build(dge_filename_pattern, gene_list[i])
        dgrpLogger$log(paste0("reading: ", i, " - ", filename))
        filename <- paste0(input_dge_dir, filename)
        dge <- readRDS(filename)
        dge <- subset(dge, dge[[drug_field_name]] %in% drug_list)
        dge_size <- dim(dge)[1]
        set(merged_dges, start_row:(start_row + dge_size - 1), 1:dge_total_columns, dge)
        start_row <- start_row + dge_size
      }
      setkeyv(merged_dges, drug_field_name)
      dgrpLogger$log("ending differential gene expressions reading")
      dgrpLogger$log("starting differential gene expressions group saving")
      total_drugs <- length(drug_list)
      for (i in 1:total_drugs) {
        filename <- paste0(output_drugs_dge_dir, drug_list[i], ".Rds")
        dgrpLogger$log(paste0("writing: ", i, " - ", filename))
        selected_drug <- data.frame(merged_dges[J(drug_list[i])])
        rownames(selected_drug) <- NULL
        saveRDS(selected_drug, filename)
      }
      dgrpLogger$log("ending differential gene expressions group saving")
    }
  ),
  private = list(
    filenameBuilder = NA
  )
)
