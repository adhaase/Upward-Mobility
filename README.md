# The Potential of Upward Mobility in Lower (income) Class Adults
Created an R script that analyzed the relationship between subjects who grew up in lower-income families on the basis of location and proportion of individuals reporting incomes in the top quintile by age 30. 

# Content Overview
We are provided a dataset concerning 40 subjects who grew up in lower-income families. Specifically, this dataset presented variables labeled: zone, state, region, N, n, n.lowstart, and p.upmover. In each sample, n is the overall number of subjects from the indicated “zone” and n.lowstart is the number of these subjects whose family income was in the bottom quintile of U.S. household incomes. The proportion of these individuals reporting incomes in the top quintile as of 2010 is presented as "p.upmover". This fraction is also a reflection of economic mobility that will be heavily utilized in the analysis phase. 

Interpretation of the upward mobility relationship will formulate from two main statistical outlets. I first studied upward mobility in each of the 40 commuting zones using the Wilson confidence interval for the 95% case. From there I then investigated how geography in terms of region (West, Midwest, Northeast, South) relates to upward mobility by using a Likelihood Ratio test over region and p.upmover. This R script essentially outlines the relationship between these variables to deduce the possibility of financial "upward mobility" in the life of a relatively lower income individual.

# Statistical Methods used in analysis:
* Created 95% confidence intervals utilizing the Wilson method
* Conducted hypothesis testing via the Likelihood Ratio test (as the dataset provided full binomial data, something like ANOVA/Tukey, etc. would have been unncessary)
