library(MASS)
?Boston
names(Boston);
head(Boston$crim)
fit = lm(crim~medv, data=Boston);
summary(fit);

confint(fit); # confidence interval for coefficients
predict(fit, data.frame(lstat=c(5,10,15)), interval="confidence");
predict(fit, data.frame(medv=40), interval="confidence")

predict(fit, data.frame(medv=40), interval="prediction")
multi_fit=lm(crim~.,data=Boston)
summary(multi_fit)
better_fit=lm(crim~zn+nox+dis+rad+black+lstat+medv,data=Boston)
summary(better_fit);
confint(better_fit); # confidence interval for coefficients
predict(fit, data.frame(lstat=c(5,10,15)), interval="confidence");