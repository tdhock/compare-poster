works_with_R("3.0.2", xtable="1.7.2")

load("sushi.RData")

meta <- read.csv("sushi.csv",header=FALSE,
                 col.names=c("col","romaji","english","japanese"))
meta$rated <- NA
meta$mean <- NA
meta$median <- NA
tab <- c()
for(i in 1:nrow(meta)){
  m <- meta[i,]
  scores <- sushi$scores[,m$col]
  meta$rated[i] <- N <- sum(!is.na(scores))
  meta$mean[i] <- mean(scores,na.rm=TRUE)
  meta$median[i] <- median(scores,na.rm=TRUE)
  percents <- table(scores)/N*100
  tab <- rbind(tab, sprintf("%.1f%%", percents))
}
colnames(tab) <- names(percents)
out <- cbind(meta[,c("english", "romaji", "rated")], tab)
xt <- xtable(out, align="rrrrrrrrr")
print(xt, include.rownames=FALSE, floating=FALSE, file="table-sushi.tex")
