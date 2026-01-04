config <- list()
config$package_name <- "DrugRepurposing"
config$protein_coding_gene_filename <- "extdata/protein_coding_gene.Rds"

config$gene_set_base_path <- "extdata/gene_sets/"
config$gene_set_filename_suffix <- "_gene_set.Rds"
config$gene_set_Human_GRCh38.p13 <- "Human_GRCh38.p13"
config$gene_set_LINCS <- "LINCS"
config$gene_set_hgnc <- "hgnc"
config$protein_coding_genes_filename <- "extdata/protein_coding_genes.Rds"
config$LINCS_metadata_RDS_filename <- NA # "extdata/GSE92742_Broad_LINCS_inst_info.Rds"
config$LINCS_gtx_database <- NA #"/Users/carmelocatalano/r-projects/tsr-system/data/LINCS-GSE92742/GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"
config$LINCSLMMFormula <- gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)
