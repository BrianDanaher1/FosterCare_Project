# Extrapolate independent df's that show 1st - 5th individual removal records

library(dplyr)
uniqueIDs <- unique(case_rem_place$`Identification ID`)
copy <- case_rem_place

# Set up blank data frames with corresponding column names
first_removals <- copy[0,]
second_removals <- copy[0,]
third_removals <- copy[0,]
fourth_removals <- copy[0, ]
fifth_removals <- copy[0, ]

i <- 1

for (ID in uniqueIDs) 
{
  one_child <- filter(case_rem_place, case_rem_place$`Identification ID` == as.double(ID))
  
  # 1st record in a child's case will be their 1st removal... etc.
  first_removals[i,] <- one_child[1, ]
  second_removals[i,] <- one_child[2, ]
  third_removals[i,] <- one_child[3, ]
  fourth_removals[i, ] <- one_child[4, ]
  fifth_removals[i, ] <- one_child[5, ]
  
  i <- i + 1
  
  # Reset one_child to move onto next child
  one_child <- one_child[0,]
}

# Remove any records that don't have ID's
first_removals <- subset(first_removals, !is.na(first_removals$`Identification ID`))
second_removals <- subset(second_removals, !is.na(second_removals$`Identification ID`))
third_removals <- subset(third_removals, !is.na(third_removals$`Identification ID`))
fourth_removals <- subset(fourth_removals, !is.na(fourth_removals$`Identification ID`))
fifth_removals <- subset(fifth_removals, !is.na(fifth_removals$`Identification ID`))

# Clean up R Studio
remove(i, ID, one_child, uniqueIDs)
