# This is designed to find the percentages of movements through the system

# In particular this takes a specific result of a SECOND case and finds the percentages
# of what the THIRD case might be.

library(dplyr)
library(readr)

# Enter what we want the child's SECOND case to have been, then we'll see what the
# percentages of the THIRD case was for children who had this type of SECOND case ("result of second case")
result <- "Runaway"

# If match.flow.R not run with "Service" as name, change lines below AND "result" above to match possible factor results
#====================================================
# Filter out what I want first case to be, then check what the 2nd case is, find the percentages of each type
customflow <- filter(child_flow_custom, child_flow_custom$`2Placement Setting` == result)
percentage_begin <- as.data.frame(summary(customflow$`3Placement Setting`))
#====================================================

# Need to do this because of how "summary" function works
write.csv(percentage_begin, "percentage_begin_col.csv")
percentage_begin <- read_csv("percentage_begin_col.csv")

# Once imported with first column, rename columns
names(percentage_begin) = c("Third Case Result", "Freq")

sum_of_freq <- sum(percentage_begin$Freq)  # Find sum of all cases
percentages <- mutate(percentage_begin, Percent = (Freq / sum_of_freq)*100)  # Find percentage each type of 2nd case was

# Remove when there were 0, so that we don't have a bunch of 0% cases
thirdcase_percentages <- filter(percentages, percentages$Freq != 0)

remove(result, sum_of_freq, percentage_begin) 

# Now this is the percentages of the second case AFTER the child's first result was
# "result" at the beginning of this script
View(thirdcase_percentages)
