#R code to make a plot of h--s models that could be compatible with the SFS

setwd("~/Documents/UCLA/dominance/analysis/data/output_hs/")

datafiles <- list.files(pattern="DFE_inference_discrete_s0.25_")

## read in data
data <- data.frame(matrix(nrow = 0, ncol = 11))

for(rep in seq_along(datafiles)){
  tmp <- read.table(datafiles[rep], sep=",", header=T)
  data <- rbind(data,tail(tmp, n=1))
}



# Plotting functions
#plot the values of h that can work:
dominance_plot <- function(data, main_text, axis, labels){
  plot(c(1,2,3,4,5),data[1,7:11],col=8,ylab="Dominance coefficient (h)",xlab="Selection coefficient bin",type="l", main=main_text, xaxt="n",cex.axis=axis, cex.lab=labels, cex.main=1.5, ylim=c(0,0.5))
  for(i in c(2:length(data[,1])))
  {
    lines(c(1,2,3,4,5),data[i,7:11],col=8)
  }
  axis(1, at=1:5, labels=c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"), cex.axis=1.05)
}


proportion_plot <- function(data, axis, labels){
  #now plot the proportions of s: 
  #plot the values of h that can work:
  plot(c(1,2,3,4,5),data[1,2:6],col=8,ylim=c(0,0.5),ylab="Proportion of new mutations",xlab="Selection coefficient bin",type="l", xaxt="n", cex.axis=axis, cex.lab=labels, cex.main=1.5)
  for(i in c(2:length(data[,1])))
  {
    lines(c(1,2,3,4,5),data[i,2:6],col=8)
  }
  axis(1, at=1:5, labels=c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]"), cex.axis=1.05)
}




# find models that are close to the best fitting model
max_like <-  max(data$Likelihood)
cutoff<-max_like-qchisq(0.05, 1, lower.tail=FALSE)/2
data_highLL<-subset(data,data[,1]>cutoff)


#now, pull out monotonic:
keep<-rep(0,length(data_highLL[,1]))
for(i in c(1:length(data_highLL[,1])))
{
	if(data_highLL$h4[i]>=data_highLL$h3[i] && data_highLL$h3[i]>=data_highLL$h2[i] && data_highLL$h4[i]>data_highLL$h1[i])
	{
		
		keep[i]<-1
	}
}
data_tmp<-cbind(data_highLL,keep)
data_highLL_monotonic<-subset(data_tmp,data_tmp$keep==1)




pdf("~/Documents/UCLA/dominance/analysis/plots/plot_hs_models_s0.25.pdf", width = 12, height = 10)
par(mfrow=c(3,3),mar = c(5,5,2,1))

names <- c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]")
lab <- 1.5
axis <- 1.3


# Not excluding models at all:
dominance_plot(data, main_text = paste("All models, n =",nrow(data)), axis, lab)
proportion_plot(data,axis, lab)
hist(data$Likelihood, xlab="Log-likelihood",main="",xlim=c(min(data$Likelihood), max(data$Likelihood)+5), cex.axis=axis, cex.lab=lab)
abline(v = -1452.969, col="red", lwd=3, lty=2)

# Excluding models based on their loglikelihoods:
dominance_plot(data_highLL, main_text = paste("Models 1.92 LL away from MLE, n =",nrow(data_highLL)), axis, lab)
proportion_plot(data_highLL, axis, lab)
hist(data_highLL$Likelihood, xlab="Log-likelihood",main="", xlim=c(min(data_highLL$Likelihood)-3, max(data_highLL$Likelihood)+3), cex.axis=axis, cex.lab=lab)
abline(v = -1452.969, col="red", lwd=3, lty=2)

# Excluding models based on the conditions that we should have a monotonic decrease
dominance_plot(data_highLL_monotonic, main_text = paste("Models with monotonic decay of h, n =",nrow(data_highLL_monotonic)), axis, lab)
proportion_plot(data_highLL_monotonic, axis, lab)
hist(data_highLL_monotonic$Likelihood, xlab="Log-likelihood",main="", xlim=c(min(data_highLL_monotonic$Likelihood)-3, max(data_highLL_monotonic$Likelihood)+3), cex.axis=axis, cex.lab=lab)
abline(v = -1452.969, col="red", lwd=3, lty=2)


dev.off()




##### MODEL AVERAGING RESULTS #####


### model averaging for all models
data$AIC <- 2*4-2*data$Likelihood

data$deltaAIC <- data$AIC - min(data$AIC)

avg_h_nneut <- sum(data$h4*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_h_wkdel <- sum(data$h3*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_h_moddel <- sum(data$h2*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_h_strdel <- sum(data$h1*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))

avg_prop_neut <- sum(data$neut*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_prop_nneut <- sum(data$nneut*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_prop_wkdel <- sum(data$wkdel*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_prop_moddel <- sum(data$moddel*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))
avg_prop_strdel <- sum(data$strdel*exp(-1/(2*data$deltaAIC)))/sum(exp(-1/(2*data$deltaAIC)))

# overall average h for all models
0.5*avg_prop_neut+avg_h_nneut*avg_prop_nneut+avg_h_wkdel*avg_prop_wkdel+avg_h_moddel*avg_prop_moddel+avg_h_strdel*avg_prop_strdel



### model averaging for high LL models
data_highLL$AIC <- 2*4-2*data_highLL$Likelihood

data_highLL$deltaAIC <- data_highLL$AIC - min(data_highLL$AIC)

avg_h_nneut_highLL <- sum(data_highLL$h4*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_h_wkdel_highLL <- sum(data_highLL$h3*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_h_moddel_highLL <- sum(data_highLL$h2*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_h_strdel_highLL <- sum(data_highLL$h1*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))

avg_prop_neut_highLL <- sum(data_highLL$neut*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_prop_nneut_highLL <- sum(data_highLL$nneut*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_prop_wkdel_highLL <- sum(data_highLL$wkdel*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_prop_moddel_highLL <- sum(data_highLL$moddel*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))
avg_prop_strdel_highLL <- sum(data_highLL$strdel*exp(-1/(2*data_highLL$deltaAIC)))/sum(exp(-1/(2*data_highLL$deltaAIC)))

# overall average h for high LL models
0.5*avg_prop_neut_highLL+avg_h_nneut_highLL*avg_prop_nneut_highLL+avg_h_wkdel_highLL*avg_prop_wkdel_highLL+avg_h_moddel_highLL*avg_prop_moddel_highLL+avg_h_strdel_highLL*avg_prop_strdel_highLL


### model averaging for high LL models that are monotonic
data_highLL_monotonic$AIC <- 2*4-2*data_highLL_monotonic$Likelihood

data_highLL_monotonic$deltaAIC <- data_highLL_monotonic$AIC - min(data_highLL_monotonic$AIC)

avg_h_nneut_highLL_monotonic <- sum(data_highLL_monotonic$h4*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_h_wkdel_highLL_monotonic <- sum(data_highLL_monotonic$h3*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_h_moddel_highLL_monotonic <- sum(data_highLL_monotonic$h2*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_h_strdel_highLL_monotonic <- sum(data_highLL_monotonic$h1*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))

avg_prop_neut_highLL_monotonic <- sum(data_highLL_monotonic$neut*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_prop_nneut_highLL_monotonic <- sum(data_highLL_monotonic$nneut*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_prop_wkdel_highLL_monotonic <- sum(data_highLL_monotonic$wkdel*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_prop_moddel_highLL_monotonic <- sum(data_highLL_monotonic$moddel*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))
avg_prop_strdel_highLL_monotonic <- sum(data_highLL_monotonic$strdel*exp(-1/(2*data_highLL_monotonic$deltaAIC)))/sum(exp(-1/(2*data_highLL_monotonic$deltaAIC)))

# overall average h for high LL monotonic models
0.5*avg_prop_neut_highLL_monotonic+avg_h_nneut_highLL_monotonic*avg_prop_nneut_highLL_monotonic+avg_h_wkdel_highLL_monotonic*avg_prop_wkdel_highLL_monotonic+avg_h_moddel_highLL_monotonic*avg_prop_moddel_highLL_monotonic+avg_h_strdel_highLL_monotonic*avg_prop_strdel_highLL_monotonic



### plot model average

par(mfrow=c(1,2))
bins <- c("(0,1e-5]","(1e-5,1e-4]","(1e-4,1e-3]","(1e-3,1e-2]","(1e-2,0.5]")

barplot(c(avg_prop_neut_highLL_monotonic,avg_prop_nneut_highLL_monotonic,avg_prop_wkdel_highLL_monotonic,avg_prop_moddel_highLL_monotonic,avg_prop_strdel_highLL_monotonic),
        names.arg = bins, ylab = 'Proportion',xlab = 'Selection coefficient bin')


plot(c(0.5,avg_h_nneut_highLL_monotonic,avg_h_wkdel_highLL_monotonic,avg_h_moddel_highLL_monotonic,avg_h_strdel_highLL_monotonic), 
     xaxt='n', xlab = 'Selection coefficient bin', ylab = "Dominance coefficient (h)")
axis(1, at=1:5, labels=bins)
lines(c(0.5,avg_h_nneut_highLL_monotonic,avg_h_wkdel_highLL_monotonic,avg_h_moddel_highLL_monotonic,avg_h_strdel_highLL_monotonic))











### pick out models for simulations
# note that LL=-1452.969 for fully additive model 

#strongly recessive
strRec <- data[data$h5==0.5 & data$h4==0.45 & data$h3==0.25 & data$h2==0.15 & data$h1==0.05,]
strRec

# moderately recessive
modRec <- data[data$h5==0.5 & data$h4==0.5 & data$h3==0.45 & data$h2==0.25 & data$h1==0.10,]
modRec

# weakly recessive
wkRec <- data[data$h5==0.5 & data$h4==0.5 & data$h3==0.5 & data$h2==0.35 & data$h1==0.15,]
wkRec



