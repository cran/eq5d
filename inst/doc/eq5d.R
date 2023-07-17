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

#EQ-5D-5L to EQ-5D-3L NICE DSU mapping

#Using dimensions
eq5d(c(MO=1,SC=2,UA=3,PD=4,AD=5), version="5L", type="DSU", country="UK", age=23, sex="male")

#Using exact utility score
eq5d(0.922, country="UK", version="5L", type="DSU", age=18, sex="male")

#Using approximate utility score
eq5d(0.435, country="UK", version="5L", type="DSU", age=30, sex="female", bwidth=0.0001)

#multiple calculations using the Canadian VT value set

#data.frame with individual dimensions
scores.df <- data.frame(
  MO=c(1,2,3,4,5), SC=c(1,5,4,3,2), UA=c(1,5,2,3,1), PD=c(1,3,4,3,4), AD=c(1,2,1,2,1)
)

eq5d(scores.df, country="Canada", version="5L", type="VT")

#data.frame using five digit format
scores.df2 <- data.frame(state=c(11111, 25532, 34241, 43332, 52141))

eq5d(scores.df2, country="Canada", version="5L", type="VT", five.digit="state")

#or using a vector

eq5d(scores.df2$state, country="Canada", version="5L", type="VT")


## ----valuesets----------------------------------------------------------------
# Return TTO value sets with PubMed IDs and DOIs (top 6 returned for brevity).
head(valuesets(type="TTO", references=c("PubMed","DOI")))

# Return VAS value sets with ISBN and external URL (top 6 returned for brevity).
head(valuesets(type="VAS", references=c("ISBN","ExternalURL")))

# Return EQ-5D-5L value sets (top 6 returned for brevity).
head(valuesets(version="5L"))

# Return all French value sets.
valuesets(country="France")

# Return all EQ-5D-5L to EQ-5D-3L DSU value sets without references.
valuesets(type="DSU", version="5L", references=NULL)


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

lss(c(11111, 12345, 55555), version="5L")


## ----eq5dlfs------------------------------------------------------------------
lfs(c(MO=1,SC=2,UA=3,PD=2,AD=1), version="3L")

lfs(55555, version="5L")

lfs(c(11111, 12345, 55555), version="5L")


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

#Don't summarise. Return all classifications
res4 <- pchc(pre, post, version="3L", no.problems=TRUE, totals=FALSE, summary=FALSE)
head(res4)


## ----ps-----------------------------------------------------------------------
library(readxl)

#load example data
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

#use first 50 entries of each group as pre/post
pre <- data[data$Group=="Group1",][1:50,]
post <- data[data$Group=="Group2",][1:50,]

res <- ps(pre, post, version="3L")
res


## ----hpg----------------------------------------------------------------------
library(readxl)

#load example data
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

#use first 50 entries of each group as pre/post
pre <- data[data$Group=="Group1",][1:50,]
post <- data[data$Group=="Group2",][1:50,]

#run hpg function on data.frames

#Show pre/post rankings and PCHC classification
res <- hpg(pre, post, country="UK", version="3L", type="TTO")
head(res)

#Plot data using ggplot2
library(ggplot2)

ggplot(res, aes(Post, Pre, color=PCHC)) +
  geom_point(aes(shape=PCHC)) +
  coord_cartesian(xlim=c(1,243), ylim=c(1,243)) +
  scale_x_continuous(breaks=c(1,243)) +
  scale_y_continuous(breaks=c(1,243)) +
  annotate("segment", x=1, y=1, xend=243, yend=243, colour="black") +
  theme(panel.border=element_blank(), panel.grid.minor=element_blank()) +
  xlab("Post-treatment") +
  ylab("Pre-treatment")


## ----shannon------------------------------------------------------------------
library(readxl)

#load example data
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

#Shannon's H', H' max and J' for the whole dataset
shannon(data, version="3L", by.dimension=FALSE)

#Shannon's H', H' max and J' for each dimension
res <- shannon(data, version="3L", by.dimension=TRUE)

#Convert to data.frame for ease of viewing
do.call(rbind, res)


## ----hsdi---------------------------------------------------------------------
#load example data
data <- read_excel(system.file("extdata", "eq5d3l_example.xlsx", package="eq5d"))

#Calculate HSDI
hsdi <- hsdi(data, version="3L")

#Plot HSDC
cf <- eq5dcf(data, version="3L", proportions=T)
cf$CumulativeState <- 1:nrow(cf)/nrow(cf)

#Plot data using ggplot2
library(ggplot2)

ggplot(cf, aes(CumulativeProp, CumulativeState)) + 
  geom_line(color="#FF9999") + 
  annotate("segment", x=0, y=0, xend=1, yend=1, colour="black") +  
  annotate("text", x=0.5, y=0.9, label=paste0("HSDI=", hsdi)) +
  theme(panel.border=element_blank(), panel.grid.minor=element_blank()) +
  coord_cartesian(xlim=c(0,1), ylim=c(0,1)) +
  xlab("Cumulative proportion of observations") +
  ylab("Cumulative proportion of profiles")


## ----eq5dds-------------------------------------------------------------------
set.seed(12345)
dat <- data.frame(
         matrix(
           sample(1:3, 5*12, replace=TRUE), 12, 5, 
           dimnames=list(1:12, c("MO","SC","UA","PD","AD"))
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

