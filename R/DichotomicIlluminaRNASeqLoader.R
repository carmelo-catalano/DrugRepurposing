library(R6)

DicotomicIlluminaRNASeqLoader <- R6Class(
  "DicotomicIlluminaRNASeqLoader",
  public = list(
    initialize = function(geneFilter) {
      if (!"GeneFilterAbstract" %in% class(geneFilter))
        stop("the geneFilter instance must by of type GeneFilter")
      private$rnaSeqSampleMapBuilder <- RnaSeqSampleMapBuilder$new()
      private$geneFilter <- geneFilter
    },
    load = function(rna_seq_filename, sample_01_map, test_sample) {
      gene_expressions <- as.matrix(data.table::fread(rna_seq_filename, header = T, colClasses = "integer"), rownames = "GeneID")
      rnaSeqSampleMap <- private$rnaSeqSampleMapBuilder$build(sample_01_map, test_sample)
      gene_expressions <- gene_expressions[, rnaSeqSampleMap$sample_positions]
      gene_expressions <- private$geneFilter$filter(gene_expressions, rnaSeqSampleMap$samples)
      return(
        list(
          gene_expressions = gene_expressions,
          sample_types = rnaSeqSampleMap$samples
        )
      )
    }
  ),
  private = list(
    rnaSeqSampleMapBuilder = NA,
    geneFilter = NA
  )
)