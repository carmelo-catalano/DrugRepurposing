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
Both \code{tissue_statuses_to_be_tested} and \code{tissue_statuses_map} must have a length of 2. The input RNA-seq data and metadata files are sourced from NCBI (https://www.ncbi.nlm.nih.gov/).
}
\usage{
lmmVoomDGE = LMMVoomDGEDream$new()
geoRNASeqLMMVoomDGECore <- GEORNASeqLMMVoomDGECore$new(lmmVoomDGE)
geoRNASeqLMMVoomDGECore$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  counts_filter_column_name,
  filter_by_protein_coding
)
}
\arguments{
  \item{rna_seq_data_filename}{
    Filename for RNA-seq data compatible with the Gene Expression Omnibus (GEO) format. The file must be in tsv (tab-separated value) format.
    \cr
    The file may also be compressed in gz format.
    \cr
    The first column contains the gene ID; the other columns contain the RNA-Seq analysis. The first column name is \code{GeneID}, and the rest of the columns are titled according to the RNA analysis identifiers (sample id).
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    rna_seq_data_filename can be either a local path or a remote URL (typically hosted by NCBI), example:
    https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE92592&file=GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz\cr
    See example below.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{rna_seq_metadata}{
    \code{rna_seq_metadata} contain metadata for \code{rna_seq_data}.
    The first column of \code{rna_seq_metadata} must be named "\code{sample_id}" and must contain the sample IDs of the RNA-seq experiments.
    This column is used to filter \code{rna_seq_data}: \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}.
    \cr
    The metadata contains the status control/altered state of the sample and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \cr
    See example below
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-seq experiments were performed.
    \cr
    Because data and metadata are in separate files, the dependent variable to the left of the ~ operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{random_effect_column_name}{
    This argument specifies the name of the random effect column used to filter out low-level grouping variables.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{counts_filter_column_name}{
    This argument specifies the name of the samples status column used to filter out non-significant genes.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"sample_status"}
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{lmmVoomDGE (constructor argument)}{
    Instance of a class for LMM computation.
    \itemize{
      \item Type: class derived from \code{LMMVoomDGEAbstract}.
    }
  }
  \item{lmmGeneFilter (constructor argument)}{
    Instance of a class for filtering RNA data suitable for LMM analysis.
    \itemize{
      \item Type: derived class of \code{LMMGeneFilterAbstract}.
      \item Default value: Instance of class \code{LMMLowCountsGeneFilter}.
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
counts_filter_column_name <- "tissue_status"
filter_by_protein_coding <- FALSE

lmmVoomDGE = LMMVoomDGEDream$new()
geoRNASeqLMMVoomDGECore <- GEORNASeqLMMVoomDGECore$new(lmmVoomDGE)
geoRNASeqLMMVoomDGECore$compute(
  rna_seq_data_filename,
  rna_seq_metadata,
  formula,
  random_effect_column_names,
  counts_filter_column_name,
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
