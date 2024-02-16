
### read in empirical SFS from 1000G data
setwd("~/Documents/UCLA/dominance/analysis/data")
sfs_1kg <- scan("1kg_nonsyn.txt")
sfs_1kg <- c(sfs_1kg[1:9], sum(sfs_1kg[10:length(sfs_1kg)]))


### read in SFS from discrete model
setwd("~/Documents/UCLA/dominance/analysis/data/output/")

sfs_discrete_0.0 <- scan("SFS_discrete_h0.00_s0.25.txt")
sfs_discrete_0.0 <- c(sfs_discrete_0.0[1:9], sum(sfs_discrete_0.0[10:863]))

sfs_discrete_0.05 <- scan("SFS_discrete_h0.05_s0.25.txt")
sfs_discrete_0.05 <- c(sfs_discrete_0.05[1:9], sum(sfs_discrete_0.05[10:863]))

sfs_discrete_0.10 <- scan("SFS_discrete_h0.10_s0.25.txt")
sfs_discrete_0.10 <- c(sfs_discrete_0.10[1:9], sum(sfs_discrete_0.10[10:863]))

sfs_discrete_0.15 <- scan("SFS_discrete_h0.15_s0.25.txt")
sfs_discrete_0.15 <- c(sfs_discrete_0.15[1:9], sum(sfs_discrete_0.15[10:863]))

sfs_discrete_0.25 <- scan("SFS_discrete_h0.25_s0.25.txt")
sfs_discrete_0.25 <- c(sfs_discrete_0.25[1:9], sum(sfs_discrete_0.25[10:863]))

sfs_discrete_0.35 <- scan("SFS_discrete_h0.35_s0.25.txt")
sfs_discrete_0.35 <- c(sfs_discrete_0.35[1:9], sum(sfs_discrete_0.35[10:863]))

sfs_discrete_0.45 <- scan("SFS_discrete_h0.45_s0.25.txt")
sfs_discrete_0.45 <- c(sfs_discrete_0.45[1:9], sum(sfs_discrete_0.45[10:863]))

sfs_discrete_0.50 <- scan("SFS_discrete_h0.50_s0.25.txt")
sfs_discrete_0.50 <- c(sfs_discrete_0.50[1:9], sum(sfs_discrete_0.50[10:863]))

sfs_discrete_0.75 <- scan("SFS_discrete_h0.75_s0.25.txt")
sfs_discrete_0.75 <- c(sfs_discrete_0.75[1:9], sum(sfs_discrete_0.75[10:863]))

sfs_discrete_1.0 <- scan("SFS_discrete_h1.0_s0.25.txt")
sfs_discrete_1.0 <- c(sfs_discrete_1.0[1:9], sum(sfs_discrete_1.0[10:863]))


data_discrete <- rbind(sfs_1kg, sfs_discrete_0.0, sfs_discrete_0.05, sfs_discrete_0.10, sfs_discrete_0.15, sfs_discrete_0.25, sfs_discrete_0.35, sfs_discrete_0.45, sfs_discrete_0.50, sfs_discrete_0.75, sfs_discrete_1.0)



### plot discrete SFS vs empirical
setwd("~/Documents/UCLA/dominance/analysis/plots/")
pdf("SFS_discrete_s0.25.pdf", width = 8, height = 6)

library(RColorBrewer)
cols <- c(brewer.pal(n = 11, name = "Spectral"))

barplot(data_discrete, beside = T, col = cols, ylab = "Count", xlab = "SNP frequency", names.arg = 1:10, cex.axis=1.3, cex.names = 1.3, cex.lab = 1.5, main = "SFS for discrete model")
legend("topright",  fill = cols, c("1000G", "0.0","0.05","0.10","0.15","0.25","0.35","0.45","0.50","0.75","1.0"), cex=1.1, bty="n")

dev.off()




### read in SFS from gamma model
setwd("~/Documents/UCLA/dominance/analysis/data/output/")

sfs_gamma_0.0 <- scan("SFS_gamma_h0.00_s0.25.txt")
sfs_gamma_0.0 <- c(sfs_gamma_0.0[1:9], sum(sfs_gamma_0.0[10:863]))

sfs_gamma_0.05 <- scan("SFS_gamma_h0.05_s0.25.txt")
sfs_gamma_0.05 <- c(sfs_gamma_0.05[1:9], sum(sfs_gamma_0.05[10:863]))

sfs_gamma_0.10 <- scan("SFS_gamma_h0.10_s0.25.txt")
sfs_gamma_0.10 <- c(sfs_gamma_0.10[1:9], sum(sfs_gamma_0.10[10:863]))

sfs_gamma_0.15 <- scan("SFS_gamma_h0.15_s0.25.txt")
sfs_gamma_0.15 <- c(sfs_gamma_0.15[1:9], sum(sfs_gamma_0.15[10:863]))

sfs_gamma_0.25 <- scan("SFS_gamma_h0.25_s0.25.txt")
sfs_gamma_0.25 <- c(sfs_gamma_0.25[1:9], sum(sfs_gamma_0.25[10:863]))

sfs_gamma_0.35 <- scan("SFS_gamma_h0.35_s0.25.txt")
sfs_gamma_0.35 <- c(sfs_gamma_0.35[1:9], sum(sfs_gamma_0.35[10:863]))

sfs_gamma_0.45 <- scan("SFS_gamma_h0.45_s0.25.txt")
sfs_gamma_0.45 <- c(sfs_gamma_0.45[1:9], sum(sfs_gamma_0.45[10:863]))

sfs_gamma_0.50 <- scan("SFS_gamma_h0.50_s0.25.txt")
sfs_gamma_0.50 <- c(sfs_gamma_0.50[1:9], sum(sfs_gamma_0.50[10:863]))

sfs_gamma_0.75 <- scan("SFS_gamma_h0.75_s0.25.txt")
sfs_gamma_0.75 <- c(sfs_gamma_0.75[1:9], sum(sfs_gamma_0.75[10:863]))

sfs_gamma_1.0 <- scan("SFS_gamma_h1.0_s0.25.txt")
sfs_gamma_1.0 <- c(sfs_gamma_1.0[1:9], sum(sfs_gamma_1.0[10:863]))


data_gamma <- rbind(sfs_1kg, sfs_gamma_0.0, sfs_gamma_0.05, sfs_gamma_0.10, sfs_gamma_0.15, sfs_gamma_0.25, sfs_gamma_0.35, sfs_gamma_0.45, sfs_gamma_0.50, sfs_gamma_0.75, sfs_gamma_1.0)



### plot gamma SFS vs empirical
setwd("~/Documents/UCLA/dominance/analysis/plots/")
pdf("SFS_gamma_s0.25.pdf", width = 8, height = 6)

library(RColorBrewer)
cols <- c(brewer.pal(n = 11, name = "Spectral"))

barplot(data_gamma, beside = T, col = cols, ylab = "Count", xlab = "SNP frequency", names.arg = 1:10, cex.axis=1.3, cex.names = 1.3, cex.lab = 1.5, main = "SFS for gamma model")
legend("topright",  fill = cols, c("1000G", "0.0","0.05","0.10","0.15","0.25","0.35","0.45","0.50","0.75","1.0"), cex=1.1, bty="n")

dev.off()



