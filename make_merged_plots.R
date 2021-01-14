install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
library(RColorBrewer)

san <- read.table("~/Documents/san_chr1.txt", header = F)

##subset merged data to plot all four models onto one plot 
san1  <- san %>% select(1,7)
san2 <- san %>% select(1,10)
san3 <- san %>% select(1,13)
san4 <- san %>% select(1,16)

colnames(san1) <- c("BP", "P")
colnames(san2) <- c("BP", "P")
colnames(san3) <- c("BP", "P")
colnames(san4) <- c("BP", "P")

san1 = cbind(Model="GAO model", san1)
san2 = cbind(Model="LAAA model", san2)
san3 = cbind(Model="APA model", san3)
san4 = cbind(Model="LAO model", san4)

san_data <- rbind(san1, san2, san3, san4)

##plot function 

plot <- ggplot() + 
  geom_point(data = san_data, aes(x=BP, y=-log10(P), colour= as.factor(Model)), size = 4, alpha  = 0.8,  na.rm = TRUE) +
  #geom_point(data = san2, aes(x=BP.1, y=P.1), size =2 , alpha = 0.7, color = "blue", na.rm = TRUE) +
  # geom_point(data = san3, color = "red" , na.rm = TRUE) +
  # geom_point(data = san4, color = "grey", na.rm = TRUE) + 
  ggtitle(label = "KhoeSan Ancestry") + 
  scale_color_manual(values = c("coral", "black", "violetred", "CadetBlue")) +
  xlab("Chromosome 2") +
  ylab("-log10(p-value)") +
  geom_hline(yintercept = -log10(5e-8)) +
  geom_hline(yintercept = -log10(2.34e-06) , colour = "#990000", linetype = "dashed") +
  
  
  theme_bw(base_size = 22) +
  theme( 
    plot.title = element_text(hjust = 0.5, size = 30),
    legend.title = element_blank(),
    legend.position="right",
    legend.key.size = unit(1.5, "cm"), 
    legend.key.width = unit(3.5, "cm"),
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )


plot

png("~/Documents/san_chr1.png", width=1425, height=975)
plot
dev.off()




san <- read.table("~/Documents/ea_chr22.txt", header = F)

##subset merged data to plot all four models onto one plot 
san1  <- san %>% select(1,7)
san2 <- san %>% select(1,10)
san3 <- san %>% select(1,13)
san4 <- san %>% select(1,16)

colnames(san1) <- c("BP", "P")
colnames(san2) <- c("BP", "P")
colnames(san3) <- c("BP", "P")
colnames(san4) <- c("BP", "P")

san1 = cbind(Model="GAO model", san1)
san2 = cbind(Model="LAAA model", san2)
san3 = cbind(Model="APA model", san3)
san4 = cbind(Model="LAO model", san4)

san_data <- rbind(san1, san2, san3, san4)

##plot function 

plot <- ggplot() + 
  geom_point(data = san_data, aes(x=BP, y=-log10(P), colour= as.factor(Model)), size = 4, alpha  = 0.8,  na.rm = TRUE) +
  #geom_point(data = san2, aes(x=BP.1, y=P.1), size =2 , alpha = 0.7, color = "blue", na.rm = TRUE) +
  # geom_point(data = san3, color = "red" , na.rm = TRUE) +
  # geom_point(data = san4, color = "grey", na.rm = TRUE) + 
  ggtitle(label = "East Asian Ancestry") + 
  scale_color_manual(values = c("coral", "black", "violetred", "CadetBlue")) +
  xlab("Chromosome 22") +
  ylab("-log10(p-value)") +
  geom_hline(yintercept = -log10(5e-8)) +
  geom_hline(yintercept = -log10(2.34e-06) , colour = "#990000", linetype = "dashed") +
  
  
  theme_bw(base_size = 22) +
  theme( 
    plot.title = element_text(hjust = 0.5, size = 30),
    legend.title = element_blank(),
    legend.position="right",
    legend.key.size = unit(1.5, "cm"), 
    legend.key.width = unit(3.5, "cm"),
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )


plot

png("~/Documents/ea_chr22.png", width=1425, height=975)
plot
dev.off()

