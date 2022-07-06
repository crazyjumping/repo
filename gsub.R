#Practical question 1:
#mytable.csv opened with excel does not have the col.names correctly aligned. 
#Modify write.table to have the col.names of the table correctly aligned.

setwd("/Users/angeloscarciglia/Desktop/example2")

tmp <- read.table("VandE_clustering.output.csv", sep=",", header=T, row.names=1, stringsAsFactors=T)
library(ggplot2)
plot.df <- data.frame(tmp$Belonging_Cluster, tmp$neighbor)
names(plot.df) <- c("clusters", "neighbors")
ggplot(plot.df, aes(x=clusters, y=neighbors)) + 
  geom_density_2d()

write.table(table(plot.df), "mytable.csv", sep=",")
traba<- read.table("mytable.csv", sep=",", header=T, row.names=1)
write.csv(traba, "mytable.csv", row.names=TRUE)

head (traba)


#Practical question 2:

newplot.df <- data.frame(tmp$Belonging_Cluster, tmp$silhouetteValue)
names(newplot.df) <- c("clusters", "silhouette")
library(ggplot2)
p <- ggplot(newplot.df, aes(x=factor(clusters), y=silhouette)) + 
  geom_violin()
p
head (newplot.df)

#The plot should produce 5 violin plots 
#(as shown in the picture question2.png. Change the script to obtain it.

#Practical question 3:
# Write a script to create a count table (saved as cls5.csv) from VandE.csv 
#including only cluster 5 cells (tmp$Belonging_Cluster)
#rownames of cls5.csv should be only the ensembl ID , eg. ENSG00000275113

vandelungo <- (read.csv("VandE_clustering.output.csv", header=T, sep=","))
vadedata<-data.frame(vandelungo)
xx <- vadedata[which(vadedata[,2] == "5"),]
head(vadedata)
head(xx)

vandecorto <- (read.csv("VandE.csv", header=T, sep=","))
tmp<-data.frame(vandecorto)
yy <- tmp[which(vadedata[,2] == "5"),]
head(yy)
dim(yy)
head(tmp)

x<- rownames(yy)
apply(yy, 1, gsub("\\:*", "", yy))

x1 <- apply(yy, 1, function(x) gsub("\\:", "",x))
x2 <- t(x1)

write.csv(x2, "cls5.csv")


