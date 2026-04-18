\name{GEORNASeqLMMVoomDGECore}
\alias{GEORNASeqLMMVoomDGECore}
\title{Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom transformed data}
\description{
Derived class of \code{GEORNASeqLMMVoomDGEAbstract}. Computes differential gene expression analysis using the Linear Mixed Model (LMM) with Voom transformed data. This class requires a collaborator for LMM computation. The package provides three different classes to compute LMM: \code{LMMVoomDGEDream}, \code{LMMVoomDGEJulia}, and \code{LMMVoomDGELmer}.
\cr
The input consists of two groups of RNA-Seq data from tissues under different conditions: control/altered state. For example, a disease-affected group and a control group.
\cr
Unlike the dichotomous case, where groups are divided only into "control/altered state," additional conditions exist under which the experiments were conducted. For instance, multiple RNA plates were used, or tissues originated from different parts of the body.
\cr
RNA data must follow a negative binomial distribution, which is typical for RNA-Seq analyses. For RNA data following a normal distribution, refer to \code{LMMDGEDream}, \code{LMMDGEJulia}, or \code{LMMDGELmer}.
\cr
Both \code{tissue_statuses_to_be_tested} and \code{tissue_statuses_map} must have a length of 2. The input RNA-Seq data and metadata files are sourced from NCBI (https://www.ncbi.nlm.nih.gov/).
}
\usage{
lmmVoomDGE = LMMVoomDGEDream$new()
geoRNASeqLMMVoomDGECore <- GEORNASeqLMMVoomDGECore$new(lmmVoomDGE)
geoRNASeqLMMVoomDGECore$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  sample_status_column_name,
  filter_by_protein_coding
)
}
\arguments{
  \item{rna_seq_data_filename}{
    Name of the file containing the RNA-Seq data.
    \cr
    The file must be in TSV (tab-separated values) format, optionally compressed in GZ format, and must comply with the GEO NCBI specification.
    \cr
    The file contains a table of RNA-Seq data.\cr
    The table should have gene IDs in the first column (named \code{GeneID}) and RNA-Seq analysis identifiers (sample IDs) as subsequent column headers.
    Each row represents a gene, and each column represents an RNA-Seq sample.
    \cr
    The filename can be a local path (e.g., \file{/user/rna/raw_counts.tsv}) or a URL (e.g., \url{https://www.ncbi.gov/geo/download/raw_counts.tsv.gz}).
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
  \item{formula}{
    The formula used for LMM computation. The formula may include both fixed and random effects to account for the conditions under which the RNA-Seq experiments were performed.
    \cr
    Because data and metadata are stored in separate tables, the dependent variable (to the left of the \code{~} operator) must not be specified.
    For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{formula}.
    }
  }
  \item{random_effect_column_name}{
    This argument specifies the name of the random effect column used to filter out low-level grouping variables.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_status_column_name}{
    This argument specifies the name of the samples status column used to filter out non-significant genes.
    \cr
    See \code{\link{LowCountsGeneFilter}} for more information.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_status"}
    }
  }
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{lmmVoomDGE (constructor argument)}{
    Instance of a class used to compute the disease DGE using LMM.
    \itemize{
      \item Type: a class derived from \code{\link{LMMVoomDGEAbstract}}.
      \item Default value: an instance of \code{\link{LMMVoomDreamDGE}}.
    }
  }
  \item{lmmGeneFilter (constructor argument)}{
    Instance of a class used to filter RNA data suitable for LMM analysis.\cr
    See \code{\link{LMMGeneFilterAbstract}} for more information.
    \itemize{
      \item Type: a class derived from \code{\link{LMMGeneFilterAbstract}}.
      \item Default value: an instance of \code{\link{LMMLowCountsGeneFilter}}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} represents differential expression = log2 fold change.
\cr
\code{Lmer} does not return p-value fields. Therefore, when LMM is computed using \code{lmer}, the fields \code{p.value} and \code{adj.p.value} are not included.
}
\examples{
rna_seq_data_filename <- "/home/user/rna/GSE153960_raw_counts_GRCh38.p13_NCBI.tsv.gz"
# file content example:
# GeneID   GSM1      GSM2      GSM3      GSM4      GSM5      GSM6      GSM7
# --------------------------------------------------------------------------
# 1        262       116       111       162       172       182       142
# 2        28189     33702     11173     21947     22147     20817     19117
# 3        463       261       193       281       351       291       231
# 9        12301     3277      862       5990      4890      5550      5110
# 10       284       132       88        280       270       220       210
# 11       2966      2006      1371      2241      2151      2012      1922
# 12       4842      3699      2536      4527      4347      4125      3825
# 13       9966      12406     1531      12941     11841     10121     11347

rna_seq_metadata
# sample_id   tissue               tissue_status
# ----------------------------------------------
# GSM1        Cerebellum           ALS
# GSM2        Cerebellum           ALS
# GSM3        Cortex Sensory       ALS
# GSM4        Cortex Frontal       Control
# GSM5        Cortex Sensory       Control
# GSM6        Cortex Frontal       ALS
# GSM7        Cerebellum           ALS

formula <- ~ tissue_status + (1 | tissue)
random_effect_column_names <- "tissue"
sample_status_column_name <- "tissue_status"
filter_by_protein_coding <- FALSE

lmmVoomDGE = LMMVoomDGEDream$new()
geoRNASeqLMMVoomDGECore <- GEORNASeqLMMVoomDGECore$new(lmmVoomDGE)
geoRNASeqLMMVoomDGECore$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  sample_status_column_name,
  filter_by_protein_coding
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
