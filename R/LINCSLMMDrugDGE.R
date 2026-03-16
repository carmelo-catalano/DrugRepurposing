LINCSLMMDrugDGE <- R6Class(
  "LINCSLMMDrugDGE",
  public = list(
    initialize = function(metadataSetuper, geneRNADataLoader, lmmDGEByGene, output_DGE_dir, skip_already_computed_genes = FALSE) {
      private$metadataSetuper <- metadataSetuper
      private$geneRNADataLoader <- geneRNADataLoader
      private$output_DGE_dir <- add_slash_to_directory_path(output_DGE_dir)
      private$geneIdToSymbolConverter <- GeneIdSymbolConverter$new()
      private$lmmDGEByGene <- lmmDGEByGene
      private$skip_already_computed_genes <- skip_already_computed_genes
    },

    compute = function(drug_perturbation_times, gene_list, drugs_filter = NA) {
      tot_genes <- length(gene_list)
      tot_drug_perturbation_times <- length(drug_perturbation_times)
      for (t in 1:tot_drug_perturbation_times) {
        dgrpLogger$log(sprintf("start computation by drug perturbation time: %sh", drug_perturbation_times[t]))
        metadata <- private$metadataSetuper$setup(drug_perturbation_times[t], drugs_filter)
        for (i in 1:tot_genes) {
          filename <- paste0(private$output_DGE_dir, gene_list[i], "_", drug_perturbation_times[t], "h.Rds")
          if (private$skip_already_computed_genes & file.exists(filename)) {
            dgrpLogger$log(sprintf("skipping gene %s, perturbation time hours: %s", gene_list[i], drug_perturbation_times[t]))
          }else {
            rna_data_metadata <- private$geneRNADataLoader$load(gene_list[i], metadata)
            dge <- private$lmmDGEByGene$compute(rna_data_metadata, gene_list[i], "drug")
            saveRDS(dge, file = filename)
          }
        }
        dgrpLogger$log(sprintf("end computation by drug perturbation time: %sh", drug_perturbation_times[t]))
      }
      return(NA)
    }
  ),
  private = list(
    metadataSetuper = NA,
    geneRNADataLoader = NA,
    lmmDGEByGene = NA,
    geneIdToSymbolConverter = NA,
    output_DGE_dir = NA,
    skip_already_computed_genes = NA
  )
)
