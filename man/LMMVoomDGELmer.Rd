\name{LMMVoomDGELmer}
\alias{LMMVoomDGELmer}
\title{Differential gene expression analysis using Voom and the lmer function}
\description{
Derived class of \code{LMMVoomDGEAbstract}.
\cr
This class computes the Voom Linear Mixed Model (LMM) differential gene expression (DGE) analysis using the \code{lmer} function from the \code{lme4} package.
\cr
It relies on three collaborators: \code{LMMVoom}, \code{LMMLmerToDataFrameMapper}, and \code{GeneFilterByProteinCoding}.
}
\usage{
lmmVoomDGELmer <- LMMVoomDGELmer$new()
lmmVoomDGELmer$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding)
}
\arguments{
  Same as in LMMVoomDGEAbstract
}
\value{
Data frame. Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}.
\cr
The lmer function does not return \code{p.value} and \code{adj.p.value}.
}
\examples{
rna_seq_data <- data.frame(
  GeneID = c(1, 2, 3, 9, 10, 11, 12, 13),
  GSM1 = c(262, 281897, 463, 12301, 284, 2966, 4842, 9966),
  GSM2 = c(116, 337026, 261, 3277, 132, 2006, 3699, 12406),
  GSM3 = c(111, 111736, 193, 862, 88, 1371, 2536, 1531),
  GSM4 = c(162, 219471, 281, 5990, 280, 2241, 4527, 12941)
)

# rna_seq_data =
# GeneID   GSM1        GSM2        GSM3        GSM4
# 1        262         116         111         162
# 2        281897      337026      111736      219471
# 3        463         261         193         281
# 9        12301       3277        862         5990
# 10       284         132         88          280
# 11       2966        2006        1371        2241
# 12       4842        3699        2536        4527
# 13       9966        12406       1531        12941

rna_seq_metadata <- data.frame(
  accession = c("GSM1", "GSM2", "GSM3", "GSM4", "GSM5", "GSM6", "GSM7"),
  tissue = c("Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar",
             "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Cerebellum", "Cerebellum"),
  subject_id = c("NEUEL133AK6", "NEUYV496XLP", "NEUZU200WEQ", "NEUEC006FND",
                 "NEUKM699KKH", "NEUJZ255ZC5", "NEUJZ233ZL3"),
  tissue_status = c("ALS Spectrum MND", "ALS Spectrum MND", "ALS Spectrum MND",
                    "Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND",
                    "Non-Neurological Control")
)

# rna_seq_metadata =
# accession   tissue                  subject_id     tissue_status
# GSM1        Spinal Cord Lumbar      NEUEL133AK6    ALS Spectrum MND
# GSM2        Spinal Cord Lumbar      NEUYV496XLP    ALS Spectrum MND
# GSM3        Spinal Cord Lumbar      NEUZU200WEQ    ALS Spectrum MND
# GSM4        Spinal Cord Lumbar      NEUEC006FND    Non-Neurological Control
# GSM5        Spinal Cord Lumbar      NEUKM699KKH    ALS Spectrum MND
# GSM6        Cerebellum              NEUJZ255ZC5    ALS Spectrum MND
# GSM7        Cerebellum              NEUJZ233ZL3    Non-Neurological Control

formula <- ~ tissue_status + (1 | tissue)
filter_by_protein_coding <- FALSE
lmmVoomDGELmer <- LMMVoomDGELmer$new()
lmmVoomDGELmer$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding)

# output =
# gene_id     DE_log2_FC      std.error     t.value
# 1           -0.321702363    0.03258202    -9.8736176
# 2            0.098826802    0.03881487     2.5461068
# 3            0.119901268    0.01790788     6.6954476
# 9            0.212847196    0.02130842     0.9988878
# 10           0.139504124    0.02262193     6.1667660
# 11           0.358180918    0.04318577     0.8293958
# 12          -0.393621149    0.04513504    -8.7209655
# 13          -0.198810185    0.02080423    -0.9556273

}
