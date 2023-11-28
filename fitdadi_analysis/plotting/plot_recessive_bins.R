


setwd("~/Documents/UCLA/dominance/analysis/data/output_hs/")


data_0.5_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.50_0.50.csv")[1,]

# h=0.45
data_0.45_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.45_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.45_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.45_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.45_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.45_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.45_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.45_0.50.csv")[1,]
data_0.45 <- c(data_0.45_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.45_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.45_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.45_0.5$Likelihood)

# h=0.35
data_0.35_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.35_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.35_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.35_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.35_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.35_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.35_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.35_0.50.csv")[1,]
data_0.35 <- c(data_0.35_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.35_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.35_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.35_0.5$Likelihood)

# h=0.25
data_0.25_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.25_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.25_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.25_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.25_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.25_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.25_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.25_0.50.csv")[1,]
data_0.25 <- c(data_0.25_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.25_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.25_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.25_0.5$Likelihood)

# h=0.15
data_0.15_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.15_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.15_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.15_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.15_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.15_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.15_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.15_0.50.csv")[1,]
data_0.15 <- c(data_0.15_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.15_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.15_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.15_0.5$Likelihood)

# h=0.10
data_0.10_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.10_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.10_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.10_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.10_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.10_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.10_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.10_0.50.csv")[1,]
data_0.10 <- c(data_0.10_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.10_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.10_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.10_0.5$Likelihood)

# h=0.05
data_0.05_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.05_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.05_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.05_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.05_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.05_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.05_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.05_0.50.csv")[1,]
data_0.05 <- c(data_0.05_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.05_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.05_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.05_0.5$Likelihood)

# h = 0.0
data_0.00_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.00_0.50_0.50_0.50_0.50.csv")[1,]
data_0.50_0.00_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.00_0.50_0.50_0.50.csv")[1,]
data_0.5_0.5_0.00_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.00_0.50_0.50.csv")[1,]
data_0.5_0.5_0.5_0.00_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.00_0.50.csv")[1,]
data_0.00 <- c(data_0.00_0.5_0.5_0.5_0.5$Likelihood,data_0.50_0.00_0.5_0.5_0.5$Likelihood,data_0.5_0.5_0.00_0.5_0.5$Likelihood,data_0.5_0.5_0.5_0.00_0.5$Likelihood)


# subtract likelihood of additive model from all model likelihoods
plot_data <- rbind(data_0.45,data_0.35,data_0.25,data_0.15,data_0.10,data_0.05,data_0.00)-data_0.5_0.5_0.5_0.5_0.5$Likelihood




### plotting 

library(ggplot2)                       
library(reshape)                                               

# format data for plotting
data_melt <- melt(plot_data)

data_melt[data_melt == "1"] <- "(1e-2,0.5]"
data_melt[data_melt == "2"] <- "(1e-3,1e-2]"
data_melt[data_melt == "3"] <- "(1e-4,1e-3]"
data_melt[data_melt == "4"] <- "(1e-5,1e-4]"

data_melt$X1 <- as.character(data_melt$X1)
data_melt[data_melt == "data_0.45"] <- as.character("0.45")
data_melt[data_melt == "data_0.35"] <- as.character("0.35")
data_melt[data_melt == "data_0.25"] <- as.character("0.25")
data_melt[data_melt == "data_0.15"] <- as.character("0.15")
data_melt[data_melt == "data_0.10"] <- as.character("0.10")
data_melt[data_melt == "data_0.05"] <- as.character("0.05")
data_melt[data_melt == "data_0.00"] <- as.character("0.0")

data_melt <- data_melt[,ncol(data_melt):1 ] 


pdf("~/Documents/UCLA/dominance/analysis/plots/heatmap.pdf", width = 5, height = 3)

ggp <- ggplot(data_melt, aes(X2, X1)) +                         
  geom_tile(aes(fill = value)) + scale_fill_gradient(low = "red", high = "yellow") + 
  xlab("Selection coefficient bin") + ylab("Dominance coefficient (h)")  + theme_bw() + 
  scale_x_discrete(limits=c("(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]")) +
  labs(fill = expression(paste(Delta,"LL")))
ggp 

dev.off()





