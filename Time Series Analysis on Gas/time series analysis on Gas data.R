library(tsibbledata)
library(tsibble)
library(ggplot2)
library(dplyr)
library(fable)
library(fpp3)

gas <- tail(aus_production, 5*4) %>% select(Gas)
#plot time series
autoplot(gas)

# data
gas %>%
  model(
    classical_decomposition(Gas, type = "multiplicative")
  ) %>%
  components()

# plot
gas %>%
  model(
    classical_decomposition(Gas, type = "multiplicative")
  ) %>%
  components() %>%
  autoplot() +
  labs(title = "Classical multiplicative decomposition of total
                  Gas")
# seasonally adjustment
model1 <- gas %>%
  model(
    classical_decomposition(Gas, type = "multiplicative")
  ) %>%
  components()


gas_adjusted <- gas
# This is the adjusted seasonal data
gas_adjusted['Gas'] <- model1$Gas/model1$seasonal
gas_adjusted
# This is the adjusted seasonal plot
autoplot(gas_adjusted)

gas_outlier <- gas
# add 300 to the first data point to make it as outlier
gas_outlier$Gas[1]<- gas$Gas[1]+300

model2 <- 
  gas_outlier %>%
  model(
    classical_decomposition(Gas, type = "multiplicative")
  ) %>%
  components()

gas_outlier['Gas'] <- model2$Gas/model2$seasonal
gas_outlier
# This is the adjusted seasonal plot
autoplot(gas_outlier)

# outlier in the end
gas_outlier <- gas
# add 300 to the first data point to make it as outlier
gas_outlier$Gas[1]<- gas$Gas[1]+300

model2 <- 
  gas_outlier %>%
  model(
    classical_decomposition(Gas, type = "multiplicative")
  ) %>%
  components()

gas_outlier['Gas'] <- model2$Gas/model2$seasonal
gas_outlier
# This is the adjusted seasonal plot
autoplot(gas_outlier)

# outlier in the middle
gas_outlier <- gas
# add 300 to the first data point to make it as outlier
gas_outlier$Gas[10]<- gas$Gas[10]+300

model2 <- 
  gas_outlier %>%
  model(
    classical_decomposition(Gas, type = "multiplicative")
  ) %>%
  components()

gas_outlier['Gas'] <- model2$Gas/model2$seasonal
gas_outlier
# This is the adjusted seasonal plot
autoplot(gas_outlier)






