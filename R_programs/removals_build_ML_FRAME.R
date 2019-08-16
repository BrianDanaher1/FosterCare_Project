# Built machine learning dataset to predict # of removals (or other factor (?))

# Set up DF
# =========================================================
ML <- All_Removals_Track[0,]

ML$IdentificationID <- as.double(ML$IdentificationID)

ML$Place_1st_Rem <- as.double(ML$Place_1st_Rem)
ML$Place_2nd_Rem <- as.double(ML$Place_2nd_Rem)
ML$Place_3rd_Rem <- as.double(ML$Place_3rd_Rem)
ML$Place_4th_Rem <- as.double(ML$Place_4th_Rem)

ML$Service_1st_Rem <- as.double(ML$Service_1st_Rem)
ML$Service_2nd_Rem <- as.double(ML$Service_2nd_Rem)
ML$Service_3rd_Rem <- as.double(ML$Service_3rd_Rem)
ML$Service_4th_Rem <- as.double(ML$Service_4th_Rem)

ML$EndReason_1st_Rem <- as.double(ML$EndReason_1st_Rem)
ML$EndReason_2nd_Rem <- as.double(ML$EndReason_2nd_Rem)
ML$EndReason_3rd_Rem <- as.double(ML$EndReason_3rd_Rem)
ML$EndReason_4th_Rem <- as.double(ML$EndReason_4th_Rem)
# =========================================================

# Set df as All_Removals_Track to make code cleaner
df <- All_Removals_Track

# Find unique IDs
uniqueIDs <- unique(All_Removals_Track$IdentificationID)

i <- 1
for (ID in uniqueIDs) {
  
  # Any numbers just directly put them in
  ML[i, 1] <- df[i, 1]
  ML[i, 2] <- as.double(ID)
  ML[i, 3] <- df[i, 3]
  ML[i, 7] <- df[i, 7]
  ML[i, 11] <- df[i, 11]
  ML[i, 15] <- df[i, 15]
  
  # Now change factors to factor levels
  change_to_numerics <- c(4,5,6,8,9,10,12,13,14,16,17,18)
  for (k in change_to_numerics) {
    
    factorlevels <- as.factor(as.numeric(factor(All_Removals_Track[, k])))
    ML[i, k] <- factorlevels[i]
    
  }
  
  
  i = i + 1

}

# Create full ML frame, join with all_numbers ML details from other programs
ML_removals <- full_join(all_numbers[-c(1,5,24)], ML, by="IdentificationID")
ML_removals <- ML_removals[-c(35,36,37,38)]

# Clean up R Studio
remove(i,df, ID, uniqueIDs,factorlevels,change_to_numerics,k)