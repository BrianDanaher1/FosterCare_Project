# FosterCare_Project
R programs for analyzing ~250,000 records of foster care placement: preparing for machine learning, extrapolating values, deeper analysis (feature engineering: ranking & weighing different case types, etc), and combining data into single dataframes (ex. "all_numbers") in order to best suit analysis procedures. Some adapted codes for models also in this repository - remember to set proper columns / characteristics.  </br>

# Data Manipulation & Feature Engineering
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
--> "all_numbers" dataframe complete and ready for machine learning </br>

# Machine Learning
11) Neural_Network_Builder.R </br>
12) Random_Forest_Builder.R </br>
13) Decision_Tree_Builder.R </br>
--> 11-13 are models </br>
--> adapted from public code, use "all_numbers" to build model </br>
--> RF also uses GGPLOT to visualize case success influences </br>


# Placement Tracking
How children's placements over time as they move through the foster care system effect if they end up exiting the system, staying in the system, or moving to better (or worse) placements.  </br>

I built this multi-layered pie chart that includes the placement settings of the child after the three top first settings
(from pie chart): Foster Home - Relative, Foster Home - NonRelative, and Institution.</br></br>

The outer rings of the pie show the percentage of children that went to the indicated placement setting, after this first setting. To be clear, this only visualizes the first and second placements. The R programs that we built can track any number of cases, but after three or four the amount of data starts to dwindle significantly, so tracking beyond that point has so far been fairly unfruitful.  </br></br>

Having “No Case” is a significant insight because it means that when the program was run, there was an “NA” in the data for the next case. This means that there is no additional record for this child after moving out of a placement setting. This is good because I can assume that the child does not have a need to be re-entered into the system and was provided for properly by the system. One of the original goals of this research was to find factors that influenced this sort of behavior, so, from this visualization, I can conclude the following:</br></br>

● After Foster Relative - highest chance (55%) of leaving system</br>
● After Foster-Not Relative - high chance (75%) of staying in system</br>
● After Institution - lowest chance (9%) of leaving system</br>
● Highest chance of going to Pre-Adoptive Home after Foster-Relative (12%)</br>
</br>


![Pie](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/Pie_FINAL.PNG) </br>


# Factor Analysis
After building the feature engineering R program to calculate the "weight" of each case, the next step was to determine the most influential factors of the success of child's cases in foster care system (higher success = higher likelyhood of being provided for properly and exiting system).  Our success factor was used as the characteristic to be predicted, based off of various other details about the child's case, their caregivers, location, etc.  The result was discovered via a random forest model in R, and plotted in ggplot2.

Influencing factors: </br>
1) Case Duration: actual duration of case, in days, from case begin date to case end date </br>
2) Age: age of child during associated case (estimated with MM/YYYY) </br>
3) CareAge: age of caregiver (estimated with MM/YYYY) </br>
4) NumParticipants: number of people involved in case (parents, caregivers, other children, relatives, etc) </br>
5) PerCapIncome: income per capita of associated case zip code </br>
6) MedHousIncome: median household income
7) NumCaregivers: number of caregivers in case
8) VC: violent crime rate
9) ZipDens: density of zip code per square mile
10) ZipCount: number of other cases in same zip code as case
11) AvgHome: average cost of a house in area
12) PC: property crime rate
13) Zip: zip code where case took place
14) PercUnder18: percent of population in zip under 18
15) LowBirthWeight: rate of low birth weights in zip
16) InfantMortRate: rate of infant mortality in zip
17) JuvDelinquency: rate of junvinile delinquency in zip
18) ProbZip: a factor we created to track the most densely packed zip codes in terms of cases

![Influences](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/Influences_Inc_CrimeData.png) </br>

This plot here also incorporates the use of the crime/financial data, which was created by another team member.  It included financial and crime statistics for about 60 of the most populated zip codes in the data set.  Turns out that this was fairly important in the first 5 influences. </br>

# Decision Tree
I used a number of different decision trees in an attempt to gain more insight out of the data.  However, most of the results were self-explanatory.  For example, below, we can see that a lower Rank usually results in a higher Weight.  This makes sense because Rank was based off of the success of a child's final case.  A lower Rank means a less successful case result, so the child would most likely have a higher Weight for their entire case as well. 

![DecTree](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/dectree_WEIGHT_RANK.png) </br>

# Neural Network
The neural network was used to assess the capability of machine learning models to accurately predict the "success" of a case (the "Weight" feature that we engineered earlier).  This model below also includes the crime data; it was actually created solely to test if there was enough data in our statistical analysis / machine learning dataframe "all_numbers", to determine if more data was needed to make a more accurate prediction.  To our surprise, this was extremely accurate, so I did not need to source out any additional details beyond what I had.

![NeuralNet](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/Neural_with_Crime.PNG) </br>

# Geographic Heat Mapping
The goal of heat mapping the data (there were ~900 unique zip codes present) was to see if any areas particularly stuck out as having a high number of cases per capita.  Many did, however, the reasons for this are still being investigated.</br>

![HeatMap](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/HeatMap_COMPARE.png) </br>
