getwd()
setwd("/Users/angeloscarciglia/Desktop/example3/permutation")
#Practical question 1:
  #The script in command.R in permutation folder should 
#create a summary file where all the #denseSpace.csv files are 
#summed cumulatively, but it does not work. Fix it
files=list.files(getwd())
temp=read.table(files[1],sep=",",header=TRUE,row.names=1)
for(i in files[+1]){
  temp=temp+read.table(i,header=TRUE,row.names=1,sep=",")
}
write.table(temp,"total.csv",col.names=NA,sep=",")
file=paste(getwd(),"total.csv",sep="/")

class(files)

#Practical question 2:
  #In the file GSE193256_PC9_ATAC_counts.filtered.annotated.tsv (tab delimited) 
  #are annotated the positions of ATACseq bands. Chreate a dataframe only 
  #including seqnames and annotation
#and create a table counting for each chromosome (seqnames) the number of Promoters 
#(annotation)
#Save it a tab delimited file

setwd("/Users/angeloscarciglia/Desktop/example3")

tab<-read.delim("GSE193256_PC9_ATAC_counts.filtered.annotated.tsv",sep="\t",header=TRUE)
redtab <- data.frame(tab$seqnames, tab$annotation, tab$geneChr)

tab2<-data.frame(table(redtab['tab.geneChr']))
write.table(tab2, "secondadomanda.tsv", sep="\t")

#Practical question 3:
  #Create a script to filter from ANOVAlike__counts.txt 
  #the genes which have FDR <= 0.1, logCPM >= 4 and at least one |logFC| > 1. 
  #Save the results as tab delimite file in ANOVAlike_filtered_counts.txt 
  #containing only the log2FCs.

anova <- read.table("ANOVAlike__counts.txt", sep="\t", header=TRUE, row.names=1)
anovafiltered <- data.frame(anova[which( anova$FDR <= 0.1 & anova$logCPM >= 4 & (abs(anova$logFC.groupsCov.2) > 1 | abs(anova$logFC.groupsCov.3) > 1 | abs(anova$logFC.groupsCov.4) > 1 )),])

dim(anova)
dim(anovafiltered) 






