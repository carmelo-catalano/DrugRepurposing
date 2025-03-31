\name{LMMDGELmer}
\alias{LMMDGELmer}
\title{Computes differential gene expression analysis using the Linear Mixed Model (LMM)}
\description{
Computes differential gene expression analysis using the Linear Mixed Model (\code{LMM}).
\cr
The LMM computation is performed using the function \code{lmer} (library \code{lme4}).
\cr
The input consists of two groups of RNA data analysis from tissues under different conditions: control/altered state. For example, a disease-affected group and a control group.
\cr
Unlike the dichotomous case, where groups are divided only into "control/altered state", additional conditions exist under which the experiments were conducted. For instance, multiple RNA plates were used, or tissues originated from different parts of the body.
\cr
RNA data must follow "normal distribution", which is typical for RNA microarray analysis.
\cr
For RNA data following a "negative binomial distribution", refer to \code{LMMVoomDGEDream}, \code{LMMVoomDGEJulia}, or \code{LMMVoomDGELmer}.
}
\usage{
lmmDGELmer <- LMMDGELmer$new()
lmmDGELmer$compute(rna_data, rna_metadata, formula, filter_by_protein_coding)
}
\arguments{
  Same as in \code{LMMDGEAbstract}
}
\value{
Data frame. Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}.
\code{lmer} does not return a \code{p-value}.
Therefore, when LMM is computed using \code{lmer}, the fields \code{p.value} and \code{adj.p.value} are not included.
}
\examples{
rna_data =
GeneID   GSM1        GSM2        GSM3        GSM4        GSM5        GSM6        GSM7
1        6.930737    6.554589    6.643856    5.954196    6.539159    5.426265    13.230020
2        6.643856    6.741467    5.392317    6.672425    6.727920    6.870365    12.707359
3        5.247928    7.721099    7.348728    6.614710    6.845490    5.857981    12.294334
9        7.169925    6.247928    7.491853    5.169925    7.592457    4.857981    15.276742
10       7.303781    7.139551    6.044394    6.988685    6.491853    7.098032    13.226412
11       6.375039    6.569856    5.700440    7.357552    6.554589    7.189825    12.772933
12       6.108524    5.554589    6.169925    6.954196    5.426265    6.539159    11.352043
13       7.055282    6.392317    5.247928    6.285402    6.475733    6.614710    14.134266

rna_metadata =
accession   tissue                  tissue_status
GSM1        Spinal Cord Lumbar      ALS Spectrum MND
GSM2        Spinal Cord Lumbar      ALS Spectrum MND
GSM3        Spinal Cord Lumbar      ALS Spectrum MND
GSM4        Spinal Cord Lumbar      Non-Neurological Control
GSM5        Cerebellum              ALS Spectrum MND
GSM6        Cerebellum              ALS Spectrum MND
GSM7        Cerebellum              Non-Neurological Control


formula <- ~ tissue_status + (1 | tissue)
filter_by_protein_coding <- FALSE
lmmDGELmer <- LMMDGELmer$new()
lmmDGELmer$compute(rna_data, rna_metadata, formula, filter_by_protein_coding)

output =
gene_id   DE_log2_FC   std.error   t.value
1         -1.741698    0.1880556   -9.261609
2         -2.068486    0.1994708   -10.36986
3          3.15081634  0.38551284   8.17305166
9          1.57459378  0.28081845   5.60715925
10        -1.16248     0.479470    -11.9862
11        -1.578634    0.18694856  -8.444215
12        -2.231698    0.3184556   -10.22609
13         2.40136101  0.33681676   7.12957687
}
