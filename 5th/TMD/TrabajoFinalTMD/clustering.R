# Clustering


# computar la frecuencia relativa con la que kmeans encuentra las clases
evalKmeans <- function(data,class){
  iters <- 1:1000
  res <- double(1)
  for(i in iters){
    cm <- table(class,kmeans(data,cent=2)$cluster)
    sum1 <- cm[1,1] + cm[2,2]
    sum2 <- cm[1,2] + cm[2,1]
    if(sum1==0 || sum2==0) res <- res+1
  }
  return (res/length(iters))
}



resKmeans <- function(data,class){
  tab<-table(class,kmeans(data,cent=6,iter.max = 1000)$cluster)
  optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
  return(tab[,optimalMatch])
}


resHClust <- function(data,class){
  tab <- table(class,cutree(hclust(dist(data),method="complete"),k=6))
  optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
  return(tab[,optimalMatch])
}


cleanData <-  data[,c(res$ordered.features.list[1:280],562)]

library(knitr)
library(kableExtra)
kable(resKmeans(cleanData[,-281],cleanData[,281]),caption="Kmeans con k = 6",align = rep("r",4),format="latex") %>%
  kable_styling(latex_options = "HOLD_position") %>%
  column_spec(1:7,background = "#FFFF19") %>%
  column_spec(1, background  = "#FF8000") %>%
  row_spec(0,background = "#FF6619")


cleanData <-  data[,c(res$ordered.features.list[1:50],562)]
kable(resKmeans(cleanData[,-51],cleanData[,51]),caption="Kmeans con k = 6",align = rep("r",4),format="latex") %>%
  kable_styling(latex_options = "HOLD_position") %>%
  column_spec(1:7,background = "#FFFF19") %>%
  column_spec(1, background  = "#FF8000") %>%
  row_spec(0,background = "#FF6619")



cleanData <-  data[,c(res$ordered.features.list[1:280],562)]
kable(resHClust(cleanData[,-281],cleanData[,281]),caption="Hclust con 280 dimensiones",align = rep("r",4),format="latex") %>%
  kable_styling(latex_options = "HOLD_position") %>%
  column_spec(1:7,background = "#FFFF19") %>%
  column_spec(1, background  = "#FF8000") %>%
  row_spec(0,background = "#FF6619")


cleanData <-  data[,c(res$ordered.features.list[1:50],562)]
kable(resHClust(cleanData[,-51],cleanData[,51]),caption="HClust",align = rep("r",4),format="latex") %>%
  kable_styling(latex_options = "HOLD_position") %>%
  column_spec(1:7,background = "#FFFF19") %>%
  column_spec(1, background  = "#FF8000") %>%
  row_spec(0,background = "#FF6619")



