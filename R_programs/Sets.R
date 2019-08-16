# This program takes End Reasons, Services, and Settings,
# and creates tables of what percentage each child had
# the factors in these columns for their 1st, 2nd, and
# 3rd case.  Files created = end_reasons, services, settings.

# ================================================
# End Reasons

first_end <- table(first_removals$`End Reason`)
first_end <- as.data.frame(first_end)
second_end <- table(second_removals$`End Reason`)
second_end <- as.data.frame(second_end)
third_end <- table(third_removals$`End Reason`)
third_end <- as.data.frame(third_end)

# Sums of children to find percentage
first_sum <- sum(first_end$Freq)
second_sum <- sum(second_end$Freq)
third_sum <- sum(third_end$Freq)

# Create blank data frames for percentages
first_percent <- as.data.frame(first_end[,])
second_percent <- as.data.frame(second_end[,])
third_percent <- as.data.frame(third_end[,])

# Calculate percentages of each (first, second, third)
i <- 1
for (entry in first_end$Freq){
  first_percent[i, 2] <- (first_end[i,2] / first_sum) *100
  second_percent[i, 2] <- (second_end[i,2] / second_sum) *100
  third_percent[i, 2] <- (third_end[i,2] / third_sum) *100
  i = i+1
  
}

# Merge percentages
end_reasons_first <- merge(first_end, first_percent, by='Var1', all=TRUE)
end_reasons_second <- merge(second_end, second_percent, by='Var1', all=TRUE)
end_reasons_third <- merge(third_end, third_percent, by='Var1', all=TRUE)

# Merge ends (first, second, third) with their percentages
end_reasons <- merge(end_reasons_first, end_reasons_second, by='Var1', all=TRUE)
end_reasons <- merge(end_reasons, end_reasons_third, by='Var1', all=TRUE)

names(end_reasons) = c("End Reason", "Case1", "Percent1", "Case2", "Percent2", "Case3", "Percent3")
write.csv(end_reasons, "end_reasons.csv")

remove(first_end, second_end, third_end)
remove(end_reasons_first, end_reasons_second, end_reasons_third)
remove(first_percent, second_percent, third_percent)
remove(first_sum, second_sum, third_sum)


#===================================================================
# Services

first_serve <- table(first_removals$Service)
first_serve <- as.data.frame(first_serve)
second_serve <- table(second_removals$Service)
second_serve <- as.data.frame(second_serve)
third_serve <- table(third_removals$Service)
third_serve <- as.data.frame(third_serve)

# Sums of children to find percentage
first_sum <- sum(first_serve$Freq)
second_sum <- sum(second_serve$Freq)
third_sum <- sum(third_serve$Freq)

# Create blank data frames for percentages
first_percent <- as.data.frame(first_serve[,])
second_percent <- as.data.frame(second_serve[,])
third_percent <- as.data.frame(third_serve[,])

# Calculate percentages of each (first, second, third)
i <- 1
for (entry in first_serve$Freq){
  first_percent[i, 2] <- (first_serve[i,2] / first_sum) *100
  second_percent[i, 2] <- (second_serve[i,2] / second_sum) *100
  third_percent[i, 2] <- (third_serve[i,2] / third_sum) *100
  i = i+1
  
}

# Merge percentages
serve_first <- merge(first_serve, first_percent, by='Var1', all=TRUE)
serve_second <- merge(second_serve, second_percent, by='Var1', all=TRUE)
serve_third <- merge(third_serve, third_percent, by='Var1', all=TRUE)

# Merge ends (first, second, third) with their percentages
services <- merge(serve_first, serve_second, by='Var1', all=TRUE)
services <- merge(services, serve_third, by='Var1', all=TRUE)

names(services) = c("Services", "Case1", "Percent1", "Case2", "Percent2", "Case3", "Percent3")
write.csv(services, "services.csv")

remove(first_serve, second_serve, third_serve)
remove(serve_first, serve_second, serve_third)
remove(first_sum, second_sum, third_sum)
remove(first_percent, second_percent, third_percent)

#===============================================================
# Placement Settings
first_set <- table(first_removals$`Placement Setting`)
first_set <- as.data.frame(first_set)
second_set <- table(second_removals$`Placement Setting`)
second_set <- as.data.frame(second_set)
third_set <- table(third_removals$`Placement Setting`)
third_set <- as.data.frame(third_set)

# Sums of children to find percentage
first_sum <- sum(first_set$Freq)
second_sum <- sum(second_set$Freq)
third_sum <- sum(third_set$Freq)

# Create blank data frames for percentages
first_percent <- as.data.frame(first_set[,])
second_percent <- as.data.frame(second_set[,])
third_percent <- as.data.frame(third_set[,])

# Calculate percentages of each (first, second, third)
i <- 1
for (entry in first_set$Freq){
  first_percent[i, 2] <- (first_set[i,2] / first_sum) *100
  second_percent[i, 2] <- (second_set[i,2] / second_sum) *100
  third_percent[i, 2] <- (third_set[i,2] / third_sum) *100
  i = i+1
  
}

# Merge percentages
set_first <- merge(first_set, first_percent, by='Var1', all=TRUE)
set_second <- merge(second_set, second_percent, by='Var1', all=TRUE)
set_third <- merge(third_set, third_percent, by='Var1', all=TRUE)

# Merge settings (first, second, third) with their percentages
settings <- merge(set_first, set_second, by='Var1', all=TRUE)
settings <- merge(settings, set_third, by='Var1', all=TRUE)

names(settings) = c("Settings", "Case1", "Percent1", "Case2", "Percent2", "Case3", "Percent3")
write.csv(settings, "settings.csv")

remove(first_set, second_set, third_set)
remove(set_first, set_second, set_third)
remove(first_sum, second_sum, third_sum)
remove(first_percent, second_percent, third_percent)
remove(i, entry)

