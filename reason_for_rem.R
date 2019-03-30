# Isolate last placement end reason (last placement in FIRST removal)
# Removal reason for next removal

library(dplyr)
uniqueIDs <- unique(case_rem_place$`Identification ID`)

# Set up dataframe
RemovalTrack <- data.frame(InternalCaseID=as.double(), IdentificationID=as.double(), NumRemovals=as.double(),
                           LastPlace_Discharge=as.character(), EndReason_Discharge=as.character(),
                           Place_on_Reentry=as.character(), Service_on_Reentry=as.character(),
                           EndReason_afterReentry=as.character(), stringsAsFactors = FALSE)

i <- 1

for (ID in uniqueIDs) {
  # Isolate single child's case
  one_child <- filter(case_rem_place, case_rem_place$`Identification ID` == as.double(ID))
  RemovalTrack[i, 1] <- one_child$InternalCaseID[1]
  RemovalTrack[i, 2] <- ID
  
  # How many removals did the child have?
  remdates <- unique(one_child$`Removal Date`)
  RemovalTrack[i, 3] <- length(remdates)
  
  # How many placements did the child have in their first / second removal?
  numplacements_first_rem <- nrow(filter(one_child, one_child$`Removal Date` == remdates[1]))
  numplacements_second_rem <- nrow(filter(one_child, one_child$`Removal Date` == remdates[2]))
  
  # What placement were they removed out of in last placement of FIRST removal?
  place_setting_oflastplace_infirstrem  <- one_child[numplacements_first_rem, 8]
  RemovalTrack[i, 4] <- place_setting_oflastplace_infirstrem
  
  # What was the reason for this removal out of there last placement in their FIRST removal?
  end_reason_oflastplace_infirstrem <- one_child[numplacements_first_rem, 10]
  RemovalTrack[i, 5] <- as.character(end_reason_oflastplace_infirstrem)
  
  # What was the placement upon re-entry into system?
  placement_on_reentry <- one_child[(numplacements_first_rem + 1), 8]
  RemovalTrack[i, 6] <- placement_on_reentry
  
  # What was the service upon re-entry into system?
  service_on_reentry <- one_child[(numplacements_first_rem + 1), 6]
  RemovalTrack[i, 7] <- service_on_reentry
  
  # What was the end reason upon discharge after re-entry?
  end_reason_after_reentry <- one_child[(numplacements_first_rem + numplacements_second_rem), 10]
  RemovalTrack[i, 8] <- end_reason_after_reentry
  
  i <- i+1
  
}

# Child must have been removed out of their first placement situation to "re-enter"
RemovalTrack <- filter(RemovalTrack, RemovalTrack$NumRemovals > 1)

# Write to file
write.csv(RemovalTrack, "removal_track.csv")


