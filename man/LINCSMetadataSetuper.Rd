\name{LINCSMetadataSetuper}
\alias{LINCSMetadataSetuper}
\title{Configure the metadata in GSE92742_Broad_LINCS_inst_info.txt}
\description{
Configure the metadata in GSE92742_Broad_LINCS_inst_info.txt to read gene RNA experiments data from the LINCS archive.
}
\usage{
lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsMetadataSetuper$setup(perturbation_times, drugs_filter)
}
\arguments{
  \item{perturbation_times}{
    List of perturbation times.
    \itemize{
      \item Type: \code{string vector}.
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
perturbation_times <- "6"
drugs_filter = c("AM-251", "AM-404", "AM-580")

lincsMetadataSetuper <- LINCSMetadataSetuper$new()
lincsMetadataSetuper$setup(perturbation_times, drugs_filter)

# Output:
# inst_id       rna_plate   pert_id        pert_iname   pert_time  cell_id
# AML001        XA34        DMSO           DMSO         6          CD33
# AML002        XA34        BRD-K92000912  AM-251       6          CD33
# AML003        XA34        BRD-K92000912  AM-251       6          CD33
# AML004        XA34        BRD-K21667562  AM-404       6          CD35
# AML005        XA35        BRD-K21667562  AM-404       6          CD35
# AML006        XA35        BRD-K06854232  AM-580       6          CD34
# AML007        XA35        DMSO           DMSO         6          CD34
# AML008        XA35        BRD-K06854232  AM-580       6          CD34
}
