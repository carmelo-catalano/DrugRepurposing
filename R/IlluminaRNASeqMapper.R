library(R6)
# source("modules/disease_signature/SamplesGroups.R")

IlluminaRNASeqMapper <- R6Class(
  "IlluminaRNASeqMapper",
  public = list(
    initialize = function(geneFilter) {
      if (!"GeneFilterAbstract" %in% class(geneFilter))
        stop("the geneFilter instance must by of type GeneFilter")
      private$samplesGroups <- SamplesGroups$new()
      private$geneFilter <- geneFilter
    },
    map = function(rna_seq_filename, samples_groups_map, disease_name) {
      gene_expressions <- as.matrix(data.table::fread(rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
      samples_groups <- private$samplesGroups$groups(samples_groups_map, disease_name)
      gene_expressions <- gene_expressions[, samples_groups$sample_groups_idxes]
      gene_expressions <- private$geneFilter$filter(gene_expressions, samples_groups$disease_control_groups)
      return(
        list(
          gene_expressions = gene_expressions,
          disease_control_groups = samples_groups$disease_control_groups
        )
      )
    }
  ),
  private = list(
    samplesGroups = NA,
    geneFilter = NA
  )
)