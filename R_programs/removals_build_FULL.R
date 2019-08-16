# Builds WIDE data frame of removals 1-4 of child, their place, service, and end reason for EACH REMOVAL

library(dplyr)

# Only use removals (out of home placements) for this analysis
df <- filter(case_rem_place, case_rem_place$`Episode Type` == "Out-Of Home Placement")

# All unique ID's in cases_removals_placements data set
uniqueIDs <- unique(df$`Identification ID`)

# Set up dataframe
All_Removals_Track <- data.frame(InternalCaseID=as.double(), IdentificationID=as.double(), NumRemovals=as.double(),
                                 Place_1st_Rem=as.character(), Service_1st_Rem=as.character(), EndReason_1st_Rem=as.character(), 
                                 Days_before_2nd_Rem=as.double(),
                                 Place_2nd_Rem=as.character(), Service_2nd_Rem=as.character(), EndReason_2nd_Rem=as.character(),
                                 Days_before_3rd_Rem=as.double(), 
                                 Place_3rd_Rem=as.character(), Service_3rd_Rem=as.character(), EndReason_3rd_Rem=as.character(), 
                                 Days_before_4th_Rem=as.double(),
                                 Place_4th_Rem=as.character(), Service_4th_Rem=as.character(), EndReason_4th_Rem=as.character(), 
                                 stringsAsFactors = FALSE)

i <- 1

for (ID in uniqueIDs) {
  
  # Isolate single child's case
  one_child <- filter(df, df$`Identification ID` == as.double(ID))
  All_Removals_Track[i, 1] <- one_child$InternalCaseID[1]
  All_Removals_Track[i, 2] <- ID
  
  # How many removals did the child have?
  remdates <- unique(one_child$`Removal Date`)
  num_rems <- length(remdates)
  
  All_Removals_Track[i, 3] <- num_rems
  
  # Isolate individual removal details for single child
  first_rem <- filter(one_child, one_child$`Removal Date` == remdates[1])
  second_rem <- filter(one_child, one_child$`Removal Date` == remdates[2])
  third_rem <- filter(one_child, one_child$`Removal Date` == remdates[3])
  fourth_rem <- filter(one_child, one_child$`Removal Date` == remdates[4])
  
  # What placement were they removed out of in last placement of 1st / 2nd / 3rd removal?
  place1 <- first_rem[nrow(first_rem), 8]
  place2 <- second_rem[nrow(second_rem), 8]
  place3 <- third_rem[nrow(third_rem), 8]
  place4 <- fourth_rem[nrow(fourth_rem), 8]
  
  All_Removals_Track[i, 4] <- as.character(place1)
  All_Removals_Track[i, 8] <- as.character(place2)
  All_Removals_Track[i, 12] <- as.character(place3)
  All_Removals_Track[i, 16] <- as.character(place4)
  
  # What service were they removed out of in last placement of 1st / 2nd / 3rd removal?
  serv1 <- first_rem[nrow(first_rem), 6]
  serv2 <- second_rem[nrow(second_rem), 6]
  serv3 <- third_rem[nrow(third_rem), 6]
  serv4 <- fourth_rem[nrow(fourth_rem), 6]
  
  All_Removals_Track[i, 5] <- as.character(serv1)
  All_Removals_Track[i, 9] <- as.character(serv2)
  All_Removals_Track[i, 13] <- as.character(serv3)
  All_Removals_Track[i, 17] <- as.character(serv4)
  
  # What end reason was given for case before removal?
  end1 <- first_rem[nrow(first_rem), 10]
  end2 <- second_rem[nrow(second_rem), 10]
  end3 <- third_rem[nrow(third_rem), 10]
  end4 <- fourth_rem[nrow(fourth_rem), 10]
  
  All_Removals_Track[i, 6] <- as.character(end1)
  All_Removals_Track[i, 10] <- as.character(end2)
  All_Removals_Track[i, 14] <- as.character(end3)
  All_Removals_Track[i, 18] <- as.character(end4)

  # How many days before re-entry?
  days_1st_2nd <- remdates[2] - remdates[1]
  days_2nd_3rd <- remdates[3] - remdates[2]
  days_3rd_4th <- remdates[4] - remdates[3]
  
  All_Removals_Track[i, 7] = days_1st_2nd
  All_Removals_Track[i, 11] = days_2nd_3rd
  All_Removals_Track[i, 15] = days_3rd_4th
  
  i <- i+1
  
}

# Use cases that have more than 1 removal
All_Removals_Track <- filter(All_Removals_Track, All_Removals_Track$NumRemovals > 1)

# If removal is blank for 3rd, make it an "NA"
All_Removals_Track <- mutate_all(All_Removals_Track, ~na_if(., "character(0)"))

# If cases were backwards for some reason (negative timeline), remove
All_Removals_Track <- filter(All_Removals_Track, All_Removals_Track$Days_before_2nd_Rem > 0)

# Write to file
write.csv(All_Removals_Track, "ALL_REMS_WIDE.csv")

# Clean up R Studio
remove(i,one_child,end1,end2,end3,end4,serv1,serv2,serv3,place1,place2,place3,place4,
       days_1st_2nd,days_2nd_3rd,days_3rd_4th,first_rem,second_rem,third_rem,fourth_rem)


