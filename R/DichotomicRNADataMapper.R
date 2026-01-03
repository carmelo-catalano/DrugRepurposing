DichotomicRNADataMapper <- R6Class(
  "DichotomicRNADataMapper",
  public = list(
    map = function(rna_seq, sample_01_map) {
      if (obj_is_na_or_NULL(sample_01_map) ||
        class(sample_01_map) != "character" ||
        nchar(sample_01_map) < 2)
        stop("invalid sample map")
      if (gsub('X|0|1', '', sample_01_map) != "" && gsub('X|C|T', '', sample_01_map) != "")
        stop("invalid sample map")
      if (gsub('X|C|T', '', sample_01_map) == "") {
        sample_01_map <- gsub("C", "0", sample_01_map)
        sample_01_map <- gsub("T", "1", sample_01_map)
      }

      # rna_seq = matrix, rownames = gene_id, cols=experiment rna seq (read count)
      # Example, GSM2433098, GSM2433099, ... = colnames;  100287102, 653635, ...= rownames
      # colnames are not used so they are optional
      #     	    GSM2433098	GSM2433099	GSM2433100	GSM2433101	GSM2433102
      # 100287102	7	        4	        6	        7	        12
      # 653635	    817			480			513			497			1055
      # 102466751	30			18			14			20			24
      # 107985730	1			0			0			0			2
      # sample_01_map = 001100X01 => 0 = test sample, 1 = control sample, X = excluded sample
      sample_vector_map <- strsplit(sample_01_map, split = "")[[1]]
      sample_positions <- which(sample_vector_map != "X")
      sample_vector_map <- subset(sample_vector_map, sample_vector_map != "X")
      sample_vector_map[which(sample_vector_map == '0')] <- "Control"
      sample_vector_map[which(sample_vector_map == '1')] <- "TestSample"
      sample_types <- factor(sample_vector_map, levels = c("Control", "TestSample"))
      rna_seq <- rna_seq[, sample_positions]
      return(
        list(
          gene_expressions = rna_seq,
          sample_types = sample_types
        )
      )
    }
  )
)