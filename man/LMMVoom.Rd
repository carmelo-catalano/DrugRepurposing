\name{LMMVoom}
\alias{LMMVoom}
\title{Transform RNA-Seq data ready for Linear Mixed Model (LMM) computation}
\description{
Transforms RNA-Seq data to prepare it for Linear Mixed Model (LMM) computation. This class applies the following functions in order: \code{DGEList}, \code{calcNormFactors}, and \code{voomWithDreamWeights}.
}
\usage{
lmmVoom <- LMMVoom$new(formula)
lmmVoom$compute(rna_seq_data, rna_seq_metadata)
}
\arguments{
  \item{rna_seq_data}{
    RNA-Seq data. The first column contains the gene id; the other columns contain the RNA-Seq analysis. The first column name is \code{"GeneID"}, and the rest are titled according to the RNA analysis identifier (sample id).
    \cr
    This package has been tested on Illumina RNA-Seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{rna_seq_metadata}{
    RNA-Seq metadata table associated with the RNA-Seq data table.\cr
    The metadata contains the control/altered state of the samples, along with additional conditions (e.g., sample origin).\cr
    For each RNA-Seq sample column in the RNA-Seq data table, there must be a corresponding row in the \code{rna_seq_metadata} table.\cr
    One column of \code{rna_seq_metadata} must be named \code{"sample_id"} and must contain the sample IDs of the RNA-Seq experiments.
    This column is used to filter \code{rna_seq_data}: \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}.\cr
    The status column must be a factor, and the first level of the factor must correspond to the \code{"control"} state.\cr
    This package has been tested on Illumina RNA-Seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    See example below.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula (constructor argument)}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account
    for all the conditions under which the RNA experiments were performed.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
}
\value{
An \code{EList} object, similar to the result of \code{limma::voom()}, containing transformed count data as log2-counts per million (\code{logCPM}) and weights.
}
\examples{

# rna_seq_data =
# GeneID   GSM1        GSM2        GSM3        GSM4        GSM5        GSM6        GSM7
# -------------------------------------------------------------------------------------
# 1        262         116         111         162         172         182         142
# 2        28189       33702       11173       21947       22147       20817       19117
# 3        463         261         193         281         351         291         231
# 9        12301       3277        862         5990        4890        5550        5110
# 10       284         132         88          280         270         220         210
# 11       2966        2006        1371        2241        2151        2012        1922
# 12       4842        3699        2536        4527        4347        4125        3825
# 13       9966        12406       1531        12941       11841       10121       11347

# rna_seq_metadata =
# accession   tissue                  subject_id     tissue_status
# -------------------------------------------------------------------
# GSM1        Spinal Cord Lumbar      NEUEL133AK6    ALS Spectrum MND
# GSM2        Spinal Cord Lumbar      NEUYV496XLP    ALS Spectrum MND
# GSM3        Spinal Cord Lumbar      NEUZU200WEQ    ALS Spectrum MND
# GSM4        Spinal Cord Lumbar      NEUEC006FND    Non-Neurological Control
# GSM5        Spinal Cord Lumbar      NEUKM699KKH    ALS Spectrum MND
# GSM6        Cerebellum              NEUJZ255ZC5    ALS

formula <- ~ tissue_status + (1 | tissue)
lmmVoom <- LMMVoom$new(formula)
lmmVoom$compute(rna_seq_data, rna_seq_metadata)

# output:
# E =
# GeneID   GSM1        GSM2        GSM3        GSM4        GSM5        GSM6        GSM7
# ------------------------------------------------------------------------------------------
# 1        6.930737    6.554589    6.643856    5.954196    6.539159    5.426265    13.230020
# 2        6.643856    6.741467    5.392317    6.672425    6.727920    6.870365    12.707359
# 3        5.247928    7.721099    7.348728    6.614710    6.845490    5.857981    12.294334
# 9        7.169925    6.247928    7.491853    5.169925    7.592457    4.857981    15.276742
# 10       7.303781    7.139551    6.044394    6.988685    6.491853    7.098032    13.226412
# 11       6.375039    6.569856    5.700440    7.357552    6.554589    7.189825    12.772933
# 12       6.108524    5.554589    6.169925    6.954196    5.426265    6.539159    11.352043
# 13       7.055282    6.392317    5.247928    6.285402    6.475733    6.614710    14.134266

# weights =
# V1        V2        V3        V4        V5        V6        V7
# --------------------------------------------------------------------
# 3.201166  2.990876  2.712801  3.239883  3.196680  2.955101  2.681659
# 5.999187  6.388492  7.274140  5.937821  6.109534  6.575438  7.633159
# 6.161782  6.564428  7.617335  6.098332  5.963517  6.415417  7.320517
# 6.176851  6.273378  5.491135  6.198819  6.145074  6.295541  5.027487
# 7.845845  8.275930  7.014116  7.692595  7.953565  8.048347  6.899431
# 7.600324  8.391202  7.231547  7.465785  8.146863  7.871641  6.806220
# 6.776246  7.540091  8.172097  6.662086  6.481876  7.197001  8.400980
# 4.661921  4.785769  5.321723  4.661921  4.661921  4.789040  5.322714

}
