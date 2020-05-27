#read topic probabilities for sample reviews in "English comments.txt" and "Chinese comments.txt"
data=read.csv(".//data//data_ttest.csv",header=T)
dim(data)

#split the dataset
Chi_num=which(data[,1]=="Chi")
data_Chi=data[Chi_num,]
data_Eng=data[-Chi_num,]

#calculate the average probablitities for each topic
mean_Chi=apply(data_Chi[,-1],2,mean)
mean_Eng=apply(data_Eng[,-1],2,mean)

#apply t.test for each topic
pvalue=rep(0,6)
for(i in 2:7)
{
 prob_Chi=data_Chi[,i]
 prob_Eng=data_Eng[,i]
 res=t.test(prob_Chi,prob_Eng)
 pvalue[i-1]=res$p.value
}

