DichotomicDGEAbstract <- R6Class(
  "DichotomicDGEAbstract",
  public = list(
    compute = function(rna_data, sample_01_map, test_sample_name, filter_by_protein_coding = F) {
      stop("I'm an abstract method, please implement me")
    }
  )
)
