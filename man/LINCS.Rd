\name{LINCS}
\alias{LINCS}
\title{LINCS}
\description{
The Common Fund’s Library of Integrated Network-based Cellular Signatures (LINCS [1]).
\cr
The LINCS data are downloaded from \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE92742}.
\cr
This package provides functions to analyze level 3 data. Level 3 contains RNA analysis
of cancer tissue treated with drugs and control vehicles (DMSO).
\cr
Due to the structure of the LINCS database, differential gene expression analysis is performed
for multiple drugs against a single gene.
\cr
The LINCS classes use a Linear Mixed Model with the formula: \code{gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}
(the fixed effect \code{pert_iname} corresponds to the drug name) to compute the \link{DGE}.
\cr
With this configuration, the DGE is computed for each input drug.
\cr
Level 3 data used are:
\cr
\cr
\bold{extdata/LINCS_gene_info.Rds (extracted from GSE92742_Broad_LINCS_gene_info.txt)}
\cr
Gene information.
\cr
\itemize{
  \item gene_id: gene id
  \item gene_symbol: gene symbol
  \item lincs_gene_symbol: gene symbol in LINCS database
  \item gene_full_name: gene full name
  \item is_landmark_gene: indicates whether the gene is a LINCS landmark gene
  \item is_best_inferred_gene: indicates whether the gene is well inferred
}

See example below.
\cr
\cr

\bold{GSE92742_Broad_LINCS_inst_info.Rds (extracted from GSE92742_Broad_LINCS_inst_info.txt)}
\cr
RNA analysis metadata.
\itemize{
  \item inst_id: sample id
  \item rna_plate: rna plate
  \item rna_well: rna well
  \item pert_id: id of the perturbagen
  \item pert_iname: standardized name of the perturbagen (e.g., drug name)
  \item pert_type: category of the perturbation, such as "trt_cp" (chemical treatment) or "ctl_vehicle" (control samples, typically DMSO).
  \item pert_dose: concentration of the treatment
  \item pert_time: duration of the cellular exposure to the perturbagen (e.g., 6h, 24h, 48h)
  \item cell_id: name of the specific cell line used in the assay (e.g., MCF7, PC3, VCAP)
}

See example below.
\cr
\cr

\bold{GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx (not provided with package)}
\cr
RNA expression data.
\cr
For each row in the table GSE92742_Broad_LINCS_inst_info.txt, there is a corresponding column in
GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx. The column name matches the
\code{inst_id} column in GSE92742_Broad_LINCS_inst_info.txt.
\cr
The table contains only one row, which represents the gene expression level.
\cr
Data follow the "normal distribution".
\cr
See example below.
\cr
\cr
}
\section{References}{
    \itemize{
        \item 1.	Subramanian et al. A Next Generation Connectivity Map: L1000 Platform and the First 1,000,000 Profiles. Cell 2017.
    }
\cr
}
\value{NA}
\examples{
LINCS_gene_info
# gene_id   gene_symbol   lincs_gene_symbol   gene_full_name    is_landmark_gene   is_best_inferred_gene
# ------------------------------------------------------------------------------------------------------
# 7849      PAX8          PAX8                paired box 8      1                  1
# 2049      EPHB3         EPHB3               EPH receptor B3   0                  1
# 11335     CBX3          CBX3                chromobox 3       0                  1


GSE92742_Broad_LINCS_inst_info
# inst_id                                 rna_plate            rna_well   pert_id         pert_iname        pert_type     pert_dose   pert_time   cell_id
# -------------------------------------------------------------------------------------------------------------------------------------------------------
# ASG001_MCF7_24H_X1_B7_DUO52HI53LO:P21   ASG001_MCF7_24H_X1   P21        DMSO            DMSO              ctl_vehicle   0.1         24          MCF7
# ASG001_MCF7_24H_X1_B7_DUO52HI53LO:P22   ASG001_MCF7_24H_X1   P22        DMSO            DMSO              ctl_vehicle   0.1         24          MCF7
# ASG001_MCF7_24H_X1_B7_DUO52HI53LO:A06   ASG001_MCF7_24H_X1   A06        BRD-A60070924   alpha-estradiol   trt_cp        10          24          MCF7
# ASG001_MCF7_24H_X1_B7_DUO52HI53LO:E06   ASG001_MCF7_24H_X1   E06        BRD-A60070924   alpha-estradiol   trt_cp        10          24          MCF7


GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx
# ASG001_MCF7_24H_X1_B7_DUO52HI53LO:P21   ASG001_MCF7_24H_X1_B7_DUO52HI53LO:P22  ASG001_MCF7_24H_X1_B7_DUO52HI53LO:A06   ASG001_MCF7_24H_X1_B7_DUO52HI53LO:E06
# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# 9.178                                   9.4127                                  9.2043                                 9.3412

}
