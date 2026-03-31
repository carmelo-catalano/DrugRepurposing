\name{Gene-expression-signature}
\alias{Gene-expression-signature}
\title{Gene expression signature}
\description{
A table containing a subset of the disease \link{DGE} corresponding to the n most significant genes.
A typical value of n ranges from 50 to 300.\cr
Only two columns from the original \link{DGE} are retained: \code{gene_id} and \code{t.value}.\cr
The table is structured as a data.frame with two columns:
\itemize{
        \item The first column, named "gene_id", contains the gene identifiers.
        \item The second column, named "estimate", contains the t-value.
}
The "estimate" column represents a gene-level statistic derived from the DGE analysis.\cr
This package adopts the convention defined by Koudijs et al. [1], in which the t-value is used as the expression estimate.
In contrast, the implementation by Chen et al. [2] uses the log fold change.\cr
\strong{Note}: For connectivity score computation, the "estimate" value is needed.
The sign of the "estimate" indicates the status of the gene: positive = upregulated, negative = downregulated.
}
\section{References}{
    \itemize{
        \item 1.	Koudijs K.K.M. et al. Validation of transcriptome signature reversion for drug repurposing in oncology. Briefings in Bioinformatics, 2022.
        \item 2.	Chen B. et al. Reversal of cancer gene expression correlates with drug efficacy and reveals therapeutic targets. Nature Communications, 2017; 8:16022.
    }
}
\examples{
gene_id    estimate
---------------------
140        3.0510758
780        -1.0078762
2101       -0.1058122
2597        0.0071045
54812      -2.1922592
}
