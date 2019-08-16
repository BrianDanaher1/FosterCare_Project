# Custom statistical algorithm to see what factors change weight the most (or whatever factor I select)

# Takes each factor/characteristic of case, finds average value of that factor,
# then compares weights for the dataset filtered for values above/below that average
# value.  Also, can switch "mean" to "median" if need be.
#
# NEED TO FINISH IMPLEMENTING NORMALIZATION ON LINE 25

library(dplyr)
library(ggplot2)

# Accurately reflect what is being compared
colnames(ML_removals)[4] <- "NumPlacements"

# Set up dataframe
STAT_ALG <- data.frame(Factor = as.character(), Wt_AboveMean = as.double(), 
                                 Wt_BelowMean = as.double(), RelativeDiff = as.double(),
                                 stringsAsFactors = FALSE)

# Factors / characteristics to consider (change if wanted)
cols <- c(2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
          21,23,24,25,26,27,28,29,30,31,32,33,34)

# Normalization in progress
# ML_removals <- normalize(ML_removals, method = "standardize)

k <- 1

for (i in cols) {
  
  # Name of factor and average value of that factor
  name <- names(ML_removals[,i])
  avg <- mean(unlist(ML_removals[,i]), na.rm=TRUE)  # switch to "median" if wanted
  
  # Filter ML_removals for records above/below this mean
  above <- filter(ML_removals, ML_removals[,i] >= avg)
  below <- filter(ML_removals, ML_removals[,i] <  avg)
  
  # What is the average weight of a case with factor above/below mean?
  weightA <- mean(unlist(above[, "Weight"]), na.rm=TRUE)
  weightB <- mean(unlist(below[, "Weight"]), na.rm=TRUE)
  
  # Relative difference between average weights in filtered datasets
  rel_diff <- (abs(weightA - weightB)) / ((weightA + weightB)/2) * 100
  
  # Append information to STAT_ALG file
  STAT_ALG[k,1] <- name
  STAT_ALG[k,2] <- weightA
  STAT_ALG[k,3] <- weightB
  STAT_ALG[k,4] <- rel_diff
  
  k = k + 1
  
}

# Write to file
write.csv(STAT_ALG, "STAT_ALG_RESULTS.csv")

# Plot GGPLOT
ggplot(STAT_ALG, aes(x = reorder(Factor, RelativeDiff), y = RelativeDiff)) + 
  geom_bar(stat="identity", fill="darkgreen") + 
  ggtitle("Custom Statistical Algorithm Results") + 
  xlab("Characteristic") + 
  ylab("Influence of Characteristic on Weight") + coord_flip()

# Clean up R Studio
remove(weightA, weightB, cols, i, avg, above, below, rel_diff, k, name)