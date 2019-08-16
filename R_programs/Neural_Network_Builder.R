# Neural Network Builder 
# Also test accuracy at end

# THIS CODE ADAPTED FROM ANALYTICS VIDHYA

# IF YOU GET NON-NUMERIC ARGUMENT TO BINARY
# all_numbers$`Identification ID` <- as.double(all_numbers$`Identification ID`)

# IF YOU GET CBIND ERROR number of rows of result not multiple of vector length...
# Means there are NA's in the column trying to built neural off of, subset for when columns NOT NA

library(dplyr)

# Read the Data, filter if needed to get rid of outlier or NA cases
data = all_numbers
  #  filter(all_numbers, !is.na(SOME COLUMN))

# Creating same data subset
samplesize = 0.3 * nrow(data)

# Random sampling
set.seed(80)

# Index variable
index = sample( seq_len ( nrow ( data ) ), size = samplesize )

# Create training and test set
datatrain = data[ index, ]
datatest = data[ -index, ]

## Scale data for neural network
max = apply(data , 2 , max)
min = apply(data, 2 , min)

scaled = as.data.frame(scale(data, center = min, scale = max - min))

# load neuralnet
library(neuralnet)

# Create training and test set (SCALED)
trainNN = scaled[index , ]
testNN = scaled[-index , ]

# Fit neural network
# Choose characteristics
set.seed(2)
NN = neuralnet(formula <- Weight ~ Zip + 
                 ProbZip + NumParticipants + ZipCount + ZipDens + CaseDuration + 
                 Age + NumCaregivers + CareAge + PerCapIncome + MedHousIncome + 
                 VC + PC + AvgHome + InfantMortRate + PercUnder18 + LowBirthWeight + 
                 JuvDelinquency, trainNN, hidden = 3 , linear.output = T )

# plot neural network
plot(NN)


# ==================================================================
## Prediction using neural network

# Select indices of rows (manually enter - update this)
predict_testNN = neuralnet::compute(NN, testNN[ ,c(3,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)])

# Scale
predict_testNN = (predict_testNN$net.result * (max(data$Weight) - min(data$Weight))) + min(data$Weight)

# Plot result
plot(datatest$Weight, predict_testNN, col='blue', pch=16, ylab = "NN's Predicted Result", xlab = "Real Result", main="Neural Network Accuracy")

# Plot what perfect result would look like
abline(0,1)

# Calculate Root Mean Square Error (RMSE)
# RMSE.NN = (sum((datatest$Weight - predict_testNN)^2) / nrow(datatest)) ^ 0.5
# print(RMSE.NN)

# Want to test one set of values?
# Testing - incomplete
# neuralnet::compute(NN, testNN[1 ,c(3,6,7,9,10,11,12,13)])$net.result * (max(data$Weight) - min(data$Weight)) + min(data$Weight)

# remove(predict_testNN,index,max,min,datatrain,datatest,NN,testNN,trainNN,samplesize,RMSE.NN,data,scaled)
