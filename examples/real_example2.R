library(DrugRepurposing)
thyroyd_tumor_rna_seq_filename <- "https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE126698&file=GSE126698_raw_counts_GRCh38.p13_NCBI.tsv.gz"

thyroyd_tumor_sample_01_map <- "1111111111111111000000111111"

geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()

thyroyd_tumorDGE <- geoRNASeqDichotomicVoomDGE$compute(
  thyroyd_tumor_rna_seq_filename, thyroyd_tumor_sample_01_map, filter_by_protein_coding = FALSE
)

drugs_genes <- thyroyd_tumorDGE$gene_id

thyroyd_tumor <- thyroyd_tumorDGE[, c("gene_id", "t.value")]
colnames(thyroyd_tumor)[2] <- "estimate"


drugs <- data.frame(
  name = c("sorafenib","fluoxetine","flupentixol","fluperlapine"),
  filename = c("examples/drugs/sorafenib.Rds","examples/drugs/fluoxetine.Rds",
               "examples/drugs/flupentixol.Rds","examples/drugs/fluperlapine.Rds")
)

geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqDichotomicVoomDrugRepurpose$new()
sorafenib <- readRDS("examples/drugs/sorafenib.Rds")
drugs_genes <- sorafenib$gene_id

result <- geoRNASeqLMMVoomDrugRepurpose$compute(
  rna_seq_filename = thyroyd_tumor_rna_seq_filename,
  sample_01_map = thyroyd_tumor_sample_01_map,
  drugs = drugs,
  drugs_genes = drugs_genes,
  random_distribution_size = 10^5,
  disease_name = "thyroyd tumor",
  parallel_computation = TRUE,
  signature_mapper_parameter = 150
)
