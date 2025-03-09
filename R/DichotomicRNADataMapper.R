DichotomicRNADataMapper <- R6Class(
  "DichotomicRNADataMapper",
  public = list(
    initialize = function() {
      private$rnaSeqSampleMapBuilder <- RnaSeqSampleMapBuilder$new()
    },
    map = function(rna_seq, sample_01_map, test_sample_name) {
      # rna_seq = matrix, rownames = gene_id, cols=experiment rna seq (read count)
      # Example, GSM2433098, GSM2433099, ... = colnames;  100287102, 653635, ...= rownames
      # colnames are not used so they are optional
      #     	    GSM2433098	GSM2433099	GSM2433100	GSM2433101	GSM2433102
      # 100287102	7	        4	        6	        7	        12
      # 653635	    817			480			513			497			1055
      # 102466751	30			18			14			20			24
      # 107985730	1			0			0			0			2
      rnaSeqSampleMap <- private$rnaSeqSampleMapBuilder$build(sample_01_map, test_sample_name)
      rna_seq <- rna_seq[, rnaSeqSampleMap$sample_positions]
      return(
        list(
          gene_expressions = rna_seq,
          sample_types = rnaSeqSampleMap$sample_types
        )
      )
    }
  ),
  private = list(
    rnaSeqSampleMapBuilder = NA,
    geneFilter = NA
  )
)