#!/usr/bin/Rscript

library(purrr)
library(ggplot2)


class0 <- function(r){
  runif(1,r*4*pi-pi,r*4*pi);
}


class1 <- function(r){
  runif(1,r*4*pi,r*4*pi+pi);
}



generatorS <- function(r,fun,xOr,yOr,class){
  theta <- unlist(r %>% map(function(x) fun(x)))
  x <- xOr + r*cos(theta)
  y <- yOr + r*sin(theta)
  data.frame(x,y,class=as.factor(class))
}



espiral <- function(n,xOr,yOr){
  # half of examples for each class
  ctos <- n %/% 2
  #first generate r distances between 0 and 1
  r <- sqrt(runif(n))
  #half for each class
  ctos <- n %/%2
  rbind(generatorS(head(r,ctos),class0,xOr,yOr,rep(0,ctos)),generatorS(tail(r,n-ctos),class1,xOr,yOr,rep(1,n-ctos)))
}





plot1 <- ggplot(espiral(10000,0,0),aes(x,y,colour=class)) +
        geom_point()+
        scale_color_manual(values=c("#FF0000","#009900"))+
        ggtitle("n = 10000 ") +
        theme(plot.title = element_text(hjust = 0.5))


plot2 <- ggplot(espiral(50000,0,0),aes(x,y,colour=class)) +
        geom_point()+
        scale_color_manual(values=c("#FF0000","#009900"))+
        ggtitle("n = 50000 ") +
        theme(plot.title = element_text(hjust = 0.5))

plot3 <- ggplot(espiral(70000,0,0),aes(x,y,colour=class)) +
         geom_point()+
         scale_color_manual(values=c("#FF0000","#009900"))+
         ggtitle("n = 70000 ") +
         theme(plot.title = element_text(hjust = 0.5))


ggsave("espiral1.png",plot1)
ggsave("espiral2.png",plot2)
ggsave("espiral3.png",plot3)
