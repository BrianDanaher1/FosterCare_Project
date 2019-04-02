# Enter End Reason of 1st/2nd removal, then displays percentages of Place or Services provided,
# for the case after the one that closed with that end reason

# The "here" is where to change "Place" to "Service" if we want to see either placement setting
# or service in the outputted table.

library(dplyr)
library(readr)

# Set factors
# ======================================================================================
All_Removals_Track$Place_1st_Rem <- as.factor(All_Removals_Track$Place_1st_Rem)
All_Removals_Track$Place_2nd_Rem <- as.factor(All_Removals_Track$Place_2nd_Rem)
All_Removals_Track$Place_3rd_Rem <- as.factor(All_Removals_Track$Place_3rd_Rem)

All_Removals_Track$Service_1st_Rem <- as.factor(All_Removals_Track$Service_1st_Rem)
All_Removals_Track$Service_2nd_Rem <- as.factor(All_Removals_Track$Service_2nd_Rem)
All_Removals_Track$Service_3rd_Rem <- as.factor(All_Removals_Track$Service_3rd_Rem)

All_Removals_Track$EndReason_1st_Rem <- as.factor(All_Removals_Track$EndReason_1st_Rem)
All_Removals_Track$EndReason_2nd_Rem <- as.factor(All_Removals_Track$EndReason_2nd_Rem)
All_Removals_Track$EndReason_3rd_Rem <- as.factor(All_Removals_Track$EndReason_3rd_Rem)
# ======================================================================================

# Set up DF 
# ======================================================================================
copy <- filter(case_rem_place, case_rem_place$`Episode Type` == "Out-Of Home Placement")
names(copy) <- c("InternalCaseID", "IdentificationID", "Removal Date", "PlaceBeginDate", "PlaceEndDate",
                 "Service", "EpType", "Place", "EndPurpose", "EndReason")
copy$Place <- as.factor(copy$Place)                                                                              # HERE 2x
Removal_Percentages <- as.data.frame(levels(copy$Place))                                                         # Here
names(Removal_Percentages) <- c("Place")                                                                         # Here
Removal_Percentages$Place <- as.character(Removal_Percentages$Place)                                             # HERE 2x
Removal_Percentages[nrow(Removal_Percentages)+1,1] <- "NA's" 
# ======================================================================================

# Enter what we want the child's END REASON to have been, then find percentages of the SERVICE ON REENTRY was
# Attempt at automation so far unsuccessful - pivot charts most likely faster

end_1st_rem <- "Reunification w/Parent(s) including Non-Custodial Parent"
end_2nd_rem <- "Reunification w/Parent(s) including Non-Custodial Parent"

# Filter for specific End Reason of Removal #1
custom1flow <- filter(All_Removals_Track, All_Removals_Track$EndReason_1st_Rem == end_1st_rem)
custom2flow <- filter(All_Removals_Track, All_Removals_Track$EndReason_2nd_Rem == end_2nd_rem)

# Percents of Services in 2nd removal after having end reason above
perc_2nd_services <- as.data.frame(summary(custom1flow$Place_2nd_Rem))                                           # Here
perc_3rd_services <- as.data.frame(summary(custom2flow$Place_3rd_Rem))                                           # Here

# Read/write: need to do this because of how "summary" function works, bad coding practice...
write.csv(perc_2nd_services, "perc_2nd_services.csv")
write.csv(perc_3rd_services, "perc_3rd_services.csv")
perc_2nd_services <- read_csv("perc_2nd_services.csv")
perc_3rd_services <- read_csv("perc_3rd_services.csv")

# Once imported with first column, rename columns
names(perc_2nd_services) = c("Place", "Freq_2nd_Rem")                                                            # Here
names(perc_3rd_services) = c("Place", "Freq_3rd_Rem")                                                            # Here

sum_of_2freq <- sum(perc_2nd_services$Freq_2nd_Rem)  # Find sum of all cases
sum_of_3freq <- sum(perc_3rd_services$Freq_3rd_Rem)  # Find sum of all cases

percentages_2 <- mutate(perc_2nd_services, Percent_2nd_Rem = (Freq_2nd_Rem / sum_of_2freq)*100)  # Find percentage
percentages_3 <- mutate(perc_3rd_services, Percent_3rd_Rem = (Freq_3rd_Rem / sum_of_3freq)*100)  # Find percentage

Removal_Percentages <- left_join(Removal_Percentages, percentages_2, by="Place")                                 # Here
Removal_Percentages <- left_join(Removal_Percentages, percentages_3, by="Place")                                 # Here
Removal_Percentages[is.na(Removal_Percentages)] <- 0


# Clean R Studio
remove(perc_2nd_services,perc_3rd_services, custom1flow, end_1st_rem, end_2nd_rem,
       sum_of_2freq, sum_of_3freq)
