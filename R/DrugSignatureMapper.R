DrugSignatureMapper <- R6Class(
  "DrugSignatureMapper",
  public = list(
    map = function(drug_dge, t_value_column_name) {
      drug_signature <- drug_dge[, c("gene_id", t_value_column_name), drop = FALSE]
      colnames(drug_signature)[2] <- "estimate"
      return(drug_signature)
    }
  )
)