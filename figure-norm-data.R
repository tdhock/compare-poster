source("tikz.R") 
source("colors.R")

f <- function(x)sum(x*x)
Xi <- c()
Xip <- c()
yi <- c()
seed.i <- 17
##set.seed(seed.i <- seed.i+1)
set.seed(seed.i)
for(i in 1:20){
  x <- runif(2,-2,2)
  delta <- runif(2,-1,1)
  xp <- x+delta
  fxdiff <- f(xp)-f(x)
  y <- ifelse(fxdiff < -1, -1L,
              ifelse(fxdiff > 1, 1L, 0L))
  Xi <- rbind(Xi, x)
  Xip <- rbind(Xip, xp)
  yi <- c(yi, y)
}

X <- rbind(Xi, Xip)
levs <- seq(min(X),max(X),l=20)
m <- matrix(NA,length(levs),length(levs))
for(i in seq_along(levs)){
  x <- levs[i]
  for(j in seq_along(levs)){
    y <- levs[j]
    m[i,j] <- f(c(x,y))
  }
}

yi.colors <- yi.colors[c("0","1","-1")]
yi.col <- yi.colors[as.character(yi)]

tikz("figure-norm-data.tex", h=8, w=3.1)

par(las=1, mar=c(2,1.2,0,1), mfrow=c(3,1), cex=1, omi=c(0,0,0,0))
plot(X, type="n", asp=1, xlab="", ylab="", xaxt="n", yaxt="n")
title(xlab="input feature $ x_{i,1}$",
      ylab="input feature $ x_{i,2}$", line=0.1)
mtext("Original feature space $\\mathbf x\\in\\mathbb R^p$", 4, las=0)
contour(levs, levs, m, col="grey50", add=TRUE, levels=1:10)
pairLWD <- 3
segments(Xi[yi==0,1],
         Xi[yi==0,2],
         Xip[yi==0,1],
         Xip[yi==0,2], lwd=pairLWD,
         col=yi.col[yi==0])
arrowLength <- 0.1
arrows(Xi[yi==1,1],
       Xi[yi==1,2],
       Xip[yi==1,1],
       Xip[yi==1,2], lwd=pairLWD, length=arrowLength,
       col=yi.col[yi==1])
arrows(Xip[yi==-1,1],
       Xip[yi==-1,2],
       Xi[yi==-1,1],
       Xi[yi==-1,2], lwd=pairLWD, length=arrowLength,
       col=yi.col[yi==-1])
##text(Xi, labels=seq_along(yi)) # show row numbers.
##text(Xi+1/4, labels=yi) # show labels.
leg.ord <- c("1","0","-1")
legend("bottomleft", legend=leg.ord, col=yi.colors[leg.ord],
       lwd=pairLWD, lty=rep(1, length(yi.colors)),
       title="label $y_i$", bg="white")

lab.i <- c(1,11,20)
pch.arr <- 1
points(Xi[lab.i,], pch=pch.arr)
points(Xip[lab.i,], pch=pch.arr)
## y_20=-1, we label to the left.
draw <- function(i, off){
  text(Xi[i,,drop=FALSE]+off, labels=sprintf("$\\mathbf x_{%d}$",i))
  text(Xip[i,,drop=FALSE]+off, labels=sprintf("$\\mathbf x_{%d}'$",i))
}
draw(20,c(-1/4, -1/8))

## y_1=1, we label to the right.
draw(1, c(1/4, 0))

## y_11=0, we label below.
draw(11, c(0,-1/4))


## Plot 2: linear separator space.
Xi.square <- Xi*Xi
Xip.square <- Xip*Xip
X.square <- rbind(Xi.square, Xip.square)
plot(X.square, type="n", asp=1, xlab="", ylab="", xaxt="n", yaxt="n")
title(xlab="additional feature $ x_{i,1}^2$",
      ylab="additional feature $ x_{i,2}^2$", line=0.1)
mtext("Enlarged feature space $\\Phi(\\mathbf x)$", 4, las=0)

text(5, 3/2, "$r(\\mathbf x)=\\mathbf w^\\intercal \\Phi(\\mathbf x)$",
     col="grey50", srt=-45)

levs <- seq(min(X.square),max(X.square),l=20)
m <- matrix(NA,length(levs),length(levs))
for(i in seq_along(levs)){
  x <- levs[i]
  for(j in seq_along(levs)){
    y <- levs[j]
    m[i,j] <- x+y
  }
}
contour(levs, levs, m, col="grey50", add=TRUE)

segments(Xi.square[yi==0,1],
         Xi.square[yi==0,2],
         Xip.square[yi==0,1],
         Xip.square[yi==0,2], lwd=pairLWD,
         col=yi.col[yi==0])
arrows(Xi.square[yi==1,1],
       Xi.square[yi==1,2],
       Xip.square[yi==1,1],
       Xip.square[yi==1,2], lwd=pairLWD, length=arrowLength,
       col=yi.col[yi==1])
arrows(Xip.square[yi==-1,1],
       Xip.square[yi==-1,2],
       Xi.square[yi==-1,1],
       Xi.square[yi==-1,2], lwd=pairLWD, length=arrowLength,
       col=yi.col[yi==-1])
points(Xi.square[lab.i,], pch=pch.arr)
points(Xip.square[lab.i,], pch=pch.arr)
draw <- function(i, off){
  text(Xi.square[i,,drop=FALSE]+off,
       labels=sprintf("$\\Phi(\\mathbf x_{%d})$",i),
       cex=0.8)
  text(Xip.square[i,,drop=FALSE]+off,
       labels=sprintf("$\\Phi(\\mathbf x_{%d}')$",i),
       cex=0.8)
}
draw(20,c(-3/5, 1/4))
draw(1,c(3/5, 0))
text(-1/2, 1/2, labels=sprintf("$\\Phi(\\mathbf x_{11}')$",i), cex=0.8)
text(1.2, -0.05, labels=sprintf("$\\Phi(\\mathbf x_{11})$",i), cex=0.8)

## Plot 3: difference vectors as points.
X.diff <- Xip.square-Xi.square
plot(X.diff, type="p", asp=1, xlab="", ylab="", xaxt="n", yaxt="n",
     pch=20, col=yi.col)
title(xlab="difference feature ${x'}_{i,1}^2-x_{i,1}^2$",
      ylab="difference feature ${x'}_{i,2}^2-x_{i,2}^2$", line=0.1)
mtext("Difference of enlarged features $\\Phi(\\mathbf x')-\\Phi(\\mathbf x)$",
      4, las=0)
abline(h=0,v=0, col="grey")
abline(1,-1)
abline(-1,-1)
points(X.diff[lab.i,])
text(-0.8, -1.4, "$\\Phi(\\mathbf x_{20}')-\\Phi(\\mathbf x_{20})$", cex=0.8)

text(c(1,2,-1.3), c(-0.8,1.5,-1/2), sprintf("$y_i=%s$",names(yi.colors)),
     col=yi.colors)

text(-0.8, 0.8, "$\\Phi(\\mathbf x_{11}')-\\Phi(\\mathbf x_{11})$", cex=0.8)

text(1.2, 2.5, "$\\Phi(\\mathbf x_{1}')-\\Phi(\\mathbf x_{1})$", cex=0.8)

text(0.2, -1, "$\\mathbf w^\\intercal [ \\Phi(\\mathbf x') - \\Phi(\\mathbf x) ] = -1$",
     cex=0.7, srt=-45)

text(2.2, -1, "$\\mathbf w^\\intercal [ \\Phi(\\mathbf x') - \\Phi(\\mathbf x) ] = 1$",
     cex=0.7, srt=-45)

dev.off()
