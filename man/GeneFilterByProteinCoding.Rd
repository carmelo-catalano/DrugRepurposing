\name{GeneFilterByProteinCoding}
\alias{GeneFilterByProteinCoding}
\title{Filter non-protein-coding genes}
\description{
Filter out non-protein-coding genes.
The filter is applied using the database \code{extdata/protein_coding_gene.Rds}, which provides information on whether each gene is protein-coding.
\cr
This class provides 2 methods:
\cr
1) filterById(gene_expressions)\cr
Filter genes by id;
\cr
2) filterByIdOnCondition(gene_expressions, filter_by_protein_coding)\cr
Filter genes by id only if \code{filter_by_protein_coding = TRUE}.
\usage{
geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
geneFilterByProteinCoding$filterById(gene_expressions)
geneFilterByProteinCoding$filterByIdOnCondition(gene_expressions, filter_by_protein_coding)
}
\arguments{
  \item{gene_expressions}{
    Table of RNA data. Each column represents an RNA data sample, and each row represents a gene.
    Row names are gene IDs, and column names are experiment identifiers.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{filter_by_protein_coding}{
    Filter condition for the \code{filterByIdOnCondition} method. Filter is applied only if \code{filter_by_protein_coding = TRUE}
    \itemize{
      \item Type: \code{boolean}.
    }
  }
}
\value{
Matrix. Original matrix without filtered genes.
}
\examples{
# gene_expressions
#           GSM1   GSM2   GSM3   GSM4   GSM5   GSM6   GSM7
# --------------------------------------------------------
#  1        817    480    513    497    105    123    455
#  2        451    315    489    620    762    244    572
#  9        792    608    560    585    952    436    823
#  12       220    244    283    404    434    196    314
#  13       142    229    240    350    332    163    239
#  14       682    501    354    669    721    520    550
#  21       230    133    830    159    127    191    186
#  25       102    605    246    368    611    588    654

geneFilterByProteinCoding <- GeneFilterByProteinCoding$new()
geneFilterByProteinCoding$filterById(gene_expressions)

}

