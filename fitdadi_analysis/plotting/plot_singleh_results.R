


setwd("~/Documents/UCLA/dominance/analysis/data/output")

discrete_0.0 <- read.csv("DFE_inference_discrete_h0.00_s0.25_constrained.csv")
discrete_0.05 <- read.csv("DFE_inference_discrete_h0.05_s0.25_constrained.csv")
discrete_0.10 <- read.csv("DFE_inference_discrete_h0.10_s0.25_constrained.csv")
discrete_0.15 <- read.csv("DFE_inference_discrete_h0.15_s0.25_constrained.csv")
discrete_0.25 <- read.csv("DFE_inference_discrete_h0.25_s0.25_constrained.csv")
discrete_0.35 <- read.csv("DFE_inference_discrete_h0.35_s0.25_constrained.csv")
discrete_0.45 <- read.csv("DFE_inference_discrete_h0.45_s0.25_constrained.csv")
discrete_0.50 <- read.csv("DFE_inference_discrete_h0.50_s0.25_constrained.csv")
discrete_0.75 <- read.csv("DFE_inference_discrete_h0.75_s0.25_constrained.csv")
discrete_1.0 <- read.csv("DFE_inference_discrete_h1.0_s0.25_constrained.csv")

### MLE appears to be in last row
discrete_0.0_MLE <- discrete_0.0[25,]
discrete_0.05_MLE <- discrete_0.05[25,]
discrete_0.10_MLE <- discrete_0.10[25,]
discrete_0.15_MLE <- discrete_0.15[25,]
discrete_0.25_MLE <- discrete_0.25[25,]
discrete_0.35_MLE <- discrete_0.35[25,]
discrete_0.45_MLE <- discrete_0.45[25,]
discrete_0.50_MLE <- discrete_0.50[25,]
discrete_0.75_MLE <- discrete_0.75[25,]
discrete_1.0_MLE <- discrete_1.0[25,]



### create side-by side plot of MLE and discrete DFE proportions
setwd("~/Documents/UCLA/dominance/analysis/plots/")
pdf("discrete_plot_s0.25.pdf", width = 14, height = 6)
par(mfrow=c(1,2), mar = c(4,4.5,1,1))


axis=1.2
lab=1.5

# plot MLE
LL <- c(discrete_0.0_MLE$Likelihood,
        discrete_0.05_MLE$Likelihood,
        discrete_0.10_MLE$Likelihood,
        discrete_0.15_MLE$Likelihood,
        discrete_0.25_MLE$Likelihood,
        discrete_0.35_MLE$Likelihood,
        discrete_0.45_MLE$Likelihood,
        discrete_0.50_MLE$Likelihood,
        discrete_0.75_MLE$Likelihood,
        discrete_1.0_MLE$Likelihood)

plot(1:10, LL-max(LL), xaxt='n', xlab="Dominance coefficient", ylab="Difference to MLE", pch=19, cex=1.3, cex.lab=lab, cex.axis=axis)
axis(1, at=1:10, labels=c("0.0","0.05","0.10","0.15","0.25","0.35","0.45","0.50","0.75","1.0"), cex.axis=axis)
abline(h=-1.92, col = 'blue', lty=2, lwd=3)


#plot bins
neut <- c(discrete_0.0_MLE$X0....s.....1e.5, discrete_0.05_MLE$X0....s.....1e.5, discrete_0.10_MLE$X0....s.....1e.5,discrete_0.15_MLE$X0....s.....1e.5,discrete_0.25_MLE$X0....s.....1e.5,discrete_0.35_MLE$X0....s.....1e.5,discrete_0.45_MLE$X0....s.....1e.5,discrete_0.50_MLE$X0....s.....1e.5,discrete_0.75_MLE$X0....s.....1e.5,discrete_1.0_MLE$X0....s.....1e.5 )
nneut <- c(discrete_0.0_MLE$X1e.5....s.....1e.4, discrete_0.05_MLE$X1e.5....s.....1e.4, discrete_0.10_MLE$X1e.5....s.....1e.4,discrete_0.15_MLE$X1e.5....s.....1e.4,discrete_0.25_MLE$X1e.5....s.....1e.4,discrete_0.35_MLE$X1e.5....s.....1e.4,discrete_0.45_MLE$X1e.5....s.....1e.4,discrete_0.50_MLE$X1e.5....s.....1e.4,discrete_0.75_MLE$X1e.5....s.....1e.4,discrete_1.0_MLE$X1e.5....s.....1e.4 )
wkdel <- c(discrete_0.0_MLE$X1e.4....s.....1e.3, discrete_0.05_MLE$X1e.4....s.....1e.3, discrete_0.10_MLE$X1e.4....s.....1e.3,discrete_0.15_MLE$X1e.4....s.....1e.3,discrete_0.25_MLE$X1e.4....s.....1e.3,discrete_0.35_MLE$X1e.4....s.....1e.3,discrete_0.45_MLE$X1e.4....s.....1e.3,discrete_0.50_MLE$X1e.4....s.....1e.3,discrete_0.75_MLE$X1e.4....s.....1e.3,discrete_1.0_MLE$X1e.4....s.....1e.3 )
moddel <- c(discrete_0.0_MLE$X1e.3....s.....1e.2, discrete_0.05_MLE$X1e.3....s.....1e.2, discrete_0.10_MLE$X1e.3....s.....1e.2,discrete_0.15_MLE$X1e.3....s.....1e.2,discrete_0.25_MLE$X1e.3....s.....1e.2,discrete_0.35_MLE$X1e.3....s.....1e.2,discrete_0.45_MLE$X1e.3....s.....1e.2,discrete_0.50_MLE$X1e.3....s.....1e.2,discrete_0.75_MLE$X1e.3....s.....1e.2,discrete_1.0_MLE$X1e.3....s.....1e.2 )
strdel <- c(discrete_0.0_MLE$X1e.2....s.....1, discrete_0.05_MLE$X1e.2....s.....1, discrete_0.10_MLE$X1e.2....s.....1,discrete_0.15_MLE$X1e.2....s.....1,discrete_0.25_MLE$X1e.2....s.....1,discrete_0.35_MLE$X1e.2....s.....1,discrete_0.45_MLE$X1e.2....s.....1,discrete_0.50_MLE$X1e.2....s.....1,discrete_0.75_MLE$X1e.2....s.....1,discrete_1.0_MLE$X1e.2....s.....1 )

bars <- cbind(neut, nneut, wkdel, moddel, strdel)

library(RColorBrewer)
cols <- brewer.pal(n = 10, name = "Spectral")

barplot(bars, beside=T, xlab = "Selection coefficient bin", ylab = "Proportion",cex.axis=axis, cex.lab=lab, 
        names.arg = c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"), col = cols, cex.names = 1.0, ylim=c(0,0.6))
#legend("topleft",  fill = cols, c("0.0","0.05","0.10","0.15","0.25","0.35","0.45","0.50","0.75","1.0"), cex=1.3, bty="n")

dev.off()








### redo for gamma DFE

setwd("~/Documents/UCLA/dominance/analysis/data/output")

gamma_0.0 <- read.csv("DFE_inference_gamma_h0.00_s0.25.csv")
gamma_0.0 <- gamma_0.0[order(gamma_0.0$Likelihood),]
gamma_0.05 <- read.csv("DFE_inference_gamma_h0.05_s0.25.csv")
gamma_0.05 <- gamma_0.05[order(gamma_0.05$Likelihood),]
gamma_0.10 <- read.csv("DFE_inference_gamma_h0.10_s0.25.csv")
gamma_0.10 <- gamma_0.10[order(gamma_0.10$Likelihood),]
gamma_0.15 <- read.csv("DFE_inference_gamma_h0.15_s0.25.csv")
gamma_0.15 <- gamma_0.15[order(gamma_0.15$Likelihood),]
gamma_0.25 <- read.csv("DFE_inference_gamma_h0.25_s0.25.csv")
gamma_0.25 <- gamma_0.25[order(gamma_0.25$Likelihood),]
gamma_0.35 <- read.csv("DFE_inference_gamma_h0.35_s0.25.csv")
gamma_0.35 <- gamma_0.35[order(gamma_0.35$Likelihood),]
gamma_0.45 <- read.csv("DFE_inference_gamma_h0.45_s0.25.csv")
gamma_0.45 <- gamma_0.45[order(gamma_0.45$Likelihood),]
gamma_0.50 <- read.csv("DFE_inference_gamma_h0.50_s0.25.csv")
gamma_0.50 <- gamma_0.50[order(gamma_0.50$Likelihood),]
gamma_0.75 <- read.csv("DFE_inference_gamma_h0.75_s0.25.csv")
gamma_0.75 <- gamma_0.75[order(gamma_0.75$Likelihood),]
gamma_1.0 <- read.csv("DFE_inference_gamma_h1.0_s0.25.csv")
gamma_1.0 <- gamma_1.0[order(gamma_1.0$Likelihood),]

### MLE appears to be in last row
gamma_0.0_MLE <- gamma_0.0[25,]
gamma_0.05_MLE <- gamma_0.05[25,]
gamma_0.10_MLE <- gamma_0.10[25,]
gamma_0.15_MLE <- gamma_0.15[25,]
gamma_0.25_MLE <- gamma_0.25[25,]
gamma_0.35_MLE <- gamma_0.35[25,]
gamma_0.45_MLE <- gamma_0.45[25,]
gamma_0.50_MLE <- gamma_0.50[25,]
gamma_0.75_MLE <- gamma_0.75[25,]
gamma_1.0_MLE <- gamma_1.0[25,]



### create side-by side plot of MLE and gamma DFE proportions
setwd("~/Documents/UCLA/dominance/analysis/plots/")
pdf("gamma_plot_s0.25.pdf", width = 14, height = 6)
par(mfrow=c(1,2), mar = c(4,4.5,1,1))


axis=1.2
lab=1.5

# plot MLE
LL <- c(gamma_0.0_MLE$Likelihood,
        gamma_0.05_MLE$Likelihood,
        gamma_0.10_MLE$Likelihood,
        gamma_0.15_MLE$Likelihood,
        gamma_0.25_MLE$Likelihood,
        gamma_0.35_MLE$Likelihood,
        gamma_0.45_MLE$Likelihood,
        gamma_0.50_MLE$Likelihood,
        gamma_0.75_MLE$Likelihood,
        gamma_1.0_MLE$Likelihood)

plot(1:10, LL-max(LL), xaxt='n', xlab="Dominance coefficient", ylab="Difference to MLE", pch=19, cex=1.3, cex.lab=lab, cex.axis=axis)
axis(1, at=1:10, labels=c("0.0","0.05","0.10","0.15","0.25","0.35","0.45","0.50","0.75","1.0"), cex.axis=axis)
abline(h=-1.92, col = 'blue', lty=2, lwd=3)


#plot bins

h_0.0 <- calc_bins_from_gamma(gamma_0.0_MLE$alpha, gamma_0.0_MLE$beta)
h_0.05 <- calc_bins_from_gamma(gamma_0.05_MLE$alpha, gamma_0.05_MLE$beta)
h_0.10 <- calc_bins_from_gamma(gamma_0.10_MLE$alpha, gamma_0.10_MLE$beta)
h_0.15 <- calc_bins_from_gamma(gamma_0.15_MLE$alpha, gamma_0.15_MLE$beta)
h_0.25 <- calc_bins_from_gamma(gamma_0.25_MLE$alpha, gamma_0.25_MLE$beta)
h_0.35 <- calc_bins_from_gamma(gamma_0.35_MLE$alpha, gamma_0.35_MLE$beta)
h_0.45 <- calc_bins_from_gamma(gamma_0.45_MLE$alpha, gamma_0.45_MLE$beta)
h_0.50 <- calc_bins_from_gamma(gamma_0.50_MLE$alpha, gamma_0.50_MLE$beta)
h_0.75 <- calc_bins_from_gamma(gamma_0.75_MLE$alpha, gamma_0.75_MLE$beta)
h_1.0 <- calc_bins_from_gamma(gamma_1.0_MLE$alpha, gamma_1.0_MLE$beta)


bars <- rbind(h_0.0, h_0.05, h_0.10, h_0.15, h_0.25, h_0.35, h_0.45, h_0.50, h_0.75, h_1.0)

library(RColorBrewer)
cols <- brewer.pal(n = 10, name = "Spectral")

barplot(bars, beside=T, xlab = "Selection coefficient bin", ylab = "Proportion",cex.axis=axis, cex.lab=lab, 
        names.arg = c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"), col = cols, cex.names = 1.0, ylim=c(0,0.6))
legend("topleft",  fill = cols, c("0.0","0.05","0.10","0.15","0.25","0.35","0.45","0.50","0.75","1.0"), cex=1.3, bty="n")

dev.off()




calc_bins_from_gamma <- function(shape, scale){
  
  Nanc = 5988.523836998993/(4*1.5e-8*8058343)
  mean = scale*shape/Nanc
  print(mean)
  g <- rgamma(n=1000000,shape = shape, scale= scale/Nanc)

  neut <- g[g <1e-5]
  bin1 <- length(neut)/length(g)
  
  nneut <- g[g<1e-4 & g >1e-5]
  bin2 <- length(nneut)/length(g)
  
  wkdel <- g[g<0.001 & g >1e-4]
  bin3 <- length(wkdel)/length(g)
  
  moddel <- g[g>0.001 & g <0.01]
  bin4 <- length(moddel)/length(g)
  
  strdel <- g[g>0.01]
  bin5 <- length(strdel)/length(g)

  return(c(bin1,bin2,bin3,bin4,bin5))
}








