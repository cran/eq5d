## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----dsu_valuesets------------------------------------------------------------
  library(eq5d)

  # DSU EQ-5D-5L to EQ-5D-3L UK value set
  valuesets(version = "5L", type = "DSU", country = "UK")

  ## All DSU EQ-5D-5L to EQ-5D-3L value sets
  valuesets(version = "5L", type = "DSU")


## ----dsu_dimensions_1---------------------------------------------------------

# Using age in years and sex as "m"
eq5d(c(MO=1, SC=2, UA=3, PD=4, AD=5), type = "DSU", country = "UK", age = 43, version = "5L", sex = "m")

# Using an age category and sex as "Male"
eq5d(12345, type = "DSU", country = "UK", age = 2, version = "5L", sex = "Male")


## ----dsu_dimensions_2---------------------------------------------------------

# get states and create data.frame
set.seed(12345)
dat1 <- data.frame(State = sample(getHealthStates("5L"), 10), 
                   Age = sample(18:100, 10), 
                   Sex = sample(c("M","F"), replace = TRUE, 10))

print(dat1)

eq5d(dat1, version="5L", type="DSU", country="UK")


## ----dsu_exact_utility--------------------------------------------------------

# Using utility score 0.322 (score for state 12345), an age category and sex as "Male"
eq5d(0.322, type = "DSU", country = "UK", age = 2, version = "5L", sex = "Male")


# Multiple states

# create data.frame of utility scores using the 2018 EQ-5D-5L value set for England for the states in dat1
dat2 <- data.frame(Utility = eq5d(dat1$State, version = "5L", type = "VT", country = "England"), 
                   Age = dat1$Age,
                   Sex = dat1$Sex)
                   
print(dat2)

eq5d(dat2, version="5L", type="DSU", country="UK")


## ----dsu_summary_utility------------------------------------------------------

# Get all utility scores from 2018 EQ‑5D‑5L value set for England 
exist.utils <- unique(DSU5L$UK)
min <- min(DSU5L$UK)
max <- max(DSU5L$UK)

# calculate range of values between min and max
poss.utils <- seq(from=min, to=max, by=0.001)

# create data.frame of 10 utility scores that aren't in the 2018 EQ‑5D‑5L value set for England 
set.seed(54321)
dat3 <- data.frame(Utility = sample(poss.utils[which(!poss.utils %in% exist.utils)], 10),
                   Age = sample(18:100, 10), 
                   Sex = sample(c("M","F"), replace = TRUE, 10))

print(dat3)

# map scores using a single bandwidth value for all scores
eq5d(dat3, version="5L", type="DSU", country="UK", bwidth=0.2)

# add bwidth column with values based on the DSU recommendations
dat3$bwidth <- c(0.2, 0.1, 0.2, 0.2, 0.1, 0.2, 0.2, 0.2, 0.2, 0.01)

eq5d(dat3, version="5L", type="DSU", country="UK")


