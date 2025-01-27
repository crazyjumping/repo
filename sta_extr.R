#There is an overlap among de and cpm, but the final file is empty.  
#Find the errors.
getwd()
setwd("/Users/angeloscarciglia/Desktop/example1")
de <- read.table("DEfiltered_mirna_log2fc_1_fdr_0.05.txt", sep="\t", header=T, row.names=1)
cpm <- read.table("w_covar_cpm.txt", sep="\t", header=T, row.names=1)
log2cpm <- log2(cpm + 1)
log2cpm <- log2cpm[grep("mirBase", rownames(log2cpm)),]
rownames(log2cpm) <- sub(":mirBase","", rownames(log2cpm))
log2cpm.f <- log2cpm[which(rownames(log2cpm) %in% rownames(de)),]
write.table(log2cpm.f, "de_log2CPM.txt", sep="\t", col.names=TRUE, row.names = TRUE)

head(de)
head(cpm)
head (log2cpm)
dim(log2cpm)
head(log2cpm.f)

read.table("de_log2CPM.txt", sep="\t", header=TRUE,  row.names=1)

#Practical question 2:
#Using the pca function from docker4seq create the plot for 
#the file w_covar_cpm.txt (it is not log2 transformed).
#For PCA you need to have the file in log2

cpm <- read.table("w_covar_cpm.txt", sep="\t", header=T, row.names=1)
log2ofcpm <- log2(cpm+1)
write.table(log2ofcpm, "log2ofcpm.txt", sep="\t", col.names=TRUE, row.names = TRUE)

#PCA function 
library(docker4seq) 
setwd ("/Users/angeloscarciglia/Desktop/example1")
pca(
experiment.table = "log2ofcpm.txt",
type = c("counts"),
covariatesInNames = FALSE,
samplesName = TRUE,
principal.components = c(1, 2),
legend.position = "bottomleft", 
pdf = TRUE, 
output.folder = "/Users/angeloscarciglia/Desktop/example1"
)

#Practical question 3:
#In the folder of the example you have three folders ra, rb and rc, 
#in each folder there is the file Log.final.out generated by STAR

#Write a script that create a table containing as header ra, rb and rc names 
#and as rownames "Uniquely mapped reads number"
#and "Number of reads mapped to multiple loci"

library(devtools)
install_github("HuntsmanCancerInstitute/hciR")
install_github("HuntsmanCancerInstitute/hciRdata")
library(hciR)

setwd ("/Users/angeloscarciglia/Desktop/example1/ra")
ra <- read_STAR( pattern=".final.out", reshape=F)
setwd ("/Users/angeloscarciglia/Desktop/example1/rb")
rb <- read_STAR( pattern=".final.out", reshape=F)
setwd ("/Users/angeloscarciglia/Desktop/example1/rc")
rc <- read_STAR( pattern=".final.out", reshape=F)


raval <- c(as.numeric(ra[4,3]), as.numeric(ra[18,3]))
rbval <- c(as.numeric(rb[4,3]), as.numeric(rb[18,3]))
rcval <- c(as.numeric(rc[4,3]), as.numeric(rc[18,3]))

table <- cbind(raval,rbval,rcval)
colnames(table)<- c("ra","rb","rc")
row.names(table)<- c("Uniquely mapped reads number","Number of reads mapped to multiple loci")

#Extract from the files the requested numbers and create the 
#3 col x 2 row matrix
#saver the matrix a comma separated file

write.csv(table,"tablina.csv")

getwd()
raval 
table
dim(table)
class(table)
head(ra)














