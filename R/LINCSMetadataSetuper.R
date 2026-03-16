LINCSMetadataSetuper <- R6Class(
  "LINCSMetadataSetuper",
  inherit = LINCSMetadataSetuperAbstract,
  public = list(
    setup = function(drug_perturbation_times, drugs_filter = NA) {
      # "data/LINCS/GSE92742_Broad_LINCS_inst_info.txt"
      # experiment = instance
      raw_metadata <- readRDS(LINCS_metadata_RDS_filename())[, c("inst_id", "rna_plate", "pert_id", "pert_iname", "pert_type", "pert_dose", "pert_time", "cell_id")]

      metadata <- subset(raw_metadata,
                         pert_type == "trt_cp" &
                           pert_dose == 10 &
                           pert_time %in% drug_perturbation_times
      )

      # calculate the frequency of cell lines per drug
      cell_lines_per_drug_freq <- as.data.frame(table(unique(metadata[, c("cell_id", "pert_iname")])$pert_iname), stringsAsFactors = FALSE)
      # exclude cell lines that appear with a frequency of less than 5
      cell_lines_per_drug_freq <- cell_lines_per_drug_freq[cell_lines_per_drug_freq$Freq >= 5,]

      drugs <- unique(cell_lines_per_drug_freq$Var1)

      if (!obj_is_na(drugs_filter)) {
        drugs <- drugs[drugs %in% drugs_filter]
      }
      # exclude experiments with drugs not in \code{drug_names}.
      metadata <- metadata[metadata$pert_iname %in% drugs,]
      # estrae tutti gli esperimenti eseguiti sulle stesse piastre in metadata
      raw_metadata <- raw_metadata[raw_metadata$rna_plate %in% unique(metadata$rna_plate),]

      # add the control vehicle
      metadata <- rbind(metadata, raw_metadata[raw_metadata$pert_type == "ctl_vehicle" & raw_metadata$pert_time %in% drug_perturbation_times,])

      # the following two lines ensure that DMSO is set as the first level of the factor.
      # The first element is treated as the reference gene expression level for
      # calculating the log2 fold change.
      drugs <- c("DMSO", drugs[drugs != "DMSO"])
      metadata$pert_iname <- factor(metadata$pert_iname, levels = drugs)
      #drug_names <- unique(metadata$pert_iname)
      #drug_names <- c("DMSO",drug_names[drug_names != "DMSO"])
      #metadata$pert_iname <- factor(metadata$pert_iname, levels = drug_names)
      metadata <- metadata[, c("inst_id", "rna_plate", "pert_id", "pert_iname", "pert_time", "cell_id")]
      metadata <- metadata[order(metadata$inst_id),]
      return(metadata)
    }
  )
)