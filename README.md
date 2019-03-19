# FosterCare_Project
R programs for analyzing ~250,000 records of foster care placement: preparing for machine learning, extrapolating values, deeper analysis (feature engineering: ranking & weighing different case types, etc), and combining data into single dataframes (ex. "all_numbers") in order to best suit analysis procedures. </br>

# Data Pipeline & Feature Engineering
Reproducible design, most programs build a dataframe that is used by other programs for deeper insights. Feature engineering became a pivotal piece of the project before machine learning could be done, so these programs then lead into the construction of a dataframe with numerical characteristics.  </br>

 1) isolate_removals_1to5.R        
 --> outputs each number case as dataframe (ex. "second_removals")
 
 2) Sets.R                         
 --> creates percentages for movements within removal dataframes ^^ </br>
 --> these percentages do not consider the case BEFORE the current one
 
 3) merge_FIRST_THROUGH_FIFTH.R    
 --> outputs wide file "paths" with 1-5 placements
 
 4) match_flow.R                   
 --> uses "paths" to track specific placement type through case history </br>
 --> outputs "child_flow_custom"
 
 5) find_percent_OF_FIRST_CASES.R  
 6) find_percent_SECOND_outcome.R
 7) find_percent_THIRD_outcome.R </br>
 --> 5-7 use child_flow_custom to calculate % of A to B movements (user chooses A & B)  </br>
 --> these percentages WILL consider the case BEFORE the current one (as specified by user)
 
 8) build_rank_system.R  </br>
 --> isolates last case of each child and pulls information </br>
 --> feature engineering, builds ranking system using last placement in case
 
 9) all_numbers_merge_data.R       
 --> feature engineering, extrapolates & calculates columns of features for machine learning </br>
 --> examples: case duration (in days), number of participants, average caregiver age, pop density
 
10) WEIGHT_MOVEMENTS.R             
--> final feature engineering scheme, "weights" entirety of case history, not just last place </br>
--> "all_numbers" dataframe complete and ready for machine learning

11) Random_Forest_Builder.R </br>
--> adapted from public code, uses "all_numbers" to build RF model </br>
--> uses GGPLOT to visualize case success influences


# Placement Tracking
How children's placements over time as they move through the foster care system effect if they end up exiting the system, staying in the system, or moving to better (or worse) placements.  </br>

Excerpt from research: </br>

"I built this multi-layered pie chart that includes the placement settings of the child after the three top first settings
(from pie chart): Foster Home - Relative, Foster Home - NonRelative, and Institution.</br></br>

The outer rings of the pie show the percentage of children that went to the indicated placement setting, after this first setting. To be clear, this only visualizes the first and second placements. The R programs that we built can track any number of cases, but after three or four the amount of data starts to dwindle significantly, so tracking beyond that point has so far been fairly unfruitful.  </br></br>

Having “No Case” is a significant insight because it means that when the program was run, there was an “NA” in the data for the next case. This means that there is no additional record for this child after moving out of a placement setting. This is good because I can assume that the child does not have a need to be re-entered into the system and was provided for properly by the system. One of the original goals of this research was to find factors that influenced this sort of behavior, so, from this visualization, I can conclude the following:</br></br>

● After Foster Relative - highest chance (55%) of leaving system</br>
● After Foster-Not Relative - high chance (75%) of staying in system</br>
● After Institution - lowest chance (9%) of leaving system</br>
● Highest chance of going to Pre-Adoptive Home after Foster-Relative (12%)</br>
</br>
"


![Pie](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/Pie.PNG) </br>


# Geographic Heat Mapping
![HeatMap](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/HeatMap_COMPARE.png) </br>

# Factor Analysis
Most important factors in determining success of child's cases in foster care system (higher success = higher likelyhood of being provided for properly and exiting system).  This was discovered via a random forest model in R, and plotted in ggplot2.

![Influences](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/Influences_Inc_CrimeData.png) </br>
