
ConnectivityScorePValue <- R6Class(
  "ConnectivityScorePValue",
  public = list(
    compute = function(connectivity_score, random_connectivity_score_distribution) {
      return(sum(random_connectivity_score_distribution < connectivity_score) / length(random_connectivity_score_distribution))
    }
  )
)






