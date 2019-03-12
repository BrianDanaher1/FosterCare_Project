# FosterCare_Project
R programs for analyzing ~250,000 records of foster care placement: preparing for machine learning, extrapolating values, deeper analysis (ranking & weighing different case types, etc), and combining data into single dataframes (ex. "all_numbers") in order to best suit analysis procedures.

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


![Pie](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/Pie.PNG)


# Geographic Heat Mapping
![HeatMap](https://raw.githubusercontent.com/mathemacode/FosterCare_Project/master/HeatMap_COMPARE.png)
