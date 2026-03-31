\name{LINCSRDSLMMDrugDGEJulia}
\alias{LINCSRDSLMMDrugDGEJulia}
\title{Calculate the differential gene expression (DGE) for a gene list and drug list from the LINCS database}
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
The core component of this class is \code{\link{LINCSLMMDrugDGE}}.
\cr
The DGE computation is based on a Linear Mixed Model (LMM), which is computed using the Julia environment.
\cr
To use this function, the Julia environment must be installed on the system.
}
\usage{
lincsRDSLMMDrugDGEJulia <- LINCSRDSLMMDrugDGEJulia$new(lincs_splitted_level3_dir, output_DGE_dir, BLAS_num_threads, skip_already_computed_genes)
lincsRDSLMMDrugDGEJulia$compute(drug_perturbation_times, gene_list, drugs_filter)
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
  \item{BLAS_num_threads (constructor argument)}{
    Threads number for parallel computation through \code{Julia} \code{LinearAlgebra.BLAS} module.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{processorCores$getJuliaCores()}.
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
}
\examples{
drug_perturbation_times <- "6"
gene_list <- "780"
drugs_filter <- c("AM-251", "AM-404", "AM-580", "aminoglutethimide", "aminopurvalanol-a")
lincs_splitted_level3_dir <- "/home/user/lincs"
output_DGE_dir <- "home/user/dge"
BLAS_num_threads <- 5
skip_already_computed_genes <- T
lincsRDSLMMDrugDGEJulia <- LINCSRDSLMMDrugDGEJulia$new(lincs_splitted_level3_dir, output_DGE_dir, BLAS_num_threads, skip_already_computed_genes)
lincsRDSLMMDrugDGEJulia$compute(drug_perturbation_times, gene_list, drugs_filter)

# Rds file content example:
# drug               gene_id   DE_log2_FC   std.error   t.value   p.value   adj.p.value
# -------------------------------------------------------------------------------------
# AM-251             780       -0.047038    0.073635    -0.639    0.523     0.653
# AM-404             780       -0.199576    0.071673    -2.785    0.00536   0.0268
# AM-580             780        0.051221    0.055126     0.929    0.353     0.588
# aminoglutethimide  780        0.004159    0.070087     0.0593   0.953     0.953
# aminopurvalanol-a  780        0.088157    0.092338     0.955    0.340     0.588
}
