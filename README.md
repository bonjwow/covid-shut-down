## About The Project

The purpose of this project was to examine the effects shutting down indoor dining services and switching restaurants to a take-out/delivery only based business model in light of COVID-19 restrictions in Toronto. Results were written up based on survey [data](https://github.com/bonjwow/covid-shut-down/blob/main/inputs/data/simulated_data.csv) simulated in R. A pdf of the final report can be viewed [here](https://github.com/bonjwow/covid-shut-down/blob/main/outputs/paper/paper.pdf).

## Package Requirments
* R
* tidyverse
* dplyr
* janitor
* purr
* broom
* ggplot2
* ggthemes
* LaCroixColoR
* kableExtra
* knitr
* bookdown
* tinytex

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
