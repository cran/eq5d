## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----quickStart---------------------------------------------------------------
library(eq5d)

#single calculation

#named vector MO, SC, UA, PD and AD represent mobility, self-care, usual activites, pain/discomfort and anxiety/depression, respectfully.
scores <- c(MO=1,SC=2,UA=3,PD=2,AD=1)

#EQ-5D-3L using the UK TTO value set
eq5d(scores=scores, country="UK", version="3L", type="TTO")

#Using five digit format
eq5d(scores=12321, country="UK", version="3L", type="TTO")

#multiple calculations using the Canadian VT value set

#data.frame with individual dimensions
scores.df <- data.frame(
  MO=c(1,2,3,4,5), SC=c(1,5,4,3,2), UA=c(1,5,2,3,1), PD=c(1,3,4,3,4), AD=c(1,2,1,2,1)
)

eq5d(scores.df, country="Canada", version="5L", type="VT")

#data.frame using five digit format
scores.df2 <- data.frame(state=c(11111,25532,34241,43332,52141))

eq5d(scores.df2, country="Canada", version="5L", type="VT", five.digit="state")

#or using a vector

eq5d(scores.df2$state, country="Canada", version="5L", type="VT")


## ----valuesets----------------------------------------------------------------
# Return all value sets (top 6 returned for brevity).
head(valuesets())

# Return VAS based value sets (top 6 returned for brevity).
head(valuesets(type="VAS"))

# Return EQ-5D-5L value sets (top 6 returned for brevity).
head(valuesets(version="5L"))

# Return all UK value sets.
valuesets(country="UK")

## ----eq5dds-------------------------------------------------------------------

dat <- data.frame(
         matrix(
           sample(1:3,5*12, replace=TRUE),12,5, 
           dimnames=list(1:12,c("MO","SC","UA","PD","AD"))
         ),
         Sex=rep(c("Male", "Female"))
       )

eq5dds(dat, version="3L")

eq5dds(dat, version="3L", counts=TRUE)

eq5dds(dat, version="3L", by="Sex")


## ----helper-------------------------------------------------------------------

# Get all EQ-5D-3L five digit health states (top 6 returned for brevity).
head(getHealthStates("3L"))

# Split five digit health states into their individual components.
splitHealthStates(c("12345", "54321"), version="5L")


## ----example data-------------------------------------------------------------
# View example files.
dir(path=system.file("extdata", package="eq5d"))

# Read example EQ-5D-3L data.
library(readxl)
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

# Calculate index scores
scores <- eq5d(data, country="UK", version="3L", type="TTO")

# Top 6 scores
head(scores)

## ----shiny, echo=TRUE, eval=FALSE---------------------------------------------
#  shiny_eq5d()

