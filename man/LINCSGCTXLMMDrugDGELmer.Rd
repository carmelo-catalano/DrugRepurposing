\name{LINCSGCTXLMMDrugDGELmer}
\alias{LINCSGCTXLMMDrugDGELmer}
\title{Computes the Differential Gene Expression (DGE) for a specified gene list and drug set from the LINCS database}
\description{
Computes Differential Gene Expression (\link{DGE}) for a specified gene list and drug set from the \link{LINCS} database.
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
The Linear Mixed Model (LMM) is computed using the \code{lmer} function.
}
\usage{
lincsGCTXLMMDrugDGELmer <- LINCSGCTXLMMDrugDGELmer$new(gctx_archive_filename, output_DGE_dir, skip_already_computed_genes)
lincsGCTXLMMDrugDGELmer$compute(drug_perturbation_times, gene_list, drugs_filter)
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
    List of drug names. If not specified, all drugs are exported; otherwise, only the drugs listed in \code{drugs_filter} are exported.
    \itemize{
      \item Type: \code{string vector}.
      \item Default value: \code{NA}.
    }
  }
  \item{gctx_archive_filename (constructor argument)}{
    The full file path of the GCTX LINCS archive GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx.
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
Set of data frames saved as Rds files. Columns: \code{drug}, \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}. The file name is composed of \code{gene_id} and \code{perturbation_time}, e.g., \code{780_6h.Rds}.
\code{lmer} does not return a p-value. Therefore, when LMM is computed using \code{lmer}, the fields \code{p.value} and \code{adj.p.value} are not included.
}
\examples{
gene_list <- "780"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
drug_perturbation_times <- "6"
gctx_archive_filename <- "GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"
output_DGE_dir <- "/home/user/dge"
skip_already_computed_genes <- TRUE

lincsGCTXLMMDrugDGELmer <- LINCSGCTXLMMDrugDGELmer$new(gctx_archive_filename, output_DGE_dir, skip_already_computed_genes)
lincsGCTXLMMDrugDGELmer$compute(drug_perturbation_times, gene_list, drugs_filter)
# Output example:
# drug               gene_id   DE_log2_FC    std.error   t.value
# AM-251             780       -0.00983581   0.06666298  -0.1475453
# AM-404             780        0.04360393   0.07309336   0.5965512
# AM-580             780        0.03516204   0.04044605   0.8693566
# aminoglutethimide  780       -0.15632558   0.05934421  -2.6342179
# aminopurvalanol-a  780        0.04617297   0.09279416   0.4975849
}
