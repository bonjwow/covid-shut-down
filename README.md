## About The Project
The purpose of this project was to examine the effects of switching restaurants to a take-out/delivery only based business model in light of COVID-19 restrictions of Toronto. Results were written up based on survey data simulated in R. 

## Requirments
* R
* tidyverse
* ggplot2
* kableExtra
* opendatatoronto
* ggthemes
* broom
* purr
* janitor

## Getting Started
1. Clone this repository
  ```sh
  git clone https://github.com/bonjwow/covid-shut-down.git
  ```
2. Run `00-import_business_licences.R` in the `scripts` folder to obtain the most updated data from Open Data Portal
3. Run `01-data_cleaning_business_licences.R` to clean the dataset
4. Run `02-simulated_data.R` to create simulated sample dataset

## License
Distributed under the MIT License. See `LICENSE` for more information.
