#---
#title: "Upward Mobility analysis"
#author: "Alex Haase"
#output:
#  word_document: default
#  pdf_document: default
#  html_document: default
#---
#Overview
#```{r}
#External Requirements: None - all computers used standard R libraries
#```

#```{r}
rm(list=ls()) # clear global environment
getwd() # double check wd

mobility = read.csv("mobility5.csv", TRUE, ",")
class(mobility) #turns the data 'mobility' into a dataframe
#```

#Confidence Intervals
#```{r}
wilsonCI = function(n,p) {
  k = qnorm(0.975)
  q = 1 - p
  lowerbound = (n*p + (k^2)/2)/(n+k^2) - (k*n^(1/2)*((p*q+(k^2)/(4*n))^(1/2)))/(n+k^2)
  upperbound = (n*p + (k^2)/2)/(n+k^2) + (k*n^(1/2)*((p*q+(k^2)/(4*n))^(1/2)))/(n+k^2)
  CI = c(lowerbound, upperbound)
  #print(CI) #prints the CI
}

zone = mobility$zone
n.lowstart = mobility$n.lowstart
p.upmover = mobility$p.upmover

for (i in 1:nrow(mobility)) {
  wilCI = wilsonCI(n.lowstart[i], p.upmover[i]) 
  print(as.character(zone)[i])
  print(wilCI)
  #sprintf(as.character(zone)[i], wilCI)
}
#```

#-------------------------------------------------
#likelihood ratio test multiple parameters

#p_upmover and n_lowstart are vectors for proportions for
#all the cities and their sample sizes 

#```{r}
n_lowstart = as.vector(mobility$n.lowstart)
p_upmover = as.vector(mobility$p.upmover)

#n_lowstart #n.lowstart data (vector)
#p_upmover #p.upmover data (vector)

#under H0, the MLE is:
p_hat_H0 = sum(n_lowstart*p_upmover)/sum(n_lowstart)
p_hat_H0 # = 0.07850242
  
#under Ha, the MLE is: 
p_hat_Ha = p_upmover
  
west = subset(mobility, region == 'west')
midwest = subset(mobility, region == 'midwest')
northeast = subset(mobility, region == 'northeast')
south = subset(mobility, region == 'south')

p_w = sum(west$n.lowstart*west$p.upmover)/sum(west$n.lowstart) #west
p_mw = sum(midwest$n.lowstart*midwest$p.upmover)/sum(midwest$n.lowstart) #midwest
p_ne = sum(northeast$n.lowstart*northeast$p.upmover)/sum(northeast$n.lowstart) #northeast
p_s = sum(south$n.lowstart*south$p.upmover)/sum(south$n.lowstart) #south

p_hat_vec = c(p_w, p_mw, p_ne, p_s)
p_0_vec = c(p_hat_H0,p_hat_H0)

n_l_region = c(sum(west$n.lowstart,sum(midwest$n.lowstart)))
n_l_region
n_l_region = c(sum(west$n.lowstart),sum(midwest$n.lowstart))

p_u_r = c(p_w, p_mw, p_ne, p_s)

log_lik = function(p) {
     sum(dbinom(round(n_l_region*p_u_r), size = n_l_region, prob = p, log = T))
}

testStatistic = 2*(log_lik(p_hat_vec) - log_lik(p_0_vec)) #test statistic
testStatistic

#compare to chi-square on 3 degree's of freedom
chisq = pchisq(testStatistic, 3, lower = F)
chisq
#```