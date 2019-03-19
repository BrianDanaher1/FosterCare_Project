# Builds Random Forest Classification Model
# Plots ggplot influence factor bar chart

# Adapted from:
# http://www.rdatamining.com/docs/regression-and-classification-with-r

# install.packages("randomForest")
library(randomForest)
dataset <- all_numbers

# Subsets: Train and Test
ind <- sample(2, nrow(dataset), replace=TRUE, prob=c(0.7, 0.3))  # 70% train, 30% test

train.data <- dataset[ind==1,]
test.data <- dataset[ind==2,]

# Use other characteristics in data to predict Weight
formula <- Weight ~ Zip + ProbZip + NumParticipants + ZipCount + ZipDens + CaseDuration + Age + 
  NumCaregivers + CareAge + PerCapIncome + MedHousIncome + VC + PC + AvgHome + InfantMortRate + 
  PercUnder18 + LowBirthWeight + JuvDelinquency

rf <- randomForest(formula, data=train.data, ntree=100, proximity=T)

# Error rate
plot(rf, main = "")

# Variable importance

# Uncomment below to view list of IncNodePurity
# importance(rf)

# This actually plots importance / purity:
varImpPlot(rf)

importance <- importance(rf)

# Plot ggplot clean
library(ggplot2)

ggplot(importance, aes(x = reorder(Characteristic, Influence), y = Influence)) + 
  geom_bar(stat="identity", fill="navyblue") + 
  ggtitle("Influence of Case Characteristics on Success") + 
  xlab("Characteristic") + 
  ylab("Random Forest Influence Factor") + coord_flip()

# Clean up R Studio
remove(test.data, ind, train.data, dataset, Pred, formula)
