library(DrugRepurposing)
acamprosate_rna_seq_filename <- "https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE213380&file=GSE213380_raw_counts_GRCh38.p13_NCBI.tsv.gz"

# In drug analysis, the "vehicle" corresponds to the "control".
acamprosate_sample_01_map <- "XX0011XX0011XXX011XXX0011X0011XX00"

geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()

acamprosateDGE <- geoRNASeqDichotomicVoomDGE$compute(
  acamprosate_rna_seq_filename, acamprosate_sample_01_map, filter_by_protein_coding = FALSE
)

drugs_genes <- acamprosateDGE$gene_id

acamprosate <- acamprosateDGE[, c("gene_id", "t.value")]
colnames(acamprosate)[2] <- "estimate"

drugs_rna_data <- list()
drugs_rna_data[["acamprosate"]] <- acamprosate

drugs <- data.frame(
  name = c("acamprosate"),
  filename = c("acamprosate")
)

als_rna_seq_filename <- "https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE67196&file=GSE67196_raw_counts_GRCh38.p13_NCBI.tsv.gz"

tissue_status <- c("ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS",
                   "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS",
                   "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS", "ALS",
                   "Control", "Control", "Control", "Control", "Control", "Control", "Control",
                   "Control", "Control", "Control", "Control", "Control", "Control", "Control",
                   "Control", "Control", "Control")

tissue_status_factor <- factor(tissue_status, levels = c("Control", "ALS"))

als_rna_seq_metadata <- data.frame(
  sample_id = c("GSM1642278", "GSM1642279", "GSM1642280", "GSM1642281", "GSM1642282",
                "GSM1642283", "GSM1642284", "GSM1642285", "GSM1642286", "GSM1642287",
                "GSM1642288", "GSM1642289", "GSM1642290", "GSM1642291", "GSM1642292",
                "GSM1642293", "GSM1642294", "GSM1642295", "GSM1642296", "GSM1642297",
                "GSM1642298", "GSM1642299", "GSM1642300", "GSM1642301", "GSM1642302",
                "GSM1642303", "GSM1642304", "GSM1642305", "GSM1642306", "GSM1642307",
                "GSM1642308", "GSM1642309", "GSM1642310", "GSM1642311", "GSM1642312",
                "GSM1642313", "GSM1642314", "GSM1642315", "GSM1642316", "GSM1642317",
                "GSM1642318", "GSM1642319", "GSM1642320", "GSM1642321", "GSM1642322",
                "GSM1642323", "GSM1642324", "GSM1642325", "GSM1642326", "GSM1642327",
                "GSM1642328", "GSM1642329", "GSM1642330"),
  tissue_status = tissue_status_factor,
  tissue = c("Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum",
             "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex",
             "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum",
             "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex",
             "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum",
             "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex",
             "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum",
             "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex",
             "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum",
             "Frontal Cortex", "Cerebellum", "Frontal Cortex", "Cerebellum", "Frontal Cortex",
             "Cerebellum", "Frontal Cortex", "Frontal Cortex"),
  genotype = c("c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "c9ALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "sALS", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy", "Healthy")
)


EasyDrugSignatureLoader <- R6Class(
  "EasyDrugSignatureLoader",
  inherit = DrugSignatureLoaderAbstract,
  public = list(
    initialize = function(drugs_rna_data) {
      private$drugs_rna_data <- drugs_rna_data
    },
    load = function(drug_name) {
      return(private$drugs_rna_data[[drug_name]])
    }
  ),
  private = list(
    drugs_rna_data = NA
  )
)

easyDrugSignatureLoader <- EasyDrugSignatureLoader$new(drugs_rna_data)
# To sped up the computation, replace GEORNASeqLMMVoomDGEDream with GEORNASeqLMMVoomDGEJulia
# To use GEORNASeqLMMVoomDGEJulia, the Julia environment must be installed on your system.
# To apply eBayes to differential gene expression, replace GEORNASeqLMMVoomDGEDream with GEORNASeqLMMVoomDGEDreamWithEBayes
geoRNASeqLMMVoomDGE <- GEORNASeqLMMVoomDGEDream$new()
geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqLMMVoomDrugRepurpose$new(
  geoRNASeqLMMVoomDGE = geoRNASeqLMMVoomDGE,
  drugSignatureLoader = easyDrugSignatureLoader
)

result <- geoRNASeqLMMVoomDrugRepurpose$compute(
  rna_seq_data_filename = als_rna_seq_filename,
  rna_seq_metadata = als_rna_seq_metadata,
  formula = ~tissue_status + (1 | tissue) + (1 | genotype),
  drugs = drugs,
  drugs_genes = drugs_genes,
  random_distribution_size = 10^5,
  disease_name = "ALS",
  parallel_computation = FALSE,
  filter_by_protein_coding = FALSE,
  signature_mapper_parameter = 150
)
