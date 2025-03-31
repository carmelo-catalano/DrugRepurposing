\name{GEORNASeqLMMVoomDrugRepurpose}
\alias{GEORNASeqLMMVoomDrugRepurpose}
\title{Compute connectivity score between disease RNA-Seq dataset and a list of drugs}
\description{
Given a disease RNA-Seq analysis and a list of drug DGEs, GEORNASeqLMMVoomDrugRepurpose computes the connectivity score between the disease and the drugs.
This class composes the class BinChenDiseaseDGEDrugListConnectivityScore and an implementation of GEORNASeqLMMVoomDGEAbstract.
The input RNA-seq data and metadata files are sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqLMMVoomDrugRepurpose$new(geoRNASeqLMMVoomDGELmer)
geoRNASeqLMMVoomDrugRepurpose$compute(rna_seq_data_filename,
        rna_seq_metadata_filename, formula, tissue_status_field_name,
        tissue_statuses_to_be_tested, tissue_statuses_map,
        sample_id_field_name, additional_fields, drug_dge_dir, drugs,
        drugs_genes, drug_gde_t_value_column_name,
        random_distribution_size, disease_name, drug_perturbation_time,
        parallel_computation, filter_by_protein_coding,
        signature_mapper_parameter
)
}
\arguments{
  \item{rna_seq_data_filename}{
    Filename for RNA-seq data compatible with the Gene Expression Omnibus (GEO) format. The file is in tsv (tab-separated value) format.
    The file may also be compressed in gz format.
    First column contains the gene id; the other columns contain the RNA-Seq analysis. First column name is "GeneID". The rest of the columns are titled according to the RNA analysis identifier (sample id).
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    Type: \code{string}.
  }
  \item{rna_seq_metadata_filename}{
    Filename of RNA-seq metadata file. The file is in csv format, with ";" separator.
    For each RNA-seq analysis column in the rna_seq_data table, there is a row in the rna_seq_metadata table.
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    Type: \code{string}.
  }
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-seq experiments were performed.
    Because data and metadata are in separate files, the dependent variable to the left of the ~ operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
    Type: \code{R formula}.
  }
  \item{tissue_status_field_name}{
    Name of the column in the rna_seq_metadata table that contains the tissue status.
    Type: \code{string}.
  }
  \item{tissue_statuses_to_be_tested}{
    A list of length 2 containing tissue statuses, usually a control tissue and a disease-affected tissue.
    Type: \code{string vector}.
  }
  \item{tissue_statuses_map}{
    A list of length 2 containing tissue statuses to rename the statuses in tissue_statuses_to_be_tested.
    \code{tissue_statuses_map} and \code{tissue_statuses_to_be_tested} have the same size.
    Type: \code{string vector}.
  }
  \item{sample_id_field_name}{
    Additional field to use for LMM computation. This fields represents the additional conditions under which the experiments were conducted.
    Type: \code{string}.
  }
  \item{sample_id_field_name}{
    Column name in the \code{rna_seq_metadata} table that contains the sample_id. The sample_id is used to match metadata with the RNA-Seq data.
    Type: \code{string}.
  }
  \item{drug_dge_dir}{
    Directory containing the drug DGE files.
    Type: \code{string}.
  }
  \item{drugs}{
    Drug signatures.
    A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    Type: \code{data.frame}.
    Columns: \code{name} = drug name, \code{filename} = drug DGE filename.
  }
  \item{drugs_genes}{
    The gene ID list used for connectivity score computation. Typically, a subset of the full DGE is used, excluding certain genes.
    Type: \code{vector}.
  }
  \item{drug_dge_t_value_column_name}{
    The t-value is the drug DGE parameter used for connectivity score computation. This field specifies the name of the column containing the t-value in the DGE table.
    Type: \code{string}.
    Default value: \code{"t.value"}.
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution. Higher values provide more precise p-values.
    Type: \code{integer}.
    Default value: \code{10^5}.
  }
  \item{disease_name}{
    Disease name. If specified, it is added to the output table. It is not used for the computation.
    Type: \code{string}.
    Default value: \code{NA}.
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. If specified, it is added to the output table. It is not used for the computation.
    Type: \code{string}.
    Default value: \code{NA}.
  }
  \item{parallel_computation}{
    Enable parallel computation. Only for Unix-like systems.
    Type: \code{boolean}.
    Default value: \code{FALSE}.
  }
  \item{filter_by_protein_coding}{
    If true, remove non-protein coding genes.
    Type: \code{boolean}.
    Default value: \code{FALSE}.
  }
  \item{signature_mapper_parameter}{
    Parameter used by the constructor argument \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping.
    If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    Default value: \code{NA}.
  }
  \item{geoRNASeqLMMVoomDGE (constructor argument)}{
    Instance of a class for computing LMM with Voom-transformed data.
    Type: Derived class of \code{GEORNASeqLMMVoomDGEAbstract}.
    Default value: Instance of class \code{GEORNASeqLMMVoomDGEDream}.
  }
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming \code{disease_dge} to a disease signature.
    Type: class derived from \code{DGEToSignatureMapperAbstract}.
    Default value: Instance of class \code{MostSignificantGenesSignatureMapper}.
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The field \code{drug_perturbation_time} is optional.
}
\examples{
rna_seq_data_filename <- "/home/user/rna/GSE153960_raw_counts_GRCh38.p13_NCBI.tsv.gz"
# File content:
#
# GeneID   GSM1      GSM2      GSM3      GSM4      GSM5      GSM6      GSM7
# 1        262       116       111       162       172       182       142
# 2        28189     33702     11173     21947     22147     20817     19117
# 3        463       261       193       281       351       291       231
# 9        12301     3277      862       5990      4890      5550      5110
# 10       284       132       88        280       270       220       210
# 11       2966      2006      1371      2241      2151      2012      1922
# 12       4842      3699      2536      4527      4347      4125      3825
# 13       9966      12406     1531      12941     11841     10121     11347

rna_seq_metadata_filename <- "/home/user/rna/gse153960_metadata.csv"
# File content:
#
# accession       tissue                subject_id     tissue_status
# GSM1            Spinal Cord Lumbar    NEUEL133AK6   ALS Spectrum MND
# GSM2            Spinal Cord Lumbar    NEUYV496XLP   ALS Spectrum MND, Other Neurological Disorders
# GSM3            Spinal Cord Lumbar    NEUZU200WEQ   ALS Spectrum MND
# GSM4            Spinal Cord Lumbar    NEUEC006FND   Non-Neurological Control
# GSM5            Spinal Cord Lumbar    NEUKM699KKH   ALS Spectrum MND, Other Neurological Disorders
# GSM6            Cerebellum            NEUJZ255ZC5   ALS Spectrum MND
# GSM7            Cerebellum            NEUJZ233ZL3   Non-Neurological Control

formula = ~tissue_status + (1 | tissue)
tissue_status_field_name = "tissue_status"
tissue_statuses_to_be_tested = c("Non-Neurological Control", "ALS Spectrum MND")
tissue_statuses_map = c("Control", "als")
sample_id_field_name = "accession"
additional_fields = "tissue"
drug_dge_dir = /drug_dges/
drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404")
)
drugs_genes = c(780, 7849, 2049, 2101, 8717, 10594, 826 11224, 6158)
drug_gde_t_value_column_name = "t.value"
random_distribution_size = 10^5,
disease_name = "ALS"
drug_perturbation_time = "6h"
parallel_computation = F
filter_by_protein_coding = F
signature_mapper_parameter = 150

geoRNASeqLMMVoomDGELmer <- GEORNASeqLMMVoomDGELmer$new()
geoRNASeqLMMVoomDrugRepurpose <- GEORNASeqLMMVoomDrugRepurpose$new(geoRNASeqLMMVoomDGELmer)
geoRNASeqLMMVoomDrugRepurpose$compute(rna_seq_data_filename,
        rna_seq_metadata_filename, formula, tissue_status_field_name,
        tissue_statuses_to_be_tested, tissue_statuses_map,
        sample_id_field_name, additional_fields, drug_dge_dir, drugs,
        drugs_genes, drug_gde_t_value_column_name,
        random_distribution_size, disease_name, drug_perturbation_time,
        parallel_computation, filter_by_protein_coding,
        signature_mapper_parameter
)

# output
# drug         connectivity_score   p.value                 adj.p.value             disease    disease_signature_type     drug_perturbation_time
# A-23187      0.334653             0.1880556               0.2883341               ALS        4 MostSignificantGenes     6h
# A-443644     0.4163465            0.1994708               0.2791108               ALS        4 MostSignificantGenes     6h
# AG-490       0.4176343            0.38551284              0.45781284              ALS        4 MostSignificantGenes     6h
# AG-494      -0.253463             0.28081845              0.39761845              ALS        4 MostSignificantGenes     6h
# AG-957       0.5536333            0.479470                0.553470                ALS        4 MostSignificantGenes     6h
# AM-404      -0.524245             0.18694856              0.20896345              ALS        4 MostSignificantGenes     6h
}
