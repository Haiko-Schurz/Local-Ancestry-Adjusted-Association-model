install.packages('knitr', dependencies = TRUE)
install.packages("rmarkdown")
devtools::build_vignettes()
library(roots)
library(devtools)
install.packages("/Users/yolandiswart/Downloads/STEAM-master")

install_github("kegrinde/STEAM")

library(STEAM)

source(file = "Documents/steam/R/get_deltas.R")
source(file = "Documents/steam/R/get_ab.R")
source(file = "Documents/steam/R/get_L.R")
source(file = "Documents/steam/R/get_sigma.R")
source(file = "Documents/steam/R/get_sigma_ij.R")
source(file = "Documents/steam/R/upper_alpha.R")

props <- read.table("~/Documents/ancestral_proportions", header = T)
map <- read.table("~/Documents/example_map", header = T)

set.seed(1)
get_thresh_simstat(g = 15, map = map, props = props, nreps = 1000)

get_thresh_simstat <- function(g, map, props, nreps=50, alpha=0.05, type="pval"){
  # get distances between adjacent markers
  dlt <- c(0,get_deltas(map)) # length m
  
  # pre-calculate constants for test stat sim (a's and b's)
  ab <- get_ab(dlt,g)
  
  # get average admixture proportions
  avg_props <- apply(props,2,mean,na.rm=T)
  
  # calculate the matrix L
  L <- get_L(avg_props) # could condense with calculating avg
  
  # simulate test stats nreps times
  max_stats <- replicate(nreps, simstat_once(m = nrow(map), K = ncol(props), as = ab$a, bs = ab$b, L = L))
  
  # get upper alpha quantile
  zstar <- upper_alpha(max_stats, alpha)
  
  # get 95% bootstrap CI for threshold (5k reps)
  if (requireNamespace("bootstrap", quietly = TRUE)) {
    z_ci <- quantile(bootstrap::bootstrap(max_stats, nboot = 5000, theta = upper_alpha, alpha)$thetastar, c(0.025,0.975))
  } else{
    z_ci <-c(NA,NA)
    cat('Install package \"bootstrap\" to get confidence interval. \n')
  }
  
  # return threshold
  if(type == "stat"){
    thresh <- zstar
    thresh_ci <- z_ci
  } else if(type == "pval"){
    thresh <- 2 * pnorm(zstar, lower.tail = F)
    thresh_ci <- 2 * pnorm(z_ci, lower.tail = F)
  } else{
    cat("Please specify type = 'stat' or type = 'pval' \n")
  }
  return(list(threshold = thresh, ci = thresh_ci))
}


