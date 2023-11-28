
##### Read in data #####

setwd("~/Documents/UCLA/dominance/simulation_plotting/data/111323/")

### results for strongly recessive model
datafiles <- list.files(pattern="strRec_111323.o")

data_strRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 2062)
  data_strRec <- rbind(data_strRec,cbind(data,rep))
}

results_strRec <- data_strRec[which(data_strRec$gen==10920),]


### results for moderately recessive model
datafiles <- list.files(pattern="modRec_111323.o")

data_modRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 2062)
  data_modRec <- rbind(data_modRec,cbind(data,rep))
}

results_modRec <- data_modRec[which(data_modRec$gen==10920),]


### results for weakly recessive model
datafiles <- list.files(pattern="wkRec_111323.o")

data_wkRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 2062)
  data_wkRec <- rbind(data_wkRec,cbind(data,rep))
}

results_wkRec <- data_wkRec[which(data_wkRec$gen==10920),]


### results for additive/recessive model
datafiles <- list.files(pattern="addRec_111323.o")

data_addRec <- data.frame(matrix(nrow = 0, ncol = 17))

for(rep in seq_along(datafiles)){
  data <- read.table(datafiles[rep], sep=",", header=T, skip = 2062)
  data_addRec <- rbind(data_addRec,cbind(data,rep))
}

results_addRec <- data_addRec[which(data_addRec$gen==10920),]




##### Plotting #####


setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("load_boxplot.pdf", width=6, height=7)

# plot genetic load results

ymin=0.2
ymax=0.4

# multiplier based on how many chromosomes were simulated
multiplier <- 11


cols = c("#0072B2", "#D55E00")

par(mfrow=c(3,4), bty="n",mar=c(5,2,1,1))
boxplot(1-results_wkRec$meanFitness_AF^multiplier,1-results_wkRec$meanFitness_EU^multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Genetic load", main="Weakly Recessive", cex.main=1)

par(mar=c(5,1,1,1),bty="n")
boxplot(1-results_modRec$meanFitness_AF^multiplier,1-results_modRec$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Moderately Recessive", cex.main=1)

par(mar=c(5,1,1,1),bty="n")
boxplot(1-results_strRec$meanFitness_AF^multiplier,1-results_strRec$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Strongly Recessive", cex.main=1)

par(mar=c(5,1,1,1),bty="n")
boxplot(1-results_addRec$meanFitness_AF^multiplier,1-results_addRec$meanFitness_EU^multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Additive/Recessive", cex.main=1)


## plot inbreeding load 
ymin=0
ymax=12

cols = c("#0072B2", "#D55E00")

par(bty="n",mar=c(5,2,1,1))
boxplot(results_wkRec$B_AF*multiplier/2,results_wkRec$B_EU*multiplier/2, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (B)", main="Weakly Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot(results_modRec$B_AF*multiplier/2,results_modRec$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Moderately Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot(results_strRec$B_AF*multiplier/2,results_strRec$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Strongly Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot(results_addRec$B_AF*multiplier/2,results_addRec$B_EU*multiplier/2, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Additive/Recessive", cex.main=1)

## plot derived allele counts
ymin=1500
ymax=2500

par(bty="n",mar=c(5,2,1,1))

boxplot((results_wkRec$avgWkDel_AF+results_wkRec$avgModDel_AF+results_wkRec$avgStrDel_AF)*multiplier,(results_wkRec$avgWkDel_EU+results_wkRec$avgModDel_EU+results_wkRec$avgStrDel_AF)*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, main="Weakly Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot((results_modRec$avgWkDel_AF+results_modRec$avgModDel_AF+results_modRec$avgStrDel_AF)*multiplier,(results_modRec$avgWkDel_EU+results_modRec$avgModDel_EU+results_modRec$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Moderately Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot((results_strRec$avgWkDel_AF+results_strRec$avgModDel_AF+results_strRec$avgStrDel_AF)*multiplier,(results_strRec$avgWkDel_EU+results_strRec$avgModDel_EU+results_strRec$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Strongly Recessive", cex.main=1)

par(mar=c(5,1,1,1))
boxplot((results_addRec$avgWkDel_AF+results_addRec$avgModDel_AF+results_addRec$avgStrDel_AF)*multiplier,(results_addRec$avgWkDel_EU+results_addRec$avgModDel_EU+results_addRec$avgStrDel_AF)*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols, main="Additive/Recessive", cex.main=1)

dev.off()








mean(1-results_wkRec$meanFitness_EU^multiplier)/mean(1-results_wkRec$meanFitness_AF^multiplier)
mean(1-results_modRec$meanFitness_EU^multiplier)/mean(1-results_modRec$meanFitness_AF^multiplier)
mean(1-results_strRec$meanFitness_EU^multiplier)/mean(1-results_strRec$meanFitness_AF^multiplier)
mean(1-results_addRec$meanFitness_EU^multiplier)/mean(1-results_addRec$meanFitness_AF^multiplier)




mean(results_wkRec$B_AF*multiplier/2)
mean(results_wkRec$B_EU*multiplier/2)

mean(results_modRec$B_AF*multiplier/2)
mean(results_modRec$B_EU*multiplier/2)

mean(results_strRec$B_AF*multiplier/2)
mean(results_strRec$B_EU*multiplier/2)

mean(results_addRec$B_AF*multiplier/2)
mean(results_addRec$B_EU*multiplier/2)










# plot counts of weakly deleterious alleles
setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("wkDel_boxplot.pdf", width=5, height=3)

ymin=1200
ymax=2000

cols = c("#0072B2", "#D55E00")

par(mfrow=c(1,4), bty="n",mar=c(5,2,1,1))
boxplot(results_wkRec$avgWkDel_AF*multiplier,results_wkRec$avgWkDel_EU*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (2B)")

par(mar=c(5,1,1,1))
boxplot(results_modRec$avgWkDel_AF*multiplier,results_modRec$avgWkDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_strRec$avgWkDel_AF*multiplier,results_strRec$avgWkDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_addRec$avgWkDel_AF*multiplier,results_addRec$avgWkDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

dev.off()



# plot counts of moderately deleterious alleles
setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("modDel_boxplot.pdf", width=5, height=3)

ymin=100
ymax=600

cols = c("#0072B2", "#D55E00")

par(mfrow=c(1,4), bty="n",mar=c(5,2,1,1))
boxplot(results_wkRec$avgModDel_AF*multiplier,results_wkRec$avgModDel_EU*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (2B)")

par(mar=c(5,1,1,1))
boxplot(results_modRec$avgModDel_AF*multiplier,results_modRec$avgModDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_strRec$avgModDel_AF*multiplier,results_strRec$avgModDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_addRec$avgModDel_AF*multiplier,results_addRec$avgModDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

dev.off()



# plot counts of strongly deleterious alleles
setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("strDel_boxplot.pdf", width=5, height=3)

ymin=0
ymax=200

cols = c("#0072B2", "#D55E00")

par(mfrow=c(1,4), bty="n",mar=c(5,2,1,1))
boxplot(results_wkRec$avgStrDel_AF*multiplier,results_wkRec$avgStrDel_EU*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (2B)")

par(mar=c(5,1,1,1))
boxplot(results_modRec$avgStrDel_AF*multiplier,results_modRec$avgStrDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_strRec$avgStrDel_AF*multiplier,results_strRec$avgStrDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_addRec$avgStrDel_AF*multiplier,results_addRec$avgStrDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

dev.off()




# plot counts of very strongly deleterious alleles
setwd("~/Documents/UCLA/dominance/simulation_plotting/plots")
pdf("vstrDel_boxplot.pdf", width=5, height=3)

ymin=0
ymax=45

cols = c("#0072B2", "#D55E00")

par(mfrow=c(1,4), bty="n",mar=c(5,2,1,1))
boxplot(results_wkRec$avgvStrDel_AF*multiplier,results_wkRec$avgvStrDel_EU*multiplier, names = c("AF", "EU"), ylim =c(ymin,ymax), col = cols, ylab = "Inbreeding load (2B)")

par(mar=c(5,1,1,1))
boxplot(results_modRec$avgvStrDel_AF*multiplier,results_modRec$avgvStrDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_strRec$avgvStrDel_AF*multiplier,results_strRec$avgvStrDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

par(mar=c(5,1,1,1))
boxplot(results_addRec$avgvStrDel_AF*multiplier,results_addRec$avgvStrDel_EU*multiplier, yaxt = "n", names = c("AF", "EU"), ylim =c(ymin,ymax),col = cols)

dev.off()






