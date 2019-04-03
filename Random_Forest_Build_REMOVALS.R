# Builds Random Forest Classification Model
# SPECIFICALLY FOR ML_removals dataframe
# http://www.rdatamining.com/docs/regression-and-classification-with-r

library(randomForest)
library(dplyr)
library(ggplot2)
library(readr)

# Let's take up to 2nd rem, no "days before 3rd rem" (this is most of data)
colnames(ML_removals)[4] = "NumPlacements"
df <- ML_removals[-c(31,32,33,34)]
dataset <- filter(df, !is.na(df$Days_before_2nd_Rem))
dataset <- na.omit(dataset)

# training and test subsets
ind <- sample(2, nrow(dataset), replace=TRUE, prob=c(0.7, 0.3))

train.data <- dataset[ind==1,]
test.data <- dataset[ind==2,]

# use other variables to predict Weight
rf <- randomForest(Weight ~ ZipDens + CaseDuration + NumParticipants + NumCaregivers + Age + CareAge +
                     ZipCount + NumCaregivers + PerCapIncome + MedHousIncome + VC + PC + AvgHome + InfantMortRate +
                     PercUnder18 + LowBirthWeight + JuvDelinquency + NumRemovals + Place_1st_Rem + Place_2nd_Rem +
                     Service_1st_Rem + Service_2nd_Rem + EndReason_1st_Rem + EndReason_2nd_Rem + Days_before_2nd_Rem, 
                   data=train.data, ntree=100, proximity=T)

# Error rate - plot if you want
# plot(rf, main = "")

# Variable importance
# importance(rf)
# varImpPlot(rf)

# Export / import with dual columns
importance <- importance(rf)
write.csv(importance, "importance.csv")

imp <- read_csv("importance.csv")
names(imp) <- c("Characteristic", "Influence")

ggplot(imp, aes(x = reorder(Characteristic, Influence), y = Influence)) + 
  geom_bar(stat="identity", fill="navyblue") + 
  ggtitle("Influence of Case Characteristics on Case Success") + 
  xlab("Characteristic") + 
  ylab("Random Forest Influence Factor") + coord_flip()

remove(test.data, ind, train.data, dataset,df,importance,imp)
