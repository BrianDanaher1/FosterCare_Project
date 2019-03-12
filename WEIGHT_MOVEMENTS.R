# Weight each movement of child and apply result to all_numbers dataframe
# This requires setting a numerical factor to each kind of placement
# and then adding up how many times the child moves into that placement
# setting.

library(dplyr)
uniqueIDs <- unique(case_rem_place$`Identification ID`)

# Reset weights before calculating
all_numbers <- mutate(all_numbers, Weight = 1)

i <- 1

for (ID in uniqueIDs) {
  one_child <- filter(case_rem_place, case_rem_place$`Identification ID` == as.double(ID))
  records <- nrow(one_child)

  rang <- 1:records
  for (b in rang) 
    {
  
    single_placement <- one_child[b, 8]
    
    if (is.na(single_placement)) # NA
    {
      all_numbers[i,8] <- all_numbers[i,8]+1
    }
    
    else 
    {
      
      if (single_placement == "Pre-Adoptive Home") 
      {
        all_numbers[i,8] <- all_numbers[i,8]+1
      }
      
      if (single_placement == "Foster Family Home (Relative)") 
      {
        all_numbers[i,8] <- all_numbers[i,8]+2
      }
      
      if (single_placement == "Foster Family Home (Non-Relative)")
      {
        all_numbers[i,8] <- all_numbers[i,8]+3
      }
      
      if (single_placement == "Institution")
      {
        all_numbers[i,8] <- all_numbers[i,8]+4
      }
      
      else # Other
      {
        all_numbers[i,8] <- all_numbers[i,8]+3.5
      }
      
    }
      
  }
  
  # Ready for next iteration
  i <- i + 1
  
  # Reset one_child
  one_child <- one_child[0,]
}

# Write weighted result as .csv
write.csv(all_numbers, "weighted_all_numbers.csv")

# Clean up R Studio
remove(one_child, single_placement, i, rang, a, b, ID, uniqueIDs)
