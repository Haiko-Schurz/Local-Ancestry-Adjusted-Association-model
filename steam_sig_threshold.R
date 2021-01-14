
library(devtools)
library(SNPRelate)
library(gdsfmt)
library(SeqArray)
install_github("kegrinde/STEAM")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("gdsfmt")
BiocManager::install("SNPRelate")
BiocManager::install("SeqArray")

p <- read.table("steam_ancestry_props", header = T)
m <- read.table("steam_SAC", header = T)
library(STEAM)
set.seed(1)
get_thresh_simstat(g = 15, map = m, props = p, nreps = 10000)
