library(tidyverse)
library(tidymodels)
library(textrecipes)
library(skimr)
library(ggplot2)

### References
# https://blog.datascienceheroes.com/how-to-use-recipes-package-for-one-hot-encoding/
# https://yards.albert-rapp.de/how-to-build-a-model.html
# https://algoritmaonline.com/tidymodels/

### 0 - load data ###

coffee_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-07/coffee_ratings.csv')
skim(coffee_ratings)


### 1.1 - inspect data ###

glimpse(coffee_ratings)

hist(coffee_ratings$total_cup_points)
summary(coffee_ratings$total_cup_points)
## from this, can see that most of the data points actually fall between 81-84 points - tight range


### 1.2 - basic pre-cleaning ###


coffee_ratings_filtered <- coffee_ratings %>%
  filter(species == "Arabica") %>%  
  ## remove small number of Robusta entries (only interested in Arabica)
  
  group_by(country_of_origin, variety) %>%   
  filter(n() >= 5)
  ## filter out countries/variety combinations with too few data points as the training will not be good
  ## on the other hand, can't set too strict a filter or we lose too many data points overall

coffee_ratings_filtered %>% group_by(country_of_origin, variety) %>% 
  summarise(n())

glimpse(coffee_ratings_filtered)
## lost 183 obs through this filtering, about 15.8% of the total obs

### 2.1 divide into training and test set ###

set.seed(42) #for replicability

coffee_split <- initial_split(coffee_ratings_filtered, 
                              prop = 0.75, #use 75% for training set
                              strata = total_cup_points)

coffee_training <- coffee_split %>% training()
coffee_test <- coffee_split %>% testing()


### 2.2 pre-process the data ###

coffee_recipe <- recipe(total_cup_points ~ country_of_origin + variety + processing_method + altitude_mean_meters + category_one_defects + category_two_defects,
                        data = coffee_training) %>%
  step_normalize(altitude_mean_meters) %>% ## normalise numerical predictors
  step_string2factor(all_nominal_predictors()) %>% ## convert characters to factors
  step_novel(all_nominal_predictors()) %>% ## handles new levels in the test set not seen in the training set
  step_dummy(all_nominal_predictors()) ## encode factors into dummies

coffee_recipe

coffee_training_prep <- coffee_recipe %>%
                      prep(training = coffee_training) %>%
                      bake(new_data = NULL)
                      # prep the training data using the recipe

coffee_training_prep

coffee_test_prep <- coffee_recipe %>%
                    prep(training = coffee_training) %>%
                    bake(new_data = coffee_test)
                    # prep the test data using the recipe

coffee_test_prep

### 2.3 run the model on the training set ###

lm_model <- linear_reg() %>%
            set_engine('lm') %>%
            set_mode('regression') #define the model. here i use linear regression

lm_fit <- lm_model %>%
          fit(total_cup_points ~ .,
              data = coffee_training_prep)

tidy(lm_fit)

### 2.4 apply model predictions to test set ###

coffee_predictions <- lm_fit %>% 
                      predict(new_data = coffee_test_prep)

coffee_predictions

coffee_test_results <- coffee_test %>%
                      bind_cols(coffee_predictions) #combine predicted results with existing data

### 2.5 calculate metrics ###

coffee_test_results %>% 
  group_by(country_of_origin) %>%
  rmse(truth = total_cup_points, estimate = .pred)

coffee_test_results %>% 
  group_by(country_of_origin) %>%
  rsq(truth = total_cup_points, estimate = .pred)

### 2.6 visualise the prediction vs actual ###

# overall plot
coffee_test_results %>%
  filter(!is.na(.pred)) %>%
  ggplot(aes(x = total_cup_points, y = .pred)) +
            geom_point() +
            geom_abline(color = 'blue', linetype = 2) +
            coord_obs_pred() +
            labs(title = "",
                 x = "Total cup points",
                 y = "Predicted cup points") +

            theme_classic()

# facet by country (can use other too...)
coffee_test_results %>%
  filter(!is.na(.pred)) %>%
  ggplot(aes(x = total_cup_points, y = .pred)) +
    geom_point() +
    geom_abline(color = 'blue', linetype = 2) +
    coord_obs_pred() +
    labs(title = "",
         x = "Total cup points",
         y = "Predicted cup points") +
    facet_wrap(~country_of_origin) +
  
    theme_classic()
  