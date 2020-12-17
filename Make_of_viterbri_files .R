##This script takes the viterbri file (.msp.tsv) from RFMix and uncollapse it in order to use in the statistical models. It repeats the row by the number of SNPs that rows ancestr represent (indicated in column 6).
##Therefore ensuing the number of rows correspond to the number of SNPs indicated in the SNP_info_file and includes all genomic regions.It also cuts out the 


install.packages("doParallel")

x <- read.table("SAC_PAGE_1000G_chr1.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- parallel::makeCluster(2, setup_strategy = "sequential")
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr1", sep = '\t', quote = F)


x <- read.table("SAC_PAGE_1000G_chr2.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- parallel::makeCluster(2, setup_strategy = "sequential")
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr2", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr3.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr3", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr4.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr5", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr5.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr5", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr6.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr6", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr7.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr7", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr8.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr8", sep = '\t', quote = F)


x <- read.table("SAC_PAGE_1000G_chr9.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr9", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr10.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr10", sep = '\t', quote = F)


x <- read.table("SAC_PAGE_1000G_chr11.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr11", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr12.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr12", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr13.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr13", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr14.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr14", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr15.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr15", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr16.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr16", sep = '\t', quote = F)


x <- read.table("SAC_PAGE_1000G_chr17.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr17", sep = '\t', quote = F)


x <- read.table("SAC_PAGE_1000G_chr18.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr18", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr19.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr19", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr20.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr20", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr21.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr21", sep = '\t', quote = F)

x <- read.table("SAC_PAGE_1000G_chr22.msp.tsv", header = FALSE, sep = '\t')
head(x)

library(doRNG)
library(doParallel)

cl <- makeCluster(3)
registerDoParallel(cl)

doRNG::registerDoRNG(seed = 111)

m = foreach(i=1:nrow(x), .combine = rbind) %dorng% {
  z = matrix(rep(x[i, c(2:3,7:ncol(x))], x[i,6]), ncol = ncol(x)-4, nrow = x[i,6], byrow = T)
  return(z)  
}

write.table(m, file = "Viterbrifile_chr22", sep = '\t', quote = F)

