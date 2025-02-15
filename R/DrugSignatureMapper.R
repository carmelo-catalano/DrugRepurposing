DrugSignatureMapper <- R6Class(
  "DrugSignatureMapper",
  public = list(
    map = function(drug_signature, t_value_column_name) {
      drug_signature <- drug_signature[, c("gene_id", t_value_column_name), drop = F]
      colnames(drug_signature)[2] <- "estimate"
      return(drug_signature)
    }
  )
)