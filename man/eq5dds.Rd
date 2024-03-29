% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eq5dds.R
\name{eq5dds}
\alias{eq5dds}
\title{Analyse the descriptive system of an EQ-5D dataset}
\usage{
eq5dds(data, version, counts = FALSE, by = NULL, ignore.invalid = TRUE, ...)
}
\arguments{
\item{data}{numeric or data.frame with names/colnames MO, SC, UA, PD and AD
representing Mobility, Self-care, Usual activities, Pain/discomfort and
Anxiety/depression. Alternatively an EQ-5D  score can be provided in
five digit format e.g. 12321.}

\item{version}{string of value "3L" or "5L" to indicate instrument version.}

\item{counts}{logical show absolute counts in the summary table. Default is 
FALSE, which shows percentages for each EQ-5D dimension.}

\item{by}{character specifying the column in the data.frame by which to 
group the results.}

\item{ignore.invalid}{boolean whether to ignore invalid scores. TRUE returns NA, FALSE 
throws an error.}

\item{...}{character vector, specifying "dimensions" column names. Defaults 
are "MO", "SC", "UA", "PD" and "AD".}
}
\value{
a data.frame or list of data.frames of counts/percentages. Columns 
contain dimensions names and rows the EQ-5D score.
}
\description{
Analyses the descriptive components of an EQ-5D dataset producing summary 
information either as counts or as percentages.
}
\examples{
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

}
