\name{LMMVoomDGEDreamWithEBayes}
\alias{LMMVoomDGEDreamWithEBayes}
\title{Differential gene expression analysis using Voom and the dream function}
\description{
Derived class of \code{LMMVoomDGEAbstract}.
\cr
This class computes the Voom Linear Mixed Model (LMM) differential gene expression (DGE) analysis using the \code{dream} function from the \code{variancePartition} package.
\cr
After the \code{dream} computation is completed "Empirical Bayes Statistics for Differential Expression"
are applied (\code{variancePartition::eBayes}).
\cr
It relies on three collaborators: \code{LMMVoom}, \code{DGEMapper}, and \code{GeneFilterByProteinCoding}.
}
\usage{
lmmVoomDGEDreamWithEBayes <- LMMVoomDGEDreamWithEBayes$new()
lmmVoomDGEDreamWithEBayes$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding)
}
\arguments{
  Same as in LMMVoomDGEAbstract
}
\value{
Data frame. Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
}
\examples{
rna_seq_data <- data.frame(
  GSM1 = c(262, 281897, 463, 12301, 284, 2966, 4842, 9966),
  GSM2 = c(116, 337026, 261, 3277, 132, 2006, 3699, 12406),
  GSM3 = c(111, 111736, 193, 862, 88, 1371, 2536, 1531),
  GSM4 = c(162, 219471, 281, 5990, 280, 2241, 4527, 12941),
  GSM5 = c(82, 471, 981, 590, 380, 241, 427, 941),
  GSM6 = c(92, 9471, 201, 1990, 80, 41, 1527, 2941),
  GSM7 = c(192, 2191, 181, 3990, 480, 1241, 7527, 1941)
)
rownames(rna_seq_data) <- c(1, 2, 3, 9, 10, 11, 12, 13) # gene id

# rna_seq_data =
#      GSM1     GSM2      GSM3     GSM4     GSM5   GSM6   GSM7
# 2    262      116       111      162      82     92     192
# 2    281897   337026    111736   219471   471    9471   2191
# 3    463      261       193      281      981    201    181
# 9    12301    3277      862      5990     590    1990   3990
# 10   284      132       88       280      380    80     480
# 11   2966     2006      1371     2241     241    41     1241
# 12   4842     3699      2536     4527     427    1527   7527
# 13   9966     12406     1531     12941    941    2941   1941

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

formula <- ~tissue_status + (1 | tissue)
filter_by_protein_coding <- FALSE
lmmVoomDGEDream <- LMMVoomDGEDream$new()
lmmVoomDGEDream$compute(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding)

# output =
# gene_id   DE_log2_FC     std.error    t.value        p.value        adj.p.value
# 1         -0.01834494    0.9955855    -0.01842629    0.98588122     0.9858812
# 10        0.23978701     1.5852087    0.15126526     0.88595481     0.9858812
# 11        0.26317732     0.7672295    0.34302292     0.74312806     0.9858812
# 12        1.67862741     0.8456856    1.98493071     0.08457899     0.6766319
# 13        -0.50968160    0.7088587    -0.71901720    0.49241408     0.9848282
# 2         -0.80152473    2.7565471    -0.29077128    0.78020948     0.9858812
# 3         -1.51092548    1.9530229    -0.77363431    0.46434111     0.9848282
# 9         0.70537507     0.6113218    1.15385231     0.29354859     0.9848282

}
