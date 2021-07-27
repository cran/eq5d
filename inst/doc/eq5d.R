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

#EQ-5D-Y using the Slovenian cTTO value set
eq5d(scores=13321, country="Slovenia", version="Y", type="cTTO")

#EQ-5D-5L crosswalk
eq5d(scores=55555, country="Spain", version="5L", type="CW")

#EQ-5D-3L reverse crosswalk
eq5d(scores=33333, country="Germany", version="3L", type="RCW")

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

## ----eq5dcf-------------------------------------------------------------------
library(readxl)

#load example data
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

#run eq5dcf function on a data.frame
res <- eq5dcf(data, "3L")

# Return data.frame of cumulative frequency stats (top 6 returned for brevity).
head(res)


## ----eq5dlss------------------------------------------------------------------
lss(c(MO=1,SC=2,UA=3,PD=2,AD=1), version="3L")

lss(55555, version="5L")

lss(c(11111,12345, 55555), version="5L")


## ----eq5dlfs------------------------------------------------------------------
lfs(c(MO=1,SC=2,UA=3,PD=2,AD=1), version="3L")

lfs(55555, version="5L")

lfs(c(11111,12345, 55555), version="5L")


## ----pchc---------------------------------------------------------------------
library(readxl)

#load example data
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

#use first 50 entries of each group as pre/post
pre <- data[data$Group=="Group1",][1:50,]
post <- data[data$Group=="Group2",][1:50,]

#run pchc function on data.frames

#Show no change, improve, worse, mixed without totals
res1 <- pchc(pre, post, version="3L", no.problems=FALSE, totals=FALSE)
res1

#Show totals, but not those with no problems
res2 <- pchc(pre, post, version="3L", no.problems=FALSE, totals=TRUE)
res2

#Show totals and no problems for each dimension
res3 <- pchc(pre, post, version="3L", no.problems=TRUE, totals=TRUE, by.dimension=TRUE)
res3


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
getDimensionsFromHealthStates(c("12345", "54321"), version="5L")


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

