#!/usr/bin/Rscript




suppressMessages(library(ggplot2))

system("./ej1.R 10000 2 0.5 train")
df <- read.csv("train.cvs")

plot <- ggplot(df,aes(x,y,colour=as.factor(class))) +
        geom_point() +
        scale_color_manual(values=c("#FF0000","#009900"))


ggsave("myplot.png",plot)
