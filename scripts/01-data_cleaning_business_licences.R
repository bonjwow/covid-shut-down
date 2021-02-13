#### Preamble ####
# Purpose: Clean the Municipal Licensing and Standards data set
# Authors: Bongju, Morgaine, Najma, and Rachit 
# Contacts: bongju.yoo@mail.utoronto.ca, morgaine.westin@mail.utoronto.ca, najma.osman@mail.utoronto.ca, and rachit.srivastava@mail.utoronto.ca 
# Date: 9 February 2021
# Pre-requisites: Run 00-import_business_licences.R


#### Workspace set-up ####
library(tidyverse)
library(ggplot2)
library(kableExtra)
library(janitor)

#### Global Functions ####
percent <- function(x, decimal = 2, format = "f") {   
  paste0(formatC(x, format = format, digits = decimal), "%")
}

dfBiz <- readr::read_csv("inputs/data/raw_business_licences.csv")

### Boroughs of Toronto ####
# Toronto - 103 FSAs
# https://en.wikipedia.org/wiki/List_of_postal_codes_of_Canada:_M
# https://www.canadapost.ca/cpo/mc/assets/pdf/business/nps/machineable_presort_fsalist_february2014.pdf

### Central Toronto
borCentTor <- c("M4N", "M5N", "M4P", "M5P", "M4R", "M5R", "M4S", "M4T", "M4V")
### Downtown Toronto
borDownTor <- c("M5A", "M7A", "M5B", "M5C", "M5E", "M5G", "M6G", "M5H", "M5J", "M5K", "M5L", "M5S", "M5T", "M5V", "M4W", "M5W", "M4X", "M5X", "M4Y")
### East Toronto
borEastTor <- c("M4E", "M4K", "M4L", "M4M", "M7Y")
### East York
borEastYork <- c("M4B", "M4C", "M4G", "M4H", "M4J")
### Etobicoke
borEtob <- c("M9A", "M9B", "M9C", "M9P", "M9R", "M8V", "M9V", "M8W", "M9W", "M8X", "M8Y", "M8Z")
### North York
borNorYork <- c("M3A", "M4A", "M6A", "M3B", "M6B", "M3C", "M2H", "M3H", "M2J", "M3J", "M2K", "M3K", "M2L", "M3L", "M6L", "M9L", "M2M", "M3M", "M5M", "M9M", "M2N", "M3N", "M2P", "M2R" )
### Scarborough
borScarb <- c("M1B", "M1C", "M1E", "M1G", "M1H", "M1J", "M1K", "M1L", "M1M", "M1N", "M1P", "M1R", "M1S", "M1T", "M1V", "M1W", "M1X")
### West Toronto
borWestTor <- c("M6H", "M6J", "M6K", "M6P", "M6R", "M6S")
### York
borYork <- c("M6C", "M6E", "M6M", "M6N", "M9N")
### All
borAll <- c(borCentTor, borDownTor, borEastTor, borEastYork, borEtob, borNorYork, borScarb, borWestTor, borYork)

dfBiz <-
  dfBiz %>%
  janitor::clean_names() %>%
  select('licence_no',
         'category',
         'licence_address_line_3',
         'conditions',
         'cancel_date') %>%
  filter(category == "EATING ESTABLISHMENT") %>%
  
  # ### Remove empty rows
  # mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>%
  # na.omit() %>%

  ### Remove rows including 'Cancel Date'
  filter(!grepl('-', cancel_date)) %>%

  ### Remove rows including 'NO SEATING' or 'TAKE OUT'
  filter(!grepl('NO SEATING', conditions)) %>%
  filter(!grepl('TAKE OUT', conditions)) %>%

  ### Rename 'licence_address_line_3' fsa
  rename(fsa = 'licence_address_line_3') %>%
  mutate(fsa = substr(fsa, 1, 3)) %>%

  ### Group FSAs by borough
  mutate(fsa = ifelse(!fsa %in% borAll,"NA", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borCentTor,"Central Toronto", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borDownTor,"Downtown Toronto", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borEastTor,"East Toronto", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borEastYork,"East York", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borEtob,"Etobicoke", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borNorYork,"North York", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borScarb,"Scarborough", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borWestTor,"West Toronto", fsa)) %>%
  mutate(fsa = ifelse(fsa %in% borYork,"York", fsa)) %>%

  ### Count number of rows by borough group
  count(fsa)

# ### Get percentages for 'Conditions'
# count(conditions) %>%
# mutate(totalNumb = sum(n)) %>%
# group_by(conditions, add = TRUE) %>%
# mutate(percentage = paste0(round(100 * n / totalNumb, 2), '%'))

print(dfBiz)

#### Save data ### 
write_csv(dfBiz, "inputs/data/clean_business_licences.csv")




