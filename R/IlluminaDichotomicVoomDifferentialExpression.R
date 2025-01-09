library(R6)

# source("modules/obj_is_na.R")
# source("modules/disease_signature/Illumina_HiSeq_mapper/IlluminaHiSeqMapper.R")
# source("modules/disease_signature/filter/LowCountsGeneFilter.R")
# source("modules/disease_signature/DiseaseSignature.R")

IlluminaDichotomicVoomDifferentialExpression <- R6Class(
  "IlluminaDichotomicVoomDifferentialExpression",
  public = list(
    initialize = function(geneFilter = NA) {
      private$dichotomicVoomDifferentialExpression <- DichotomicVoomDifferentialExpression$new()
      if (obj_is_na(geneFilter)) {
        geneFilter <- LowCountsGeneFilter$new()
      }
      private$illuminaRNASeqMapper <- IlluminaRNASeqMapper$new(geneFilter)
      private$geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
    },
    compute = function(rna_seq_filename, samples_groups_map, disease_name, filter_by_protein_coding = F) {
      startTime <- Sys.time()
      dgrpLogger$log(sprintf("start %s signature computation", disease_name))
      gene_experiments_data <- private$illuminaRNASeqMapper$map(rna_seq_filename, samples_groups_map, disease_name)
      if (filter_by_protein_coding) {
        gene_experiments_data$gene_expressions <- private$geneFilterByProteinCoding$filterById(gene_experiments_data$gene_expressions)
      }
      signature <- private$dichotomicVoomDifferentialExpression$compute(gene_experiments_data)
      totalTime <- Sys.time() - startTime
      dgrpLogger$log(sprintf("end %s signature computation, time: %s %s", disease_name, totalTime, attr(totalTime, "units")))
      return(signature)
    }
  ),
  private = list(
    dichotomicVoomDifferentialExpression = NA,
    illuminaRNASeqMapper = NA,
    geneFilterByProteinCoding = NA
  )
)
