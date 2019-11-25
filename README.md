# FosterCare_Project
R programs for analyzing 8 years of records of foster care placement: preparing for machine learning, extrapolating values, deeper analysis (feature engineering: ranking & weighing different case types, etc), and combining data into single dataframes (ex. `all_numbers`) in order to best suit analysis procedures. Some adapted codes for models also in this repository - remember to set proper columns / characteristics.  </br>

The purpose of this project is to use statistical analysis, machine learning, and data science tools and procedures to find insights into how child welfare servies can be improved in Northern Florida.  With the help of a local company who shared their data, I was able to build a number of different programs / data analysis schemes that aided in the understanding of the associated foster care records as a whole. These records spanned from 2010 to 2017, with approximately 40,000 total cases and 170,000 participants (including children, parents, caregivers, etc).  </br>

Children's cases are often imperfect and they can "bounce" around the system in different placement settings, then leave, and come back for further cases.  One of the main goals of this project was to find any characteristics or identifiable factors that would lead to a child being removed from his or her family multiple times, and/or be re-entered into the system after being placed out of it. As discovered, the majority of the children in the given data have multiple records, different placement types, and multiple caregivers, making this initiative a multi-faceted and complex one. </br>

## Published Research

My published research article [can be found directly here (for free!)](https://commons.erau.edu/beyond/vol3/iss1/3/).

Spring 2019 results poster ([availabe in higher resolution](https://docdro.id/2SOtXoP))

News article about this project [can be read here](https://news.erau.edu/headlines/data-science-offers-new-tools-for-understanding-foster-care-outcomes).

![poster2019](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/posters/poster-spring-19.png)

## Table of Contents
![Data Manipulation / Feature Eng. Programs](FosterCare_Project#data-manipulation--feature-engineering-programs) </br>
![Machine Learning Programs](https://github.com/mathemacode/FosterCare_Project#machine-learning-programs) </br>
![Removal Data Manipulation Programs](https://github.com/mathemacode/FosterCare_Project#data-manipulation-removals-info-programs) </br>
![Analysis in Progress](https://github.com/mathemacode/FosterCare_Project#analysis-in-progress) </br>
![Placement Tracking](https://github.com/mathemacode/FosterCare_Project#placement-tracking) </br>
![Characteristic Analysis & Random Forest Model](https://github.com/mathemacode/FosterCare_Project#characteristic-analysis--random-forest) </br>
![Statistical Analysis using Top Influences](https://github.com/mathemacode/FosterCare_Project#statistical-analysis-using-top-influences) </br>
![Removal to Re-Entry Case Tracking](https://github.com/mathemacode/FosterCare_Project#removal-to-re-entry-case-tracking) </br>
![Reunification Cases Removal Tracking](https://github.com/mathemacode/FosterCare_Project#reunification-cases-removal-tracking) </br>
![Neural Network](https://github.com/mathemacode/FosterCare_Project#neural-network) </br>
![Random Forest Model using Removal Tracking](https://github.com/mathemacode/FosterCare_Project#results-random-forest-on-removal-data) </br>
![Decision Tree Model](https://github.com/mathemacode/FosterCare_Project#decision-tree) </br>
![Geographic Heat Mapping](https://github.com/mathemacode/FosterCare_Project#geographic-heat-mapping) </br>


# Data Manipulation & Feature Engineering Programs
Reproducible design; most programs build a dataframe that is used by other programs for deeper insights. Feature engineering became a pivotal piece of the project before machine learning could be done, so these programs then lead into the construction of a dataframe with numerical characteristics.  This final dataframe, `all_numbers`, was used for machine learning and statistical analysis.  </br>

 1. isolate_removals_1to5.R        
    - outputs each number case as dataframe (ex. `second_removals`)
 
 2. Sets.R                         
    - creates percentages for movements within removal dataframes ^^ </br>
    - these percentages do not consider the case BEFORE the current one
 
 3. merge_FIRST_THROUGH_FIFTH.R    
    - outputs wide file `paths` with 1-5 placements
 
 4. match_flow.R                   
    - uses `paths` to track specific placement type through case history </br>
    - outputs `child_flow_custom`
 
 5. find_percent_OF_FIRST_CASES.R  
 6. find_percent_SECOND_outcome.R
 7. find_percent_THIRD_outcome.R </br>
    - 5-7 use child_flow_custom to calculate % of A to B movements (user chooses A & B)  </br>
    - these percentages WILL consider the case BEFORE the current one (as specified by user)
 
 8. build_rank_system.R  </br>
    - isolates last case of each child and pulls information </br>
    - feature engineering, builds ranking system using last placement in case
 
 9. all_numbers_merge_data.R       
    - feature engineering, extrapolates & calculates columns of features for machine learning </br>
    - examples: case duration (in days), number of participants, average caregiver age, pop density
 
10. WEIGHT_MOVEMENTS.R             
    - final feature engineering scheme, "weights" entirety of case history, not just last place </br>
    - `all_numbers` dataframe complete and ready for machine learning </br>

# Machine Learning Programs
11. Neural_Network_Builder.R </br>
12. Random_Forest_Builder.R </br>
13. Decision_Tree_Builder.R </br>
14. Random_Forest_Build_REMOVALS.R </br>
    - 11-14 are models </br>
    - adapted from public code, use `all_numbers` or `ML_removals` to build model </br>
    - RF also uses ggplot2 to visualize case success influences </br>

# Data Manipulation: Removals Info Programs
15. reason_for_rem.R </br>
    - creates data frame with details about why child was removed and then re-entered </br>
    - has place, service, end reasons for removal AND RE-ENTRY TO SYSTEM information </br>

16. track_removals_endreasons.R </br>
    - builds percentages table of a child's END REASON on RE-ENTRY CASE </br>
    - user can select what end reason of FIRST REMOVAL was (say, reunification) </br>

17. removals_build_FULL.R </br>
    - similar to `merge_FIRST_THROUGH_FIFTH.R` </br>
    - tracks REMOVALS, not placements, with placement / service / end reason for each </br>
    - also calculates length of time between removals (in days) </br>
    - only does up to 4 removals (highest # of out-of-home episode types is 4) </br>
    - outputes WIDE file `ALL_REMS_WIDE.csv` </br>

18. removals_build_PERCENTS.R </br>
    - builds full table of % of each `Placement Setting` or `Service` per a certain `End Reason` </br>
    - these Place/Services are in the 2nd and 3rd removals </br>
    - user can select `End Reason` of 1st and 2nd removals </br>

19. removals_build_ML_FRAME.R </br>
    - takes removal data conglomerated in past few programs </br>
    - merges into machine learning df with `all_numbers` details </br>
    - creates `ML_removals` df in R Studio </br>

The goal currently with these new programs is to visualize what is happening when children are reunified with their parents, then pulled out from that home for the second time (their second removal).  If they also have a 3rd removal, see what sorts of services / end reasons those cases have too.  </br>

# Analysis in Progress
### Custom statistical algorithm
20. STAT_algorithm.R </br>
    - custom algorithm to find the most influential characteristics </br>
    - concept is fairly simple, see code for more details </br>
    - uses ML_removals, and outputs `STAT_ALG` and `STAT_ALG_RESULTS.csv` </br>
    - current work: need to normalize data in algorithm to make this more statistically robust
    - this algorithm has been worked on in another repo called [HAMR](https://github.com/mathemacode/HAMR); it is still
    under verification & validation.  Main results for this project are still from the random forest model.

The current results of this algorithm are as follows - which are notably different than the result of the models:

![STAT_ALG](https://raw.githubusercontent.com/mathemacode/HAMR/master/plots/STAT_ALG_SampleResult2.png)

### SPSS Analysis
SPSS factor analysis results so far are showing very weak correlations in the data, seemingly due to missing data (this
analysis was done with roughly 1,600 records).  I have recently added a SPSS folder to track some of the findings with this tool.

![SPSS_Results](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/SPSS/weight_corr_results.png)

I feared that going back and doing more statistical analysis on the raw data (with some derived attributes here) would
result the same way that the initial analysis of the data did back in 2018.  Without considering movement / placement
tracking, there are no deep enough characteristics that stick out as predictors of the "Weight".  This was the main
reason why I worked in R instead of something like SPSS, because what's really needed are *algorithms*, not statistical
analysis.  Nonetheless, I'm working on learning SPSS and will see what I can come up with.  I suppose even clustering
by number of removals, or weights, may highlight something I have not yet seen.

# Placement Tracking
How children's placements over time as they move through the foster care system effect if their case ends after a specific placement or if they continue with further placements in the system / moving to better (or worse) placements.</br>

I built this multi-layered pie chart that includes the placement settings of the child after the three top first settings
(from pie chart): Foster Home - Relative, Foster Home - NonRelative, and Institution.</br>

The outer rings of the pie show the percentage of children that went to the indicated placement setting, after this first setting. To be clear, this only visualizes the first and second placements. The R programs that we built can track any number of cases, but after three or four the amount of data starts to dwindle significantly, so tracking beyond that point has so far been fairly unfruitful.  </br></br>

Having “No Case” is a significant insight because it means that when the program was run, there was an “NA” in the data for the next case. This means that there is no additional record for this child after moving out of a placement setting. This is good because I can assume that the child does not have a need to be re-entered into the system and was provided for properly by the system. One of the original goals of this research was to find factors that influenced this sort of behavior, so, from this visualization, I can conclude the following:</br></br>

● After Foster Relative - highest chance (55%) of leaving system</br>
● After Foster-Not Relative - high chance (75%) of staying in system</br>
● After Institution - lowest chance (9%) of leaving system</br>
● Highest chance of going to Pre-Adoptive Home after Foster-Relative (12%)</br>
</br>

Foster care with a relative is a clear influence on a child's retention decreasing.  In addition to the insights that can be extrapolated from this visualization, I also discovered that 98% of the children who move into the Pre-Adoption placement setting (which is ONLY a significant movement after foster with a relative), do not return for any further cases.  This is more proof that foster care with a relative is superior than with a non-relative. </br>

![Pie](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Pie_FINAL.PNG) </br>


# Characteristic Analysis & Random Forest
After building the feature engineering R program to calculate the "weight" of each case, the next step was to determine the most influential factors / characteristics of the success of child's cases in foster care system (higher success = higher likelyhood of being provided for properly and exiting system).  The success factor was used as the characteristic to be predicted, based off of various other details about the child's case, their caregivers, location, etc.  The result was discovered via a random forest model in R, and plotted in ggplot2.

Influencing factors: </br>
1) `Case Duration`: actual duration of case, in days, from case begin date to case end date </br>
2) `Age`: age of child during associated case (estimated with MM/YYYY) </br>
3) `CareAge`: age of caregiver (estimated with MM/YYYY) </br>
4) `NumParticipants`: number of people involved in case (parents, caregivers, other children, relatives, etc) </br>
5) `PerCapIncome`: income per capita of associated case zip code </br>
6) `MedHousIncome`: median household income
7) `NumCaregivers`: number of caregivers in case
8) `VC`: violent crime rate
9) `ZipDens`: density of zip code per square mile
10) `ZipCount`: number of other cases in same zip code as case
11) `AvgHome`: average cost of a house in area
12) `PC`: property crime rate
13) `Zip`: zip code where case took place
14) `PercUnder18`: percent of population in zip under 18
15) `LowBirthWeight`: rate of low birth weights in zip
16) `InfantMortRate`: rate of infant mortality in zip
17) `JuvDelinquency`: rate of junvinile delinquency in zip
18) `ProbZip`: a factor created to track the most densely packed zip codes in terms of cases </br>

![Influences](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Influences_Inc_CrimeData.png) </br>

This plot here also incorporates the use of the crime/financial data, which was created by another team member.  It included financial and crime statistics for about 60 of the most populated zip codes in the data set.  Turns out that this was fairly important in the first 5 influences. </br>

# Statistical Analysis using Top Influences
This is not all-inclusive yet of removals analysis, but gives good insight into what is a positive and/or negative influence on a child's case in the foster care system.  These results were found based on statistical analysis aided using the Random Forest model's results.  I took the average value and compared who was above/below that value. </br>

![Results](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Results_Influences.PNG) </br>

# Removal to Re-Entry Case Tracking
Children are removed from their homes to start their path in the foster care system, but then they many times are also removed from the placements that they are put into.  It may take a number of days, weeks, months, or years for them to return.  After speaking with the company, they recommended that I track how children are reunified with their parents as an End Reason, and why they are put back into the system after this.  This would imply that they are then removed AGAIN out of the same home that they were originally taken out of.  I built more programs (#'s 15, 16, 17, 18, 19) to track these "re-entry" case details as children are brought back out of the same home that they first were taken out of, for a second time. </br>

![EndReasons](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Reunified_Removed_EndReasons.PNG) </br>

# Reunification Cases; Removal Tracking  
Children who's first removal is marked with an end reason of "Reunification with Parents".  Which placements and services do these children move into after their 1st removal ends in reunification?  </br>

![Reunified_Places](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Placements_after_Reunification.PNG) </br>

![Reunified_Services](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Services_after_Reunification.PNG)  </br>


# Neural Network
The neural network was used to assess the capability of machine learning models to accurately predict the "success" of a case (the "Weight" feature that we engineered earlier).  This model below also includes the crime data; it was actually created solely to test if there was enough data in our statistical analysis / machine learning dataframe "all_numbers", to determine if more data was needed to make a more accurate prediction.  To our surprise, this was extremely accurate, so I did not need to source out any additional details beyond what I had. </br>

![NeuralNet](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/Neural_with_Crime.PNG) </br>

Once this neural network was done (error was only 4.5%), I knew that I had enough data to make accurate predictions with for the "weight" (the success factor).

# Results: Random Forest on Removal Data
Once again, incredible results with the RF model using R.  This time, different characteristics show up that were in the ML_Removals df created by the removals programs.  Lots of good insights here.  </br>

![RF_with_RemovalData](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/RF_result_RemovalData.PNG) </br>

If I just use the newer removal data in the ML frame to make the prediction for case success to see how it ranks:

![RF_only_RemovalData](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/RF_result_RemovalDataOnly.PNG) </br>


# Decision Tree
I used a number of different decision trees in an attempt to gain more insight out of the data.  However, most of the results were self-explanatory.  For example, below, we can see that a lower Rank usually results in a higher Weight.  This makes sense because Rank was based off of the success of a child's final case.  A lower Rank means a less successful case result, so the child would most likely have a higher Weight for their entire case as well. 

![DecTree](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/dectree_WEIGHT_RANK.png) </br>


# Geographic Heat Mapping
The goal of heat mapping the data (there were ~900 unique zip codes present) was to see if any areas particularly stuck out as having a high number of cases per capita.</br>

![HeatMap](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/plots/HeatMap_COMPARE.png) </br>
