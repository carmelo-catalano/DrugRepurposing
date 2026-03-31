\name{LMMDGEJulia}
\alias{LMMDGEJulia}
\title{Computes differential gene expression analysis using the Linear Mixed Model (LMM)}
\description{
Computes differential gene expression analysis using the Linear Mixed Model (LMM).
\cr
The LMM computation is performed using the high-performance \code{Julia} environment.
Julia-based LMM computation is up to 100 times faster than \code{lmer} and \code{dream} computation.
\cr
The LMM computation is performed using the high-performance Julia environment.
\cr
The input consists of two groups of RNA data analysis from tissues under different conditions: control/altered state. For example, a disease-affected group and a control group.
\cr
Unlike the dichotomous case, where groups are divided only into "control/altered state", additional conditions exist under which the experiments were conducted. For instance, multiple RNA plates were used, or tissues originated from different parts of the body.
\cr
RNA data must follow "normal distribution", which is typical for RNA microarray analysis.
\cr
For RNA data following a "negative binomial distribution", refer to \code{\link{LMMVoomDGEDream}}, \code{\link{LMMVoomDGEJulia}}, or \code{\link{LMMVoomDGELmer}}.
\cr
To use this class, the Julia environment must be installed on the system.
}
\usage{
lmmDGEJulia <- LMMDGEJulia$new()
lmmDGEJulia$compute(rna_data, rna_metadata, formula, filter_by_protein_coding)
}
\arguments{
  Same as in \code{LMMDGEAbstract}
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\code{DE_log2_FC} = differential expression = log2 Fold Change.
\cr
See \link{DGE} for additional details.
}
\examples{
rna_data <- matrix(
  c(
    6.930737, 6.643856, 5.247928, 7.169925, 7.303781, 6.375039, 6.108524, 7.055282,
    6.554589, 6.741467, 7.721099, 6.247928, 7.139551, 6.569856, 5.554589, 6.392317,
    6.643856, 5.392317, 7.348728, 7.491853, 6.044394, 5.700440, 6.169925, 5.247928,
    5.954196, 6.672425, 6.614710, 5.169925, 6.988685, 7.357552, 6.954196, 6.285402,
    6.539159, 6.727920, 6.845490, 7.592457, 6.491853, 6.554589, 5.426265, 6.475733,
    5.426265, 6.870365, 5.857981, 4.857981, 7.098032, 7.189825, 6.539159, 6.614710,
    13.230020, 12.707359, 12.294334, 15.276742, 13.226412, 12.772933, 11.352043, 14.134266
  ),
  nrow = 8,
  ncol = 7,
  dimnames = list(
    c(1, 2, 3, 9, 10, 11, 12, 13),
    c("GSM1", "GSM2", "GSM3", "GSM4", "GSM5", "GSM6", "GSM7")
  )
)

# rna_data =
#          GSM1        GSM2        GSM3        GSM4        GSM5        GSM6        GSM7
# ------------------------------------------------------------------------------------------
# 1        6.930737    6.554589    6.643856    5.954196    6.539159    5.426265    13.230020
# 2        6.643856    6.741467    5.392317    6.672425    6.727920    6.870365    12.707359
# 3        5.247928    7.721099    7.348728    6.614710    6.845490    5.857981    12.294334
# 9        7.169925    6.247928    7.491853    5.169925    7.592457    4.857981    15.276742
# 10       7.303781    7.139551    6.044394    6.988685    6.491853    7.098032    13.226412
# 11       6.375039    6.569856    5.700440    7.357552    6.554589    7.189825    12.772933
# 12       6.108524    5.554589    6.169925    6.954196    5.426265    6.539159    11.352043
# 13       7.055282    6.392317    5.247928    6.285402    6.475733    6.614710    14.134266

# the first column represents the row names (gene IDs)

tissue_status <- c("ALS Spectrum MND", "ALS Spectrum MND", "ALS Spectrum MND", "Non-Neurological Control", "ALS Spectrum MND", "ALS Spectrum MND", "Non-Neurological Control")
tissue_status_factor <- factor(tissue_status, levels = c("Non-Neurological Control", "ALS Spectrum MND"))
rna_metadata <- data.frame(
  accession = c("GSM1", "GSM2", "GSM3", "GSM4", "GSM5", "GSM6", "GSM7"),
  tissue = c("Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Spinal Cord Lumbar", "Cerebellum", "Cerebellum", "Cerebellum"),
  tissue_status = tissue_status_factor
)

# rna_metadata =
# accession   tissue                  tissue_status
# ------------------------------------------------------------
# GSM1        Spinal Cord Lumbar      ALS Spectrum MND
# GSM2        Spinal Cord Lumbar      ALS Spectrum MND
# GSM3        Spinal Cord Lumbar      ALS Spectrum MND
# GSM4        Spinal Cord Lumbar      Non-Neurological Control
# GSM5        Cerebellum              ALS Spectrum MND
# GSM6        Cerebellum              ALS Spectrum MND
# GSM7        Cerebellum              Non-Neurological Control

formula <- ~tissue_status + (1 | tissue)
filter_by_protein_coding <- FALSE
lmmDGEJulia <- LMMDGEJulia$new()
lmmDGEJulia$compute(rna_data, rna_metadata, formula, filter_by_protein_coding)

# output =
# gene_id   DE_log2_FC   std.error   t.value      p.value       adj.p.value
# -------------------------------------------------------------------------
# 1         -3.173187    1.972801    -1.608468    0.107732704   0.12312309
# 10        -3.232872    1.622695    -1.992286    0.046339687   0.09043508
# 11        -3.443194    1.231042    -2.796975    0.005158359   0.02524483
# 12        -3.145522    1.151717    -2.731159    0.006311206   0.02524483
# 13        -3.725951    1.953839    -1.906990    0.056521927   0.09043508
# 2         -3.079574    1.440745    -2.137487    0.032558363   0.08682230
# 3         -2.850277    1.689365    -1.687188    0.091567163   0.12208955
# 9         -3.551305    2.807782    -1.264808    0.205940193   0.20594019

}
