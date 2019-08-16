# This is designed to find the percentages of movements through the system

# This one just finds the percentages of what the first case will be
# This is the only one of the three find_percent scripts that REMOVES NA'S

library(dplyr)
library(readr)

# If match.flow.R not run with "Service" as name, change lines below AND "result" above to match possible factor results
#====================================================
percentage_begin <- as.data.frame(summary(child_flow_custom$`1Placement Setting`))
#====================================================

# Need to do this because of how "summary" function works
write.csv(percentage_begin, "percentage_begin_col.csv")
percentage_begin <- read_csv("percentage_begin_col.csv")

# Once imported with first column, rename columns
names(percentage_begin) = c("First Case Result", "Freq")
percentage_begin <- filter(percentage_begin, percentage_begin$`First Case Result` != "NA's")

sum_of_freq <- sum(percentage_begin$Freq)  # Find sum of all cases
percentages <- mutate(percentage_begin, Percent = (Freq / sum_of_freq)*100)  # Find percentage each type of 2nd case was

# Remove when there were 0, so that we don't have a bunch of 0% cases
firstcase_percentages <- filter(percentages, percentages$Freq != 0)

remove(sum_of_freq, percentage_begin)

# Now this is the percentages of the second case AFTER the child's first result was
# "result" at the beginning of this script
View(firstcase_percentages)