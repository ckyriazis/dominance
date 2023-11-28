






data_h0.0_s0.1 <- c(-1478.1073356017878,0.2841298043460863,3.255773374730009e-11,0.2657483172967277,0.3653499613641878,0.0847719169604409)


data_h0.0_s0.25 <- c(-1478.7481604050208,0.28388174770190294,1.4743789129997923e-11,0.2665735513182005,0.35967486682124544,0.08986983414390741)

data_h0.0_s0.5 <- c(-1478.9355732799163,0.28382617138998045,1.03362964779169e-11,0.2668525626960354,0.3578595196480874,0.09146174625556076)



LL <- c(data_h0.0_s0.1[1],data_h0.0_s0.25[1],data_h0.0_s0.5[1])



pdf("~/Documents/UCLA/dominance/analysis/plots/s_limit_comparison_plot.pdf", height = 8, width = 7)
par(mfrow=c(2,1), mar = c(4,4.5,2,2))

axis=1.1
lab=1.3
points=1.3
library(RColorBrewer) 
cols <- brewer.pal(n = 3, name = "Set1")

## plot likelihood
plot(1:3, LL-max(LL), xaxt='n', xlab="Model", ylab="LL units from MLE", pch=19, cex=points, cex.lab=lab, cex.axis=axis, col=cols, ylim=c(-10,0))
axis(1, at=1:3, labels=c("s=0.1","s=0.25","s=0.5"), cex.axis=axis)
legend("bottomright",  fill = cols, c("s=0.1","s=0.25","s=0.5"), cex=1, bty="n")

## plot s bins
plot_data <- rbind(data_h0.0_s0.1[2:6],data_h0.0_s0.25[2:6],data_h0.0_s0.5[2:6])
barplot(as.matrix(plot_data), beside=T, col = cols, ylab="Proportion", xlab = "Selection coefficient bin", names =c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"),cex.lab=lab,cex.names=1)
legend("topright",  fill = cols, c("s=0.1","s=0.25","s=0.5"), cex=1, bty="n")

dev.off()





