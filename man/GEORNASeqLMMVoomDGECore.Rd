\name{GEORNASeqLMMVoomDGECore}
\alias{GEORNASeqLMMVoomDGECore}
\title{Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom transformed data}
\description{
Derived class of \code{GEORNASeqLMMVoomDGEAbstract}. Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom transformed data. This class requires a collaborator for LMM computation. The package provides three different classes to compute LMM: \code{LMMVoomDGEDream}, \code{LMMVoomDGEJulia}, and \code{LMMVoomDGELmer}.

The input consists of two groups of RNA-Seq data from tissues under different conditions: control/altered state. For example, a disease-affected group and a control group.

Unlike the dichotomous case, where groups are divided only into "control/altered state," additional conditions exist under which the experiments were conducted. For instance, multiple RNA plates were used, or tissues originated from different parts of the body.

RNA data must follow a negative binomial distribution, which is typical for RNA-Seq analyses. For RNA data following a normal distribution, refer to \code{LMMDGEDream}, \code{LMMDGEJulia}, or \code{LMMDGELmer}.

Both \code{tissue_statuses_to_be_tested} and \code{tissue_statuses_map} must have a length of 2. The input RNA-seq data and metadata files are sourced from NCBI (https://www.ncbi.nlm.nih.gov/).
}
\usage{
lmmVoomDGE = LMMVoomDGEDream$new()
geoRNASeqLMMVoomDGECore <- GEORNASeqLMMVoomDGECore$new(lmmVoomDGE)
geoRNASeqLMMVoomDGECore$compute(
  rna_seq_data_filename, rna_seq_metadata, formula,
  filter_by_protein_coding
)
}
\arguments{
  The \code{compute} function arguments are identical to those in GEORNASeqLMMVoomDGEAbstract.

  \item{lmmVoomDGE (constructor argument)}{
    Instance of a class for LMM computation.
    \itemize{
      \item Type: class derived from \code{LMMVoomDGEAbstract}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{GeneFilterAbstract}.
      \item Default value: Instance of class \code{LowCountsGeneFilter}.
    }
  }
}
\value{
Same as in \code{GEORNASeqLMMVoomDGEAbstract}.
}
\examples{
rna_seq_data_filename <- "/home/user/rna/GSE153960_raw_counts_GRCh38.p13_NCBI.tsv.gz"
# file content example:
# GeneID   GSM1      GSM2      GSM3      GSM4      GSM5      GSM6      GSM7
# 1        262       116       111       162       172       182       142
# 2        28189     33702     11173     21947     22147     20817     19117
# 3        463       261       193       281       351       291       231
# 9        12301     3277      862       5990      4890      5550      5110
# 10       284       132       88        280       270       220       210
# 11       2966      2006      1371      2241      2151      2012      1922
# 12       4842      3699      2536      4527      4347      4125      3825
# 13       9966      12406     1531      12941     11841     10121     11347

rna_seq_metadata
# rna_seq_metadata content example:
# accession       tissue                subject_id     tissue_status
# GSM1            Spinal Cord Lumbar    NEUEL133AK6   ALS Spectrum MND
# GSM2            Spinal Cord Lumbar    NEUYV496XLP   ALS Spectrum MND, Other Neurological Disorders
# GSM3            Spinal Cord Lumbar    NEUZU200WEQ   ALS Spectrum MND
# GSM4            Spinal Cord Lumbar    NEUEC006FND   Non-Neurological Control
# GSM5            Spinal Cord Lumbar    NEUKM699KKH   ALS Spectrum MND, Other Neurological Disorders
# GSM6            Cerebellum            NEUJZ255ZC5   ALS Spectrum MND
# GSM7            Cerebellum            NEUJZ233ZL3   Non-Neurological Control

formula <- ~ tissue_status + (1 | tissue)
filter_by_protein_coding <- FALSE

lmmVoomDGE = LMMVoomDGEDream$new()
geoRNASeqLMMVoomDGECore <- GEORNASeqLMMVoomDGECore$new(lmmVoomDGE)
geoRNASeqLMMVoomDGECore$compute(
  rna_seq_data_filename, rna_seq_metadata,
  formula,filter_by_protein_coding
)
# Output:
# gene_id    DE_log2_FC     std.error     t.value     p.value     adj.p.value
# 1          -1.741698      0.1880556     -9.261609   1.64E-11    1.49E-09
# 2          -2.068486      0.1994708     -10.36986   6.49E-13    1.48E-10
# 3           3.15081634    0.38551284     8.17305166 4.52E-10    1.91E-08
# 9           1.57459378    0.28081845     5.60715925 1.67E-06    1.54E-05
# 10         -1.16248       0.479470      -11.9862    6.29E-12    1.28E-11
# 11         -1.578634      0.18694856    -8.444215   1.95E-10    9.84E-09
# 12         -2.231698      0.3184556     -10.22609   1.44E-12    1.40E-10
# 13          2.40136101    0.33681676     7.12957687 1.22E-08    2.70E-07
}
