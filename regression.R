#the following function is for running adaptive lasso
lasso.adapt.bic2<-function(x,y)
{
# adaptive lasso from lars with BIC stopping rule 
# this one uses the "known variance" version of BIC with RSS/(full model mse)
# must use a recent version of R so that normalize=FALSE can be used in lars

require(lars)
ok<-complete.cases(x,y)
x<-x[ok,]                            # get rid of na's
y<-y[ok]                             # since regsubsets can't handle na's
m<-ncol(x)
n<-nrow(x)
x<-as.matrix(x)                      # in case x is not a matrix

#  standardize variables like lars does 
one <- rep(1, n)
meanx <- drop(one %*% x)/n
xc <- scale(x, meanx, FALSE)         # first subtracts mean
normx <- sqrt(drop(one %*% (xc^2)))
names(normx) <- NULL
xs <- scale(xc, FALSE, normx)        # now rescales with norm (not sd)

out.ls=lm(y~xs)                      # ols fit on standardized
beta.ols=out.ls$coeff[2:(m+1)]       # ols except for intercept
w=abs(beta.ols)                      # weights for adaptive lasso
xs=scale(xs,center=FALSE,scale=1/w)  # xs times the weights
object=lars(xs,y,type="lasso",normalize=FALSE)

# get min BIC
# bic=log(n)*object$df+n*log(as.vector(object$RSS)/n)   # rss/n version
sig2f=summary(out.ls)$sigma^2        # full model mse
bic2=log(n)*object$df+as.vector(object$RSS)/sig2f       # Cp version
step.bic2=which.min(bic2)            # step with min BIC

fit=predict.lars(object,xs,s=step.bic2,type="fit",mode="step")$fit
coeff=predict.lars(object,xs,s=step.bic2,type="coef",mode="step")$coefficients
coeff=coeff*w/normx                  # get back in right scale
st=sum(coeff !=0)                    # number nonzero
mse=sum((y-fit)^2)/(n-st-1)          # 1 for the intercept

# this next line just finds the variable id of coeff. not equal 0
if(st>0) x.ind<-as.vector(which(coeff !=0)) else x.ind<-0
intercept=as.numeric(mean(y)-meanx%*%coeff)
return(list(fit=fit,st=st,mse=mse,x.ind=x.ind,coeff=coeff,intercept=intercept,object=object,
            bic2=bic2,step.bic2=step.bic2))
}




#read phone related features and their corresponding topic probabilities
data=read.csv(".//data//phone_infor.csv",header=T)
attach(data)


#build regression models
model=lm(Rating~.,data)
summary(model)


#variable selection by lasso
##first, we need to install the glmnet package
install.packages("glmnet")
library(glmnet)
data2=as.matrix(data[,-c(1,3,7,13)])
model_lasso=glmnet(x=data2[,-9],y=log(data2[,9]),family="gaussian",alpha=1)
plot(model_lasso)
coefficients=coef(model_lasso,s=cv.fit$lambda.min)
saved_para=which(coefficients!=0) 


#variable selection by adaptive lasso
model_adlasso=lasso.adapt.bic2(x=data2[,-9],y=log(data2[,9]))
names(model_adlasso)
model_adlasso$x.ind
model_adlasso$intercept
model_adlasso$coeff


#variable selection by SCAD
##first, we need to install the ncvreg package
install.packages("ncvreg")
library(ncvreg)
fit=ncvreg(X=data2[,-9],y=log(data2[,9]),penalty="SCAD")
plot(fit)
coef(fit,lambda=0.002)

#variable selection by Elastic Net
cv.fit<-cv.glmnet(x=data2[,-9],y=log(data2[,9]),family="gaussian") 
plot(cv.fit)
best.lambda=cv.fit$lambda.min
model_EN=glmnet(x=data2[,-9],y=log(data2[,9]),family="gaussian",alpha=best.lambda)
plot(model_EN)
coefficients=coef(model_EN,s=cv.fit$lambda.min)
saved_para=which(coefficients!=0) 





