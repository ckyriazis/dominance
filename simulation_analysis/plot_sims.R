


##### Read in data #####

setwd("~/Documents/UCLA/dominance/simulation_plotting/data/021424/")

### results for strongly recessive model
datafiles <- list.files(pattern="strRec_021424.o")

data_strRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 11269)
  data_strRec <- rbind(data_strRec,cbind(data,rep))
}

results_strRec <- data_strRec[which(data_strRec$gen==10920),]


### results for moderately recessive model
datafiles <- list.files(pattern="modRec_021424.o")

data_modRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 11269)
  data_modRec <- rbind(data_modRec,cbind(data,rep))
}

results_modRec <- data_modRec[which(data_modRec$gen==10920),]


### results for weakly recessive model
datafiles <- list.files(pattern="wkRec_021424.o")

data_wkRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 11269)
  data_wkRec <- rbind(data_wkRec,cbind(data,rep))
}

results_wkRec <- data_wkRec[which(data_wkRec$gen==10920),]




##### Plotting #####


setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("load_boxplot.pdf", width=6, height=7)

# plot genetic load results

ymin=0.32
ymax=0.38

# multiplier based on how many chromosomes were simulated
multiplier <- 2


cols = c("#0072B2", "#D55E00")

par(mfrow=c(3,3), bty="n",mar=c(5,2,1,1))
boxplot(1-results_wkRec$meanFitness_AF^multiplier,1-results_wkRec$meanFitness_EU^multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Genetic load", main="Weakly Recessive", cex.main=1)

par(mar=c(5,1,1,1),bty="n")
boxplot(1-results_modRec$meanFitness_AF^multiplier,1-results_modRec$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Moderately Recessive", cex.main=1)

par(mar=c(5,1,1,1),bty="n")
boxplot(1-results_strRec$meanFitness_AF^multiplier,1-results_strRec$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Strongly Recessive", cex.main=1)

#par(mar=c(5,1,1,1),bty="n")
#boxplot(1-results_addRec$meanFitness_AF^multiplier,1-results_addRec$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Additive/Recessive", cex.main=1)


## plot inbreeding load 
ymin=0
ymax=2.5

cols = c("#0072B2", "#D55E00")

par(bty="n",mar=c(5,2,1,1))
boxplot(results_wkRec$B_AF*multiplier/2,results_wkRec$B_EU*multiplier/2, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (B)", main="Weakly Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot(results_modRec$B_AF*multiplier/2,results_modRec$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Moderately Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot(results_strRec$B_AF*multiplier/2,results_strRec$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Strongly Recessive", cex.main=1)

#par(mar=c(5,1,1,1))
#boxplot(results_addRec$B_AF*multiplier/2,results_addRec$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Additive/Recessive", cex.main=1)

## plot derived allele counts
ymin=1700
ymax=2200

par(bty="n",mar=c(5,2,1,1))

boxplot((results_wkRec$avgWkDel_AF+results_wkRec$avgModDel_AF+results_wkRec$avgStrDel_AF)*multiplier,(results_wkRec$avgWkDel_EU+results_wkRec$avgModDel_EU+results_wkRec$avgStrDel_AF)*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, main="Weakly Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot((results_modRec$avgWkDel_AF+results_modRec$avgModDel_AF+results_modRec$avgStrDel_AF)*multiplier,(results_modRec$avgWkDel_EU+results_modRec$avgModDel_EU+results_modRec$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Moderately Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot((results_strRec$avgWkDel_AF+results_strRec$avgModDel_AF+results_strRec$avgStrDel_AF)*multiplier,(results_strRec$avgWkDel_EU+results_strRec$avgModDel_EU+results_strRec$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Strongly Recessive", cex.main=1)

#par(mar=c(5,1,1,1))
#boxplot((results_addRec$avgWkDel_AF+results_addRec$avgModDel_AF+results_addRec$avgStrDel_AF)*multiplier,(results_addRec$avgWkDel_EU+results_addRec$avgModDel_EU+results_addRec$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Additive/Recessive", cex.main=1)

dev.off()




# genetic load under weakly recessive model
genLoad_wkRec_EU <- mean(1-results_wkRec$meanFitness_EU^multiplier)
genLoad_wkRec_AF <- mean(1-results_wkRec$meanFitness_AF^multiplier)

# genetic load under moderately recessive model
genLoad_modRec_EU <- mean(1-results_modRec$meanFitness_EU^multiplier)
genLoad_modRec_AF <- mean(1-results_modRec$meanFitness_AF^multiplier)

# genetic load under strongly recessive model
genLoad_strRec_EU <- mean(1-results_strRec$meanFitness_EU^multiplier)
genLoad_strRec_AF <- mean(1-results_strRec$meanFitness_AF^multiplier)


# calculate % change
(genLoad_wkRec_EU-genLoad_wkRec_AF)/genLoad_wkRec_AF
(genLoad_modRec_EU-genLoad_modRec_AF)/genLoad_modRec_AF
(genLoad_strRec_EU-genLoad_strRec_AF)/genLoad_strRec_AF




# inbreeding load under weakly recessive model
inbLoad_wkRec_EU <-mean(results_wkRec$B_EU*multiplier/2)
inbLoad_wkRec_AF <- mean(results_wkRec$B_AF*multiplier/2)

# inbreeding load under moderately recessive model
inbLoad_modRec_EU <- mean(results_modRec$B_EU*multiplier/2)
inbLoad_modRec_AF <- mean(results_modRec$B_AF*multiplier/2)

# inbreeding load under strongly recessive model
inbLoad_strRec_EU <- mean(results_strRec$B_EU*multiplier/2)
inbLoad_strRec_AF <- mean(results_strRec$B_AF*multiplier/2)

# calculate % change
(inbLoad_wkRec_EU-inbLoad_wkRec_AF)/inbLoad_wkRec_AF
(inbLoad_modRec_EU-inbLoad_modRec_AF)/inbLoad_modRec_AF
(inbLoad_strRec_EU-inbLoad_strRec_AF)/inbLoad_strRec_AF



# derived allele count under weakly recessive model
derAllele_wkRec_EU <- mean((results_wkRec$avgWkDel_EU+results_wkRec$avgModDel_EU+results_wkRec$avgStrDel_EU)*multiplier)
derAllele_wkRec_AF <- mean((results_wkRec$avgWkDel_AF+results_wkRec$avgModDel_AF+results_wkRec$avgStrDel_AF)*multiplier)

# derived allele count under moderately recessive model
derAllele_modRec_EU <- mean((results_modRec$avgWkDel_EU+results_modRec$avgModDel_EU+results_modRec$avgStrDel_EU)*multiplier)
derAllele_modRec_AF <- mean((results_modRec$avgWkDel_AF+results_modRec$avgModDel_AF+results_modRec$avgStrDel_AF)*multiplier)

# derived allele count under strongly recessive model
derAllele_strRec_EU <- mean((results_strRec$avgWkDel_EU+results_strRec$avgModDel_EU+results_strRec$avgStrDel_EU)*multiplier)
derAllele_strRec_AF <- mean((results_strRec$avgWkDel_AF+results_strRec$avgModDel_AF+results_strRec$avgStrDel_AF)*multiplier)


# calculate % change
(derAllele_wkRec_EU-derAllele_wkRec_AF)/derAllele_wkRec_AF
(derAllele_modRec_EU-derAllele_modRec_AF)/derAllele_modRec_AF
(derAllele_strRec_EU-derAllele_strRec_AF)/derAllele_strRec_AF








### compare models with fixed h to models with variable h

### results for strongly recessive model with variable h
setwd("~/Documents/UCLA/dominance/simulation_plotting/data/021424/")
datafiles <- list.files(pattern="strRec_variableH_021424.o")

data_strRec_variableH <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 11269)
  data_strRec_variableH <- rbind(data_strRec_variableH,cbind(data,rep))
}

results_strRec_variableH <- data_strRec_variableH[which(data_strRec_variableH$gen==10920),]



setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("load_boxplot_variableH.pdf", width=5, height=6)

# plot genetic load results

ymin=0.32
ymax=0.36

# multiplier based on how many chromosomes were simulated
multiplier <- 2


cols = c("#0072B2", "#D55E00")

par(mfrow=c(3,2), bty="n",mar=c(5,2,1,1))
boxplot(1-results_strRec$meanFitness_AF^multiplier,1-results_strRec$meanFitness_EU^multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Genetic load", main="Fixed h", cex.main=1)

par(mar=c(5,1,1,1),bty="n")
boxplot(1-results_strRec_variableH$meanFitness_AF^multiplier,1-results_strRec_variableH$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Variable h", cex.main=1)


## plot inbreeding load 
ymin=1
ymax=4.5

cols = c("#0072B2", "#D55E00")

par(bty="n",mar=c(5,2,1,1))
boxplot(results_strRec$B_AF*multiplier/2,results_strRec$B_EU*multiplier/2, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (B)", main="Fixed h", cex.main=1)

par(mar=c(5,1,1,1))
boxplot(results_strRec_variableH$B_AF*multiplier/2,results_strRec_variableH$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Variable h", cex.main=1)


## plot derived allele counts
ymin=1900
ymax=2300

par(bty="n",mar=c(5,2,1,1))

boxplot((results_strRec$avgWkDel_AF+results_strRec$avgModDel_AF+results_strRec$avgStrDel_AF)*multiplier,(results_strRec$avgWkDel_EU+results_strRec$avgModDel_EU+results_strRec$avgStrDel_AF)*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, main="Fixed h", cex.main=1)

par(mar=c(5,1,1,1))
boxplot((results_strRec_variableH$avgWkDel_AF+results_strRec_variableH$avgModDel_AF+results_strRec_variableH$avgStrDel_AF)*multiplier,(results_strRec_variableH$avgWkDel_EU+results_strRec_variableH$avgModDel_EU+results_strRec_variableH$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Variable h", cex.main=1)


dev.off()



