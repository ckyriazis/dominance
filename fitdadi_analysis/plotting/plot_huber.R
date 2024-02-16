


setwd("~/Documents/UCLA/dominance/analysis/data/output_hs/")


data_0.5_0.5_0.5_0.5_0.5 <- read.csv("DFE_inference_discrete_0.50_0.50_0.50_0.50_0.50.csv")[1,]

data_0.05_0.15_0.25_0.35_0.50 <- read.csv("DFE_inference_discrete_0.05_0.15_0.25_0.35_0.50.csv")[1,]


huber <- c(-1465.1997563335158,0.31974879499535863,1.6826017331232934e-11,0.24133603663958464,0.34051287930776253,0.09840228904046815,0.8,0.3,0.05,0.0,0.0)

LL <- c(data_0.5_0.5_0.5_0.5_0.5$Likelihood,data_0.05_0.15_0.25_0.35_0.50$Likelihood,huber[1])



pdf("~/Documents/UCLA/dominance/analysis/plots/huber_comparison_plot.pdf", height = 7, width = 4.5)
par(mfrow=c(3,1), mar = c(4,4.5,2,2))

axis=1.1
lab=1.3
points=1.3
library(RColorBrewer)
cols <- brewer.pal(n = 3, name = "Set2")

## plot h values
plot(1:5, data_0.5_0.5_0.5_0.5_0.5[7:11], ylim=c(0,0.9), col = cols[1], pch=19, xaxt='n', xlab = "Selection coefficient bin", ylab = "Dominance coefficient (h)", cex=points, cex.lab=lab)
lines(1:5,data_0.5_0.5_0.5_0.5_0.5[7:11], col=cols[1])
axis(1, at=1:5, labels=c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"), cex.axis=axis)
points(1:5, data_0.05_0.15_0.25_0.35_0.50[7:11], col = cols[2], pch=19, cex=points)
lines(1:5,data_0.05_0.15_0.25_0.35_0.50[7:11], col=cols[2])
points(1:5, huber[7:11], col = cols[3], pch=19, cex=points)
lines(1:5,huber[7:11], col=cols[3])
legend("bottomleft",  fill = cols, c("additive","monotonic","huber2018"), cex=1, bty="n")


## plot likelihood
plot(1:3, LL-max(LL), xaxt='n', xlab="Model", ylab="LL units from additive", pch=19, cex=points, cex.lab=lab, cex.axis=axis, col=cols)
axis(1, at=1:3, labels=c("additive", "monotonic","huber2018"), cex.axis=axis)

## plot s bins
plot_data <- rbind(data_0.5_0.5_0.5_0.5_0.5[2:6],data_0.05_0.15_0.25_0.35_0.50[2:6],huber[2:6])
barplot(as.matrix(plot_data), beside=T, col = cols, ylab="Proportion", xlab = "Selection coefficient bin", names =c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"),cex.lab=lab,cex.names=1)
legend("topright",  fill = cols, c("additive","monotonic","huber2018"), cex=1, bty="n")

dev.off()





