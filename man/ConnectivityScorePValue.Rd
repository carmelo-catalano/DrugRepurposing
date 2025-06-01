\name{ConnectivityScorePValue}
\alias{ConnectivityScorePValue}
\title{Compute Connectivity Score P-Value}
\description{
Computes the connectivity score p-value. The p-value is calculated by comparing the connectivity score with each element in \code{random_connectivity_score_distribution}:
\deqn{\frac{\sum (\text{random connectivity score distribution} < \text{connectivity score})}{\text{length(random connectivity score distribution)}}}
}
\usage{
ConnectivityScorePValue$new()
ConnectivityScorePValue$compute(connectivity_score, random_connectivity_score_distribution)
}
\arguments{
  \item{connectivity_score}{
    Connectivity score.
    \itemize{
      \item Type: \code{float}, ranging from -1 to +1.
    }
  }
  \item{random_connectivity_score_distribution}{
    Random connectivity score distribution.
    \itemize{
      \item Type: \code{numeric vector}.
    }
  }
}
\value{
A float number ranging from 0 to 1.
}
\examples{
connectivity_score <- 0.5
random_connectivity_score_distribution <- c(0.123, -0.56789, 0.8912763, 0.1357, -0.4754)

connectivityScorePValue <- ConnectivityScorePValue$new()
connectivityScorePValue$compute(connectivity_score, random_connectivity_score_distribution)
# Output: 0.8
}
