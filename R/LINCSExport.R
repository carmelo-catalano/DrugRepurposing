LINCSExport <- R6Class(
  "LINCSExport",
  public = list(
    initialize = function(gctx_archive_filename, lincsMetadataSetuper = NA) {
      if (obj_is_na(lincsMetadataSetuper)){
        private$lincsMetadataSetuper <- LINCSMetadataSetuper$new()
      }else {
        if (!"LINCSMetadataSetuperAbstract" %in% class(lincsMetadataSetuper))
          stop("the lincsExperimentMetaDataSetuper instance must be of type LINCSMetadataSetuperAbstract")
        private$lincsMetadataSetuper <- lincsMetadataSetuper
      }
      lincsSGCTXDataRowLoader <- LINCSGCTXDataRowLoader$new(gctx_archive_filename)
      private$lincsExportByGeneList <- LINCSExportByGeneList$new(lincsSGCTXDataRowLoader)
    },
    export = function(gene_list,
                      perturbation_times,
                      output_dir,
                      gene_number_batch_size = 200,
                      drugs_filter = NA
    ) {
      experiments_meta_data <- private$lincsMetadataSetuper$setup(perturbation_times, drugs_filter)
      gene_index <- 1
      tot_genes <- length(gene_list)
      while (gene_index <= tot_genes) {
        ext_sup <- min(gene_index + gene_number_batch_size - 1, tot_genes)
        private$lincsExportByGeneList$export(gene_list, experiments_meta_data, gene_index, ext_sup, output_dir)
        gene_index <- gene_index + gene_number_batch_size
      }
    }
  ),
  private = list(
    lincsMetadataSetuper = NA,
    lincsExportByGeneList = NA
  )
)
