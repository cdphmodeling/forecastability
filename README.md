# forecastability
Analysis of infectious disease time series "forecastability" and corresponding forecast performance to reproduce the analysis documented
in the manuscript **"Forecastability of infectious disease time series: are some seasons and pathogens intrinsically more difficult to forecast?"**

Available at: https://medrxiv.org/cgi/content/short/2025.04.29.25326677v1

## Versioning
The code was written in R Version 4.0.4. This repo uses `renv` (https://rstudio.github.io/renv/articles/renv.html) for reproducibility. Relevant files for this are: `renv.lock`, `.Rprofile`, `renv/settings.json` and `renv/activate.R`.
If not prompted, make sure `renv` is installed and then run `renv::restore()` to download all necessary packages. 

## Repository structure
Repository contains the following folders:

1. `/data` - data that is provided to run the scripts, loaded from running `load_data.R` script (and optionally downloaded using `source_data.Rmd`)
2. `/results`- compiled results including forecastability scores and regression results produced via the `cacluate_forecastability.Rmd` and `forecast_eval.Rmd` scripts

## Scripts
Raw results for the manuscript can be reproduced by running these scripts in the following order:

0. `source_data.Rmd`- this is an *optional* file to run that sources data from a variety of locations (see "Data Sources"" description below). Data sourced from running this file is available in the `/data` folder and is subsequently loaded via the `load_data.R` file. 
1. `load_data.R`-loads data from the `/data` folder. This file is sourced in both the `calculate_forecastability.Rmd` and `forecast_eval.Rmd` files. 
2. `calculate_forecastability.Rmd`- calculates forecastability scores of NHSN data time series for both COVID-19 and influenza
3. `forecast_eval.Rmd`- computes the performance of forecasts from the FluSight challenge and the COVID-19 Forecast Hub; results are combined with forecastability scores generated from  `calculate_forecastability.Rmd` and are saved as `results/forecastability_results.csv`
4. `generate_figures.Rmd`- generates figure and table results to reproduce manuscript output; *note:* can also be run as a stand alone, by simply using output already saved in `/results` folder 

## Data Sources
- **California county population estimates:** California county population estimates were taken from 2020 California Department of Finance (DOF) estimates: https://dof.ca.gov/forecasting/demographics/. This is available within the repo as: `data/county_pop_dof.csv`.
- **State and national population estimates:** State and national population size estimates were taken from the 2021 US Census Bureau estimates (https://www.census.gov/data.html) using https://api.census.gov/data/2021/pep/population/variables.html. These data are available in: `data/demog.csv`
- **Predominant influenza sub-type:** to identify the predominant subtype for historical California influenza, the most frequently sequenced subtype was taken from historic Respiratory Laboratory Network (RLN) and clinical sentinel laboratory surveillance data  this data set was generated manually from reviewing California Department of Public Health historical influenza reports: https://www.cdph.ca.gov/Programs/CID/DCDC/pages/immunization/flu-reports.aspx
- **Forecast data:** Historical forecasts for state and national COVID-19 and influenza targets were obtained from the COVID-19 Forecast Hub and the FluSight Forecast Challenge, respectively, for the 2022-2023 and 2023-2024 respiratory virus seasons. Raw forecasts are compiled in: `data/raw_forecasts.gz.parquet` and loaded in `forecast_eval.Rmd`  
    - FluSight Forecast Hub repo: https://github.com/cdcepi/FluSight-forecast-hub
    - COVID Hub forecasts: https://github.com/reichlab/covid19-forecast-hub
- **Syndromic hospitalizations:** California county and state level syndromic influenza hospitalization data were derived the California Department of Healthcare Access and Information (HCAI) for the 2000-2022 respiratory virus seasons. Pre-processed data are available in: `results/hcai_burden.csv`, `results/hcai_combined.csv` and `results/hcai_state_omega.csv`
- **Lab confirmed hospitalizations:** State and national, laboratory-confirmed, COVID-19 and influenza hospitalization admission data were obtained from HHS/NHSN via Delphi COVIDcast for the 2022-2024 respiratory virus seasons. These data are also publicly available through HHS/NHSN for state: https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/g62h-syeh/about_data and facility-level time series:  https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/anag-cw7u/about_data