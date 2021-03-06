packageurl <- "https://cran.r-project.org/src/contrib/Archive/kohonen/kohonen_2.0.19.tar.gz"
install.packages(packageurl, repos = NULL, type = "source")
require(kohonen)
#args <- commandArgs()
#x <- read.table(args[4],header=T,sep=",")
x <- read.csv('chords.csv',header=T,sep=",")
w <- array(0,dim=c(20,20,12))
for(i in 1:20) {
  for(j in 1:20) {
    for(k in 1:12) {
      w[i,j,k] <- runif(1)
    }
  }
}
for(s in 1:360) {
  for(t in 1:24) {
    index <- sample(1:24, 1, replace = TRUE)
    R <- x[index,]
    bmu <- 30
    bmui <- 1
    bmuj <- 1
    for(i in 1:20) {
      for(j in 1:20) { 
        bmu2 <- sqrt((R$C - w[i,j,1])^2 + (R$C. - w[i,j,2])^2 + (R$D - w[i,j,3])^2 + (R$Eb - w[i,j,4])^2 + (R$E - w[i,j,5])^2 + (R$F - w[i,j,6])^2 + (R$F. - w[i,j,7])^2 + (R$G - w[i,j,8])^2 + (R$Ab - w[i,j,9])^2 + (R$A - w[i,j,10])^2 + (R$Bb - w[i,j,11])^2 + (R$B - w[i,j,12])^2)
        if(bmu2 < bmu) {
          bmu <- bmu2
          bmui <- i
          bmuj <- j
        }
      }
    }
    for(k in 1:20) {
      for(l in 1:20) {
        omg <- 1/3 * (20 - 1 - (s/20))
        dis <- abs((i^2)+(j^2)+(k^2)+(l^2))
        tht <- exp(-1 * (dis / (2*omg^2)))
        for(n in 1:12)
        {
          w[i,j,n] <- w[i,j,n] + (tht * .02 * (R$C - w[i,j,n]))
        }
      }
    }
  }
}
          
#png(filename="Iris2_4.png")

#dev.off()
## maybe change the desired number of tick marks:  par(lab=c(mx,my,7))
#plot(,, xlim = c(0, 20), ylim = c(0, 20), panel.first = grid(20,20,col="black"))