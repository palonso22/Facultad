rm(list = ls())  
library(randomForest)
  library(ggplot2)
  #library(ggpubr)
  library(e1071)
  library(stats)
  library(cluster)
  library(MASS)
  library(knitr)
  #library(kableExtra)
  
  
  
  #utilidades
  printGGPlot<-function(str,ggImage){
    png(str)
    print(ggImage)
    dev.off()
  }
  
  
  
  setwd("~/Desktop/Facultad/5to\ año/TMD/TPFinal")
  data1 <- read.csv("test.csv")
  data2 <- read.csv("train.csv")
  data <- rbind(data1,data2)
  data <- data[,-562]
  
  
  
  # balance de clases
  
  tab <- table(data[,562])
  round(prop.table(tab)*100,1)
  
  
  
  #Selección de variables
  
  
  #---------------------------------------------------------------------------
  #random forest ranking method for rfe.
  #---------------------------------------------------------------------------
  
  imp.rf <- function(x.train,y,equalize.classes=TRUE,tot.trees=50,mtry=0)
  {
    if(mtry<1) mtry<-floor(sqrt(dim(x.train)[2]))
    prop.samples<-table(y)
    if(equalize.classes) prop.samples<-rep(min(prop.samples),length(prop.samples))
    
    m.rf<-randomForest(x.train,y,ntree=tot.trees,mtry=mtry,sampsize=prop.samples,importance=TRUE)
    imp.mat<-importance(m.rf)
    imp.col<-dim(imp.mat)[2]-1
    rank.list<-sort(imp.mat[,imp.col],decreasing=FALSE,index=T)
    return(list(feats=rank.list$ix,imp=rank.list$x))
  }
  
  
  
  
  rfe.ranking <- function(x,y,method){
    keepFeatures <- 1:dim(x)[2]
    totalFeatures <- length(keepFeatures)
    keepData <- x
    orderFeatures <- 1:totalFeatures
    if(totalFeatures > 1){
      for(i in totalFeatures:2){
        cat("Iter:",i)
        ranking <- (do.call(method, c(list(keepData,y)) ))[["feats"]]
        lessImp <- ranking[1] #index
        orderFeatures[i] <- keepFeatures[lessImp]  # assign order to feature
        keepData <- keepData[,-lessImp] # discard column in data
        keepFeatures <- keepFeatures[-lessImp] # discard feature
      }
    }
    
    orderFeatures[1] <- keepFeatures[1]
    
    search.names <- colnames(x)[orderFeatures] # order colnames
    imp<-(totalFeatures:1)/totalFeatures # compute importance
    names(imp)<-search.names # assign colnames to importance vector
    
    return( list(ordered.names.list=search.names,ordered.features.list=orderFeatures,importance=imp) )
  }
  
  
  
  # rankear variables de acuerdo  a su importancia
  #res <- rfe.ranking(data[,-562],as.factor(data[,562]),"imp.rf")
  
  #write.csv(as.data.frame(res),"variableSelection")
  res <- read.csv("variableSelection")

  # me quedo con las 5 más representativas
  subData <-  data[,c(res$ordered.features.list[1:5],562)]
  
  # boxplots 
  x <- y <- z <- double(0) 
  
  for(i in 1:5){
    y <- c(y,subData[,i])
    x <- c(x,rep(paste0("x",i),length(subData[,i])))
    z <- c(z,subData[,6])
  }
  
  boxplots <- ggplot(data.frame(x,y), aes(x = factor(x),y =y)) +
    geom_boxplot(size=0.5,fill="red") +
    labs(y = "Valores", x = "Variables") +
    ggtitle("Fig 1:Dispersión de las 5 variables más importantes") +
    theme(plot.title = element_text(hjust = 0.5,size=10))
  
  printGGPlot("fig1.png",boxplots)
  
  
  
  # separacion de clases por variable
  for(i in 1:5){
    plot <- ggplot(data.frame(x=subData[,i],tags=factor(subData[,6])), aes(x = x,y=tags,colour=tags)) +
            geom_point(size=0.5)  +
            ggtitle(paste0("Fig ",i+1,":","Separación de las clases por x",i)) + theme(plot.title = element_text(hjust = 0.5,size=10),legend.position="none")+
            labs(y="",x=paste0("x",i))
    printGGPlot(paste0("fig",i+1,".png"),plot)
    
  }
  
  
  
  #analisis bivariado
  colors <- c("#0ABFAF","#0A0ABF","#A60ABF","#E71804","#19E704","#D9E704")
  plot(cleanData[,-6],col=as.factor(cleanData[,6]))
  
  
  pairs <- cbind(c(1,2),c(1,3),c(2,3))
  
  for(i in 1:3){
    # indices para las variables
    i1 <- pairs[1,i]
    i2 <- pairs[2,i]
    
    plot <- ggplot(data.frame(x=subData[,i1],y=subData[,i2],z=as.factor(subData[,6])), aes(x =x,y =y,color=z)) +
      geom_point(size=0.5) +
      labs(x=paste0("x",i1),y=paste0("x",i2)) +
      ggtitle(paste0("Fig ",i+6,":Scatter plot de x",i1," y x",i2)) +
      theme(plot.title = element_text(hjust = 0.5,size=10)) + 
      scale_color_manual(values=colors)
    
    printGGPlot(paste0("fig",i+6,".png"),plot)
  }
  
  
  
  # analisis trivariado
  library(rgl)
  
  tuples <- cbind(c(1,2,3),c(1,3,4),c(2,3,4),c(1,2,4))
  
  get_colors <- function(groups, group.col = palette()){
    groups <- as.factor(groups)
    ngrps <- length(levels(groups))
    if(ngrps > length(group.col)) 
      group.col <- rep(group.col, ngrps)
    color <- group.col[as.numeric(groups)]
    names(color) <- as.vector(groups)
    return(color)
  }
  
  
  colors <- get_colors(factor(subData[,6]))
  
  
  # no se puede poner este codigo en un for
  # hay que ir mirando la figura 3d y hacer el screenshoot cuando se crea conveniente
  i<-4
  
  i1 <- tuples[1,i]
  i2 <- tuples[2,i]
  i3 <- tuples[3,i]
  
  
  labels <- paste0("x",c(i1,i2,i3))
  plot3d(subData[,i1], subData[,i2], subData[,i3], col = colors,
         xlab = labels[1],ylab=labels[2],zlab=labels[3])
  title3d(paste0("Fig ",i+9,": x",i1,",x",i2,",x",i3))
  par3d(windowRect = c(100, 100, 700, 350))
  legend3d("right",legend= unique(subData[,6]), pch = 18, col = unique(colors))#, col = unique(colors) , cex=1.5, inset=c(0.02))
  rgl.snapshot( paste0("fig",i+9,".png"), fmt = "png", top = TRUE)# ,width="50dp",heigth="30dp")#
  
  
  

  
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
  
  
    
    #estabilidad
    library(clusterCrit)
    
    noiseDataset <- function(data,b){
        return(lapply(1:b,function(i) addNoise(data,i)))
    }
    
    
    # add uniforn noise to the data
    addNoise <-function(data,i){
      # in the first place leave original data
      if(i == 1) return(data)
      dims <- dim(data)[2]
      #noise <- sapply(1:dims,function(i){col <- data[,i];col + rnorm(length(col), sd = 0.015 * sd(col))})
      noise <- sapply(1:dims,function(i) jitter(data[,i]))
      return(noise)
    }
    
    
    
    solutionWithSamples <- function(ind,data,k){
      sol <-rep(0,dim(data)[1])
      sol[ind] <- kmeans(data[ind,],k,nsta=10)$cluster
      return(sol)
    }
    
    
    solutionWithNoise<- function(noise,data,k){
      return(kmeans(noise,k,nsta=10)$cluster)
      
    }
    
    
    
    evalScore <- function(cluster1,cluster2){
      nz1 <- which(cluster1!=0)
      nz2 <- which(cluster2!=0)
      #puntos en comun entre los clusters
      int <- intersect(nz1,nz2)
      return(extCriteria(as.integer(cluster1[int]),as.integer(cluster2[int]),"Jaccard"))
    }
    
    
    
    
    
    
    sampleDataset <- function(data,b){
      ctos <- dim(data)[1]
      #take 90% of data
      return(lapply(1:b,function(i) sample(ctos,0.9*ctos)))
    }
    
    estabilidad <- function(data,b,k,referenceDatasets,makeSolucion,problem){
      
      #first generate b-1 references datasets  with sampling or adding noise
      datasets <- referenceDatasets(data,b)

      # return a vector of size b with similarities of clusters of size k
      eval <- function(k){
        # generate b solutions for k clustering
        clusters <- lapply(datasets,function(m) makeSolucion(m,data,k))
        #compare cluster j with the rest of clusters
        compare <- function(j){
          # the scores range from 0 to 1 where 1 represent similarity and 0 disimilarity
          scores <- sapply((1:b)[-(1:j)],function(i) evalScore(clusters[[j]],clusters[[i]]))
          return(scores)
        }
        # compute a distribution of similarities scores between the b clusters
        dist <- unlist(sapply(1:b,compare))
        return(dist)
      }
      breaks <- seq(0.5, 1, by=0.001)
      cut <- cut(eval(2), breaks, right=TRUE)
      freq <- table(cut)
      cumfreq0 <- c(0,cumsum(freq))
      plot(breaks, cumfreq0,main=problem, xlab="Score",  ylab="Frecuencia acumulada",type="l",col=2)   # y−axis label
      for(i in 3:k){
        print(i)
        cut <- cut(eval(i), breaks, right=TRUE)
        freq <- table(cut)
        cumfreq0 <- c(0,cumsum(freq))
        lines(breaks, cumfreq0,type="l",col=i)
      }
      ks <- sapply(2:k,function(i) paste('k =',i))
      legend("topleft", legend = ks, col = 2:k,pch=1)
    }
    
    
    
    
    
    evalEstabilidad <- function(data,problem){
      png(paste(problem,".png",sep=""))
      par(mfrow=c(1,2))
      estabilidad(data,10,10,sampleDataset,solutionWithSamples,paste(problem,"con sampleo"))
      estabilidad(data,10,10,noiseDataset,solutionWithNoise,paste(problem,"con ruido"))
      invisible(dev.off())
    }
    
    
    evalEstabilidad(cleanData[,-6],"estabilidad")
    
    
    
    
    
    #clasificacion
    
    
    
    testPerformance <- function(data,tuneModel,k,class,formula){
      folds <- createFolds(1:nrow(data),k)
      errors <- double(k)
      for(i in 1:k){
        print(i)
        trainIx <- as.vector(unlist(folds[-i]))
        testIx <- as.vector(unlist(folds[i]))
        train <- data[trainIx,]
        trainClass <- class[trainIx]
        test <- data[testIx,]
        testClass <- class[testIx]
        errors[i] <- tuneModel(train,trainClass,test,testClass,formula)
      }
      return(mean(errors))
    }
    
    
    
    
    misclass <- function(res,test){
      tab <- table(res,test)
      library(e1071)
      optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
      m <- tab[,optimalMatch]
      ctos <- length(test)
      return((ctos-sum(diag(m)))/ctos)
    }
    
    
    
    
    # Find best number of rounds for Ada boosting
    tuneAda <- function(train,trainClass,test,testClass,formula){
      errors <- 0
      #Define a function which depends of data and rounds
      eval <- function(x,xClass,y,yClass,formula,depth){
        model <- boosting(formula=formula,data=x, mfinal = 50, coef="Freund", control = rpart.control(maxdepth =depth)) 
        return(misclass(predict(model,y)$class,yClass))
      }
      
      # measure performance for ada with depth between 1:10
      for (i in 1:10){
        cat("depth:",i)
        evalWithDepth <- function(x,xClass,y,yClass,formula) eval(x,xClass,y,yClass,formula,i)
        error <- sapply(1:5,function(j) evalWithDepth(train,trainClass,test,testClass,formula)) 
        errors[i] <- mean(error)
      }
      #Recover the optimal depth
      optimalDepth <- which.min(errors)
      cat("optimal depth",optimalDepth)
      #Measure the performance with the optimal number depth
      error <- eval(train,trainClass,test,testClass,formula,optimalDepth)
      cat("optimal depth: ",optimalDepth)
      cat("error: ",error)
      return(error)
    }
    
    
    resAda <- testPerformance(lampone,tuneAda,5,lampone[,142],N_tipo~.)
    
    
    
    
    
    
    
    
    
    
    