\name{LINCSRDSLMMDrugDGELmer}
\alias{LINCSRDSLMMDrugDGELmer}
\title{Calculate the differential gene expression (DGE) for a gene list and drug list from the LINCS database}
\description{
Computes Differential Gene Expression (\link{DGE}) for a specified gene list and drug set from the LINCS database.
\cr
For each gene and perturbation time, an output file (Rds format) is generated containing the DGE computed between
 the gene and the drugs at that specific perturbation time.
\cr
The output file is named according to the following schema: "geneID"_"drug_perturbation_time".Rds.
\cr
The data are loaded from the LINCS archive GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx.
The associated metadata (extracted from GSE92742_Broad_LINCS_inst_info.txt) are loaded using
the \code{\link{LINCSMetadataSetuper}} class.
\cr
The core component of this class is \code{\link{LINCSLMMDrugDGE}}.
\cr
The DGE computation is based on a Linear Mixed Model (LMM), which is computed using the \code{lmer} from \code{lme4}.
\cr
}
\usage{
LINCSRDSLMMDrugDGELmer <- LINCSRDSLMMDrugDGELmer$new(lincs_splitted_level3_dir, output_DGE_dir, skip_already_computed_genes)
LINCSRDSLMMDrugDGELmer$compute(drug_perturbation_times, gene_list, drugs_filter)
}
\arguments{
  \item{drug_perturbation_times}{
    List of drug perturbation times.
    Drug perturbation time is the duration for which the sample is treated with the drug.
    \itemize{
      \item Type: \code{character vector}.
    }
  }
  \item{gene_list}{
    List of genes used for DGE computation.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{drugs_filter}{
    List of drugs for which the DGE will be computed.
    \itemize{
      \item Type: \code{vector}.
      \item Default value: \code{NA}.
    }
  }
  \item{lincs_splitted_level3_dir (constructor argument)}{
    Folder containing the RDS files exported from LINCS archive.
    Each file contains RNA data for a specific gene_id, and its name corresponds to the gene_id.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{output_DGE_dir (constructor argument)}{
    The output directory where output DGE files are saved.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{skip_already_computed_genes (constructor argument)}{
    If set to \code{TRUE}, the \link{DGE} computation will be skipped for genes whose output file already exists.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
}
\value{
Set of data frame saved as Rds files.
Columns: \code{drug, gene_id, DE_log2_FC, std.error, t.value, p.value, adj.p.value}.
\cr
Lmer does not return a p-value. Therefore, when LMM is computed using lmer, the fields p.value and adj.p.value are not included.
}
\examples{
drug_perturbation_times <- "6"
gene_list <- "780"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
lincs_splitted_level3_dir <- "/home/user/lincs"
output_DGE_dir <- "/home/user/dge"
skip_already_computed_genes <- TRUE
LINCSRDSLMMDrugDGELmer <- LINCSRDSLMMDrugDGELmer$new(lincs_splitted_level3_dir, output_DGE_dir, skip_already_computed_genes)
LINCSRDSLMMDrugDGELmer$compute(drug_perturbation_times, gene_list, drugs_filter)

# Rds file content example:
# drug               gene_id   DE_log2_FC    std.error    t.value
# -----------------------------------------------------------------
# AM-251             780       -0.00983581   0.06666298  -0.1475453
# AM-404             780        0.04360393   0.07309336   0.5965512
# AM-580             780        0.03516204   0.04044605   0.8693566
# aminoglutethimide  780       -0.15632558   0.05934421  -2.6342179
# aminopurvalanol-a  780        0.04617297   0.09279416   0.4975849
}
