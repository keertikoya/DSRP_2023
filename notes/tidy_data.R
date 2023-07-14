install.packages("janitor")
install.packages("tidyr")

library(janitor)
library(tidyr)
library(dplyr)

starwars
clean_names(starwars, case = "small_camel")
clean_names(starwars, case = "screaming_snake")
new_starwars <- clean_names(starwars, case = "upper_lower")

clean_names(new_starwars)

# df of all women with name and species by birth year
StarWarsWomen <- filter(starwars, sex == "female")
StarWarsWomen <- arrange(StarWarsWomen, birth_year)
StarWarsWomen <- select(StarWarsWomen, name, species)
StarWarsWomen

OtherWay <- select(arrange(filter(starwars, sex == "female"), birth_year), name, species)
OtherWay

OtherOtherWay <- starwars |>
  filter(sex == "female") |>
  arrange(birth_year) |>
  select(name, species)
OtherOtherWay

# 10 tallest chars
slice_max(starwars, height, n=10)
  
## pivot longer ####
# (make table longer and more organized) 
table4a

pivot_longer(table4a,
             cols = c(`1999`, `2000`),
             names_to = "year",
             values_to = "cases")


table4b #shows population data
# pivot tableb into tidy format 

pivot_longer(table4b,
             cols = c(`1999`, `2000`),
             names_to = "year",
             values_to = "population")
  
  
  
## pivot wider ####
table2

pivot_wider(table2,
            names_from = type,
            values_from = count)

## separate ####
table3
separate(table3,
         rate,
         into = c("cases","population"),
         sep = "/")


## unite ####
table5
unite(table5, 
      "year",
      c("century", "year"),
      sep = "")

tidy_table5 <- 
  unite(table5, 
        "year",
        c("century", "year"),
        sep = "") |>
  separate(rate,
           into = c("cases","population"),
           sep = "/")
tidy_table5


## bind rows ####
new_data <- data.frame(country = "USA", year = "1999", cases = "1042", population = "200000")
bind_rows(tidy_table5, new_data)

  
  