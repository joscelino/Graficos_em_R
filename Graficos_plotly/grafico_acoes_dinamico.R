# https://plotly.com/r/range-slider/

library(plotly)
library(quantmod)

# Download some data
getSymbols(Symbols = c("AAPL", "MSFT"), from = '2018-01-01', to = '2020-07-01')

## [1] "AAPL" "MSFT"

ds <- data.frame(Date = index(AAPL), AAPL[,6], MSFT[,6])

fig <- plot_ly(ds, x = ~Date)
fig <- fig %>% add_lines(y = ~AAPL.Adjusted, name = "Apple")
fig <- fig %>% add_lines(y = ~MSFT.Adjusted, name = "Microsoft")
fig <- fig %>% layout(
  title = "Stock Prices",
  xaxis = list(
    rangeselector = list(
      buttons = list(
        list(
          count = 3,
          label = "3 mo",
          step = "month",
          stepmode = "backward"),
        list(
          count = 6,
          label = "6 mo",
          step = "month",
          stepmode = "backward"),
        list(
          count = 1,
          label = "1 yr",
          step = "year",
          stepmode = "backward"),
        list(
          count = 1,
          label = "YTD",
          step = "year",
          stepmode = "todate"),
        list(step = "all"))),
    
    rangeslider = list(type = "date")),
  
  yaxis = list(title = "Price"))

fig