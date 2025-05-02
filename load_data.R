### Load Data

#' @author Lauren White
#' @date '2024-12-31'
#' Load data sets needed to run `calculate_forecastability.Rmd`

# Setup -------------------------------------------------------------------
# Load libraries

library(data.table)
library(jsonlite)
library(epipredict)
library(httr)
library(RSocrata)
library(dplyr)
library(tidyr)
library(readr)
library(covidcast)
library(ggplot2)
library(tsibble)
library(MMWRweek)
library(geojsonsf)


# Load California county FIPS and population size info --------------------
spdf <- geojsonsf::geojson_sf("data/counties.geojson")
county_fips<-data.frame(county= spdf$NAME_1, county_fips= spdf$COUNTYFI_1) %>% mutate(county_fips=as.numeric(county_fips))

counties <- fread( "data/county_pop_dof.csv") %>% na.omit()
ca_pop<-sum(counties$dof_pop_county)
ca_pop<-data.frame(county="California", dof_pop_county=as.numeric(ca_pop))
counties<-counties %>% bind_rows(ca_pop)


# Load US demographic info ------------------------------------------------
# Load combined US demographic 2021 Census data from `/data/demog.csv`
demog<-read_csv("data/demog.csv") #contains 2021 US census population size, density, and state abbreviations (lowercase)


# Load hospital capacity --------------------------------------------------
# Load hospital capacity data sourced from HHS/NHSN data.
hosp_capacity<-read_csv("data/hosp_capacity.csv")


# Load number of facilities -----------------------------------------------
num_facilities<-read_csv("data/num_facilities.csv")


# Load predominant flu subtpye data ---------------------------------------
# This data set was generated manually from reviewing California Department of Public Health historical influenza reports: https://www.cdph.ca.gov/Programs/CID/DCDC/pages/immunization/flu-reports.aspx
flu_subtypes<-read_csv("data/CDPH_flu_subtypes.csv") %>% rename(season=Season)


# State & National COVID & Influenza Hospital Admission Data --------------
# Pull in state and national hospitalization admissions data for COVID-19 and influenza using Delphi's API.
# https://cmu-delphi.github.io/delphi-epidata/

covid_hosp_full<-read_csv("data/covid_hosp.csv")
flu_hosp_full<- read_csv("data/flu_hosp.csv")


# Total seasonal burden ---------------------------------------------------
seasonal_burden<-read_csv("data/seasonal_burden.csv")


# County level NHSN hospitalizations --------------------------------------
hosp_epi_df_county<-read_csv("data/covid_hosp_county.csv")
hosp_epi_df_county_flu<- read_csv("data/flu_hosp_county.csv")


# Load forecast actuals for scoring ---------------------------------------
CDC_actuals_raw<- read_csv("data/CDC_actuals_raw.csv")
COVID_actuals_weekly<-read_csv("data/COVID_actuals_weekly.csv")


