# Track removal details and then placement details upon re-entry
# Specifically end reason of first case, then end reason after case on re-entry

library(dplyr)
library(readr)

# Enter what we want the child's FIRST REMOVAL END REASON to have been, then we'll see what the
# percentages of the END REASON AFTER REENTRY CASE was

result <- "Reunification w/Parent(s) including Non-Custodial Parent"

# ***** OPTIONS FOR RESULT: End Reasons on Discharge *****
#[1] "Reunification w/Parent(s) including Non-Custodial Parent"     "Adoption Finalization"                                       
#[3] "Child ages out (18 - 23 Years Old)"                           "Permanent Guardianship (Includes Guardianship to Relative)"  
#[5] "Parent/Relative/Guardian Requested Change"                    "Provider Requested Change"                                   
#[7] "Dismissed by Court"                                           "Placement Disruption"                                        
#[9] "Adoption Placement"                                           "Move Made in Accordance with Case Plan Goal (Includes APPLA)"
#[11] "Death of Child"                                              "APPLA (Another Planned Permanent Living Arrangement)"        
#[13] "Child Requested Change"                                      "Runaway - NOT Closing Case"                                  
#[15] "Hospitalization (more than 30 days)"                         "Incarceration/Detention"                                     
#[17] "Birthday Batch"                                              "Placement with a fit and willing Relative"                   
#[19] "Reunited with Removal Home Caregiver-Not Parent"             "Duplicate"                                                   
#[21] "Adoption Disruption"                                         "Provider No Longer Licensed"   

# Filter RemovalTrack for specific End Reason ("result") above
customflow <- filter(RemovalTrack, RemovalTrack$EndReason_Discharge == result)

# Set Services as factor, find out count of each service provided for children from FILTERED df
customflow$EndReason_afterReentry <- as.factor(customflow$EndReason_afterReentry)
percentage_begin <- as.data.frame(summary(customflow$EndReason_afterReentry))

# Create df for percentages
write.csv(percentage_begin, "percentage_begin_col.csv")
percentage_begin <- read_csv("percentage_begin_col.csv")

# Once imported with first column, rename columns
names(percentage_begin) = c("End Reason on Re-entry Case", "Freq")

sum_of_freq <- sum(percentage_begin$Freq)  # Find sum of all cases
reentry_percentages <- mutate(percentage_begin, Percent = (Freq / sum_of_freq)*100)  # Find percentage each type of 2nd case was

remove(result, sum_of_freq, percentage_begin)

# Now this is the percentages of the second case AFTER the child's first result was
# "result" at the beginning of this script
View(reentry_percentages)
write.csv(reentry_percentages, "EndReasons_ReentryCases_afterReunified.csv")



# PIE CHART
library(ggplot2)

bp <- ggplot(reentry_percentages, aes(x="", y=Percent, fill=`End Reason on Re-entry Case`)) +
  geom_bar(width = 1, stat = "identity")

pie <- bp + coord_polar("y", start=0) +  
  ggtitle("Reunification Cases: End Reasons after Re-entry") + theme_void()
  


pie




