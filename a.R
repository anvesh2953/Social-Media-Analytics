#part1
#setwd("~/LAB05")
# Install the packages and load libraries
install.packages('arules')
library('arules')
#read in the csv file as a transaction data 
txn <- read.transactions ("http://cobalpha.niu.edu/faculty/m10cxd1/omis694/Lab05/MBAData.csv",rm.duplicates = FALSE,format="single",sep=",",cols=c(1,2))
#inspect transaction data
txn@transactionInfo 
txn@itemInfo
image(txn)
#mine association rules
basket_rules <- apriori(txn,parameter=list(sup=0.5,conf=0.9,target="rules"))
inspect(basket_rules)
#Part2
#Read in Groceries data
data(Groceries)
Groceries
Groceries@itemInfo
#mine rules
rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))
#Extract rules with confidence =0.8
subrules <- rules[quality(rules)$confidence > 0.8]
inspect(subrules)
#Extract the top three rules with high lift 
rules_high_lift <- head(sort(rules, by="lift"), 3)
inspect(rules_high_lift)
