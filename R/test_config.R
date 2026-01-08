test_config <- list()
test_config$LINCS_splitted_level3_dir <- "unit_test_data/LMMDGE/LINCS_splitted_level3/"
test_config$LINCS_dge_dir <- "unit_test_data/LMMDGE/LINCS_dge/"
test_config$LINCS_dge_output_dir <- "unit_test_data/LMMDGE/LINCS_dge_output/"
test_config$DGEMergeByGene_expected <- "unit_test_data/LMMDGE/DGEMergeByGene_expected/"
test_config$DGEMergeByGene_output <- "unit_test_data/LMMDGE/DGEMergeByGene_output/"
test_config$LINCS_expected_dge_dir <- "unit_test_data/LMMDGE/LINCS_expected_dge/"
test_config$LINCS_expected_parallel_dge_dir <- paste0(test_config$LINCS_expected_dge_dir, "/parallel-computation/")
test_config$LINCS_GTX_tests_enabled <- FALSE