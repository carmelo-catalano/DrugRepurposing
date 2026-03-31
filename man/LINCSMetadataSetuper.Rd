\name{LINCSMetadataSetuper}
\alias{LINCSMetadataSetuper}
\title{Extract metadata from GSE92742_Broad_LINCS_inst_info.txt}
\description{

Extracts metadata from \file{GSE92742_Broad_LINCS_inst_info.txt} (downloaded from \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE92742})
and configures it to read RNA experiment data from the \link{LINCS} archive.

\cr
The columns used from the \file{GSE92742_Broad_LINCS_inst_info.txt} file are:
\itemize{
  \item inst_id: sample id
  \item rna_plate: rna plate
  \item rna_well: rna well
  \item pert_iname: standardized name of the perturbagen (e.g., drug name)
  \item pert_type: category of the perturbation, such as "trt_cp" (chemical treatment) or "ctl_vehicle" (control samples, typically DMSO).
  \item pert_dose: concentration of the treatment
  \item pert_time: duration of the cellular exposure to the perturbagen (e.g., 6h, 24h, 48h)
  \item cell_id: name of the specific cell line used in the assay (e.g., MCF7, PC3, VCAP)
}
\cr
The setup consists of the following steps:

\enumerate{
    \item Filter experiments according to the rule: \code{pert_type == "trt_cp" & pert_dose == 10 & pert_time in drug_perturbation_times}
    \item Exclude cell lines that appear with a frequency of less than 5.
    \item Exclude experiments involving drugs not included in drug_names.
    \item Convert the \code{pert_iname} column into a factor, ensuring that the first level is set to DMSO (control vehicle).
}
}
\usage{
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsMetadataSetuper$setup(drug_perturbation_times, drugs_filter)
}
\arguments{
  \item{drug_perturbation_times}{
    List of drug perturbation times.
    Drug perturbation time is the duration for which the sample is treated with the drug.
    \itemize{
      \item Type: \code{character vector}.
    }
  }
  \item{drugs_filter}{
    List of drugs for which the DGE will be computed.
    \itemize{
      \item Type: \code{vector}.
      \item Default value: NA.
    }
  }
}
\value{
Data frame containing configured LINCS metadata. Columns: \code{inst_id},
\code{rna_plate}, \code{pert_id}, \code{pert_iname}, \code{pert_time}, \code{and cell_id}.
}
\examples{
drug_perturbation_times <- "6"
drugs_filter = c("AM-251", "AM-404", "AM-580")

lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsMetadataSetuper$setup(drug_perturbation_times, drugs_filter)

# Output:
# inst_id       rna_plate   pert_id        pert_iname   pert_time  cell_id
# ------------------------------------------------------------------------
# AML001        XA34        DMSO           DMSO         6          CD33
# AML002        XA34        BRD-K92000912  AM-251       6          CD33
# AML003        XA34        BRD-K92000912  AM-251       6          CD33
# AML004        XA34        BRD-K21667562  AM-404       6          CD35
# AML005        XA35        BRD-K21667562  AM-404       6          CD35
# AML006        XA35        BRD-K06854232  AM-580       6          CD34
# AML007        XA35        DMSO           DMSO         6          CD34
# AML008        XA35        BRD-K06854232  AM-580       6          CD34
}
