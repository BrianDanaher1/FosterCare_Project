# Isolate child's last removal / case / record in system
# Create and build ranking system for deeper analysis
# Assign ranks to certain case results, add to all_numbers for analysis

# Begin to fill all_numbers data frame
# See "all_numbers_merge_data.R" for more data to fill all_numbers 

library(dplyr)
uniqueIDs <- unique(case_rem_place$`Identification ID`)
copy <- case_rem_place

# Set up blank df for last_removals
last_removals <- copy[0,]

i <- 1

for (ID in uniqueIDs) 
  {
  one_child <- filter(case_rem_place, case_rem_place$`Identification ID` == as.double(ID))
  amount_of_cases <- nrow(one_child)
  
  # Pull ID and num cases from all_numbers to start
  all_numbers[i,2] <- ID
  all_numbers[i,6] <- amount_of_cases
  
  # Determine last case of child, add to last_removals df
  one_child_last_placement <- one_child[amount_of_cases, ]
  last_removals[i,] <- one_child_last_placement
  
  i <- i + 1
  
  # Reset one_child and their last placement, prepare for next child record
  one_child <- one_child[0,]
  one_child_last_placement <- one_child_last_placement[0,]
  }

# Remove any last_removals data that does not have ID
last_removals <- subset(last_removals, !is.na(last_removals$`Identification ID`))

# Define ranks, set which IDs that have these ranks

# Rank 5 - best rank -->  Adoption
rank5 <- filter(last_removals, last_removals$`Placement Setting` == "Pre-Adoptive Home" | last_removals$`End Reason` == "Adoption Finalization" | last_removals$Service == "Adoption Placement")
rank5_IDs <- rank5$`Identification ID`

# Rank 4 --> foster care WITH RELATIVE
rank4 <- filter(last_removals, last_removals$`Placement Setting` == "Foster Family Home (Relative)")
rank4_IDs <- rank4$`Identification ID`

# Rank 3 --> foster care with NON RELATIVE
rank3 <- filter(last_removals, last_removals$`Placement Setting` == "Foster Family Home (Non-Relative)" | last_removals$Service == "Non-relative Placement")
rank3_IDs <- rank3$`Identification ID`

# Rank 2 --> Group Home or Instutition
rank2 <- filter(last_removals, last_removals$`Placement Setting` == "Institution" | last_removals$`Placement Setting` == "Group Home")
rank2_IDs <- rank2$`Identification ID`

# Rank 1 --> any child not placed in above ranks
other_ranks <- c(rank2_IDs, rank3_IDs, rank4_IDs, rank5_IDs)
rank1 <- filter(last_removals, !(last_removals$`Identification ID` %in% other_ranks))
rank1_IDs <- rank1$`Identification ID`

# Add ranks to numbers dataset
rank1_spots <- which(all_numbers$`Identification ID` %in% rank1_IDs)
rank2_spots <- which(all_numbers$`Identification ID` %in% rank2_IDs)
rank3_spots <- which(all_numbers$`Identification ID` %in% rank3_IDs)
rank4_spots <- which(all_numbers$`Identification ID` %in% rank4_IDs)
rank5_spots <- which(all_numbers$`Identification ID` %in% rank5_IDs)

# IF ID in all_numbers is in any of the rankN_IDs above,
# put the rank of their case into all_numbers (3rd column)

for (i in rank1_spots)
  {
  all_numbers[i, 3] <- 1
  }
for (i in rank2_spots)
  {
  all_numbers[i, 3] <- 2
  }
for (i in rank3_spots)
  {
  all_numbers[i, 3] <- 3
  }
for (i in rank4_spots)
  {
  all_numbers[i, 3] <- 4
  }
for (i in rank5_spots)
  {
  all_numbers[i, 3] <- 5
  }


# Clean up R Studio
remove(one_child, one_child_last_placement, i, ID, uniqueIDs, amount_of_cases)
remove(rank1_spots, rank2_spots, rank3_spots, rank4_spots, rank5_spots, other_ranks)


