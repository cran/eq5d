## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----quickStart----------------------------------------------------------
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

eq5d(scores.df2, country="Canada", version="5L", type="VT")


## ----valuesets-----------------------------------------------------------
# Return all value sets (top 6 returned for brevity).
head(valuesets())

# Return VAS based value sets (top 6 returned for brevity).
head(valuesets(type="VAS"))

# Return EQ-5D-5L value sets (top 6 returned for brevity).
head(valuesets(version="5L"))

# Return all UK value sets.
valuesets(country="UK")

## ----shiny, echo=TRUE, eval=FALSE----------------------------------------
#  shiny_eq5d()

