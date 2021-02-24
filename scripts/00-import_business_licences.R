#### Preamble ####
# Purpose: Get the most updated Municipal Licensing and Standards data from Open Data Portal
# Authors: Bongju, Morgaine, Najma, and Rachit 
# Contacts: bongju.yoo@mail.utoronto.ca, morgaine.westin@mail.utoronto.ca, naj.osman@mail.utoronto.ca, and rachit.srivastava@mail.utoronto.ca 
# Date: 9 February 2021
# Pre-requisites: None


#### Workspace set-up ####
install.packages("opendatatoronto")
library(opendatatoronto)
library(tidyverse)

#### Check the list ####
listPckg <- list_packages()

#### Get data ####
all_data <-
  opendatatoronto::search_packages("Business Licences and Permits") %>%
  opendatatoronto::list_package_resources() %>%
  filter(name == "Business licences data") %>%
  select(id) %>%
  opendatatoronto::get_resource()
  
#### Save data ### 
# write_csv(all_data, "inputs/data/raw_business_licences.csv")
  # note: Unable to retrieve the data set from the 'opendatatoronto' package due to a unknown error on their end.
