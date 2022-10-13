#!/usr/bin/Rscript
library(purrr)
library(dplyr)
library(ggplot2)


generatorD <- function(n,d,mean,var,class){
  #gerate point mapping vector of size n
  points <- 1:n %>% map(function(x) c(rnorm(d,mean,var),class))
  m<-matrix(unlist(points),n,byrow=TRUE)
  data.frame(x=m[,1],y=m[,2],class=as.factor(m[,3]))
}



diagonal <- function(n,d,c){
  #standar deviation
  sd <- c*sqrt(d)
  # half of examples for each class
  ctos <- n %/% 2
  # generate and join
  rbind(generatorD(ctos,d,-1,sd^2,0),generatorD(n-ctos,d,1,sd^2,1))
}



plot1 <- ggplot(diagonal(10000,2,0.5),aes(x,y,colour=class)) +
        geom_point()+
        scale_color_manual(values=c("#FF0000","#009900"))+
        ggtitle("n = 10000 d = 2 c = 0.5") +
        theme(plot.title = element_text(hjust = 0.5))


plot2 <- ggplot(diagonal(50000,2,1),aes(x,y,colour=class)) +
        geom_point()+
        scale_color_manual(values=c("#FF0000","#009900"))+
        ggtitle("n = 50000 d = 2 c = 1") +
        theme(plot.title = element_text(hjust = 0.5))

plot3 <- ggplot(diagonal(70000,2,1.5),aes(x,y,colour=class)) +
         geom_point()+
         scale_color_manual(values=c("#FF0000","#009900"))+
         ggtitle("n = 70000 d = 2 c = 1.5") +
         theme(plot.title = element_text(hjust = 0.5))


ggsave("diagonal1.png",plot1)
ggsave("diagonal2.png",plot2)
ggsave("diagonal3.png",plot3)
