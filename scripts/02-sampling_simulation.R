#### Preamble ####
# Purpose: Create simulated sample
# Authors: Bongju, Morgaine, Najma, and Rachit 
# Contacts: bongju.yoo@mail.utoronto.ca, morgaine.westin@mail.utoronto.ca, najma.osman@mail.utoronto.ca, and rachit.srivastava@mail.utoronto.ca 
# Date: 9 February 2021
# Pre-requisites: Run 01-data_cleaning_business_licences.R


#### Workspace set-up ####
library(tidyverse)

#### Sampling Simulation ####

set.seed(853)

### Questions
# Q1: What region is your restaurant located in?
# Q2: What best describes the scale of your restaurant?
# Q3: What best describes your restaurant segmentation?
# Q4: How many years has your restaurant been in operation?
# Q5: Prior to (intervention start date), how many people did you employ?
# Q6: How many people do you currently employ?
# Q7: Between (start date of intervention) and (end date of intervention) was your total sales revenue higher, lower, or about the same as it was during the same length of time last quarter.
# Q8: What was the approximate percentage decrease in total sales revenue between (start date of intervention) and (end date of intervention) compared to the same time period last year.
# Q9: Before the (intervention start date), approximately how much of your total monthly sales revenue came from takeout or delivery?
# Q10: Between (start date of intervention) and (end date of intervention), did you make any adjustments to your menu prices?
# Q11: Between (start date of intervention) and (end date of intervention), which food courier service did you receive the most orders from?
# Q12: Between (start date of intervention) and (end date of intervention) did you reduce your restaurant’s hours of operation?
# Q13: If yes, approximately how many hours per week did you reduce by
# Q14: Between (start date of intervention) and (end date of intervention) did you reduce the number of days your restaurant was open to the public?
# Q15: If yes, how many days per week did you reduce by?

sample_size <- 200

simulatingDataset <- function(dataset, group_type, param_q1, param_q2, param_q3, param_q4, param_q5, param_q6, param_q7, param_q8, param_q9, param_q10, param_q11, param_q12, param_q13, param_q14, param_q15, numb_resp) {   
  dataset <- 
    tibble(
      type = rep(group_type, sample_size),
      Q1 = sample(x = c(
        "Downtown Toronto",
        "North York",
        "Scarborough",
        "West Toronto",
        "Etobicoke",
        "York",
        "Central Toronto",
        "East Toronto",
        "East York",
        "Other"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q1
      ),
      Q2 = sample(x = c(
        "Small",
        "Medium",
        "Large"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q2
      ),
      Q3 = sample(x = c(
        "Fast-food/quick service",
        "Casual Dining",
        "Fine Dining",
        "Other"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q3
      ),
      Q4 = sample(x = c(
        "1-4 years",
        "5-7 years",
        "8-10 years",
        "10 or more years"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q4
      ),
      Q5 = rpois(n = sample_size, lambda = param_q5),
      Q6 = rpois(n = sample_size, lambda = param_q6),
      Q7 = sample(x = c(
        "Higher",
        "Lower",
        "Around the Same"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q7
      ),
      Q8 = sample(x = c(
        "Decline of 50% or more",
        "Decline of 25% to 50%",
        "Decline of 10% to 25%",
        "Decline of 10% or less"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q8
      ),
      Q9 = sample(x = c(
        "Did not offer takeout or delivery",
        "25% or less",
        "25-50%",
        "50-75%",
        "75% or more"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q9
      ),
      Q10 = sample(x = c(
        "Yes, prices were raised",
        "Yes, prices were lowered",
        "No changes were made"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q10
      ),
      Q11 = sample(x = c(
        "UberEats",
        "SkiptheDishes",
        "DoorDash",
        "Other",
        "In-house delivery service",
        "None"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q11
      ),
      Q12 = sample(x = c(
        "Yes",
        "No"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q12
      ),
      Q13 = sample(x = c(
        "15% or less",
        "15-30%",
        "30-50%",
        "50-75%",
        "75% or more"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q13
      ),
      Q14 = sample(x = c(
        "Yes",
        "No"),
        size = sample_size,
        replace = TRUE, 
        prob = param_q14
      ),
      Q15 = sample(x = c(
        "1-2 days",
        "3-4 days",
        "5-6 days",
        "7 days",
        NA),
        size = sample_size,
        replace = TRUE, 
        prob = param_q15
      ),
    ) %>%
    # Remove the rows whose answer from Q12 is 'No'
    mutate(Q13 = ifelse(Q12 == "No", NA, Q13)) %>%
    
    # Remove the rows whose answer from Q14 is 'No'
    mutate(Q15 = ifelse(Q14 == "No", NA, Q15))
  
  # Remove non-respondents: -20(-10%, Control), -50(-25%, Intervention)
  responses = dataset[sample(nrow(dataset), numb_resp), ]  
  
  return(responses)
}

### Set parameters for treatment group
simulated_dataset_treated <- simulatingDataset(
  "simulated_dataset_treated",
  group_type = "Treated",
  param_q1 = c(0.28, 0.16, 0.14, 0.11, 0.09, 0.06, 0.06, 0.06, 0.04, 0),
  param_q2 = c(0.15, 0.50, 0.35),
  param_q3 = c(0.45, 0.20, 0.10, 0.25),
  param_q4 = c(0.40, 0.25, 0.20, 0.15),
  param_q5 = 30,
  param_q6 = 20,
  param_q7 = c(0.15, 0.80, 0.05),
  param_q8 = c(0.50, 0.25, 0.15, 0.10),
  param_q9 = c(0.01, 0.02, 0.02, 0.05, 0.90),
  param_q10 = c(0.15, 0.55, 0.30),
  param_q11 = c(0.35, 0.10, 0.25, 0.20, 0.05, 0.05),
  param_q12 = c(0.85, 0.15),
  param_q13 = c(0.15, 0.35, 0.30, 0.15, 0.05),
  param_q14 = c(0.85, 0.15),
  param_q15 = c(0.45, 0.35, 0.10, 0.08, 0.02),
  numb_resp = 150
)

### Set parameters for control group
simulated_dataset_control <- simulatingDataset(
  "simulated_dataset_control",
  group_type = "Control",
  param_q1 = c(0.28, 0.16, 0.14, 0.11, 0.09, 0.06, 0.06, 0.06, 0.04, 0),
  param_q2 = c(0.15, 0.50, 0.35),
  param_q3 = c(0.45, 0.20, 0.10, 0.25),
  param_q4 = c(0.40, 0.25, 0.20, 0.15),
  param_q5 = 30,
  param_q6 = 30,
  param_q7 = c(0.10, 0.10, 0.80),
  param_q8 = c(0.02, 0.05, 0.18, 0.75),
  param_q9 = c(0.05, 0.75, 0.07, 0.05, 0.03),
  param_q10 = c(0.01, 0.01, 0.98),
  param_q11 = c(0.30, 0.10, 0.20, 0.20, 0.15, 0.05),
  param_q12 = c(0.03, 0.97),
  param_q13 = c(0.87, 0.10, 0.03, 0, 0),
  param_q14 = c(0.05, 0.95),
  param_q15 = c(0.04, 0.01, 0, 0, 0.95),
  numb_resp = 180
)

### Combine the two dataset
all_simulated_dataset <- 
  rbind(simulated_dataset_treated, simulated_dataset_control)

### Save and clean-up
write_csv(all_simulated_dataset, 'inputs/data/simulated_data.csv')




