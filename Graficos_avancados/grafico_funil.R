# https://plotly.com/r/funnel-charts/
library(plotly)

fig <- plot_ly(
  type = "funnel",
  name = 'Montreal',
  y = c("Website visit", "Downloads", "Potential customers", "Requested price"),
  x = c(120, 60, 30, 20),
  textinfo = "value+percent initial") 
fig <- fig %>%
  add_trace(
    type = "funnel",
    name = 'Toronto',
    orientation = "h",
    y = c("Website visit", "Downloads", "Potential customers", "Requested price", "invoice sent"),
    x = c(100, 60, 40, 30, 20),
    textposition = "inside",
    textinfo = "value+percent previous") 
fig <- fig %>%
  add_trace(
    type = "funnel",
    name = 'Vancouver',
    orientation = "h",
    y = c("Website visit", "Downloads", "Potential customers", "Requested price", "invoice sent", "Finalized"),
    x = c(90, 70, 50, 30, 10, 5),
    textposition = "outside",
    textinfo = "value+percent total") 
fig <- fig %>%
  layout(yaxis = list(categoryarray = c("Website visit", "Downloads", "Potential customers", "Requested price", "invoice sent", "Finalized")))

fig