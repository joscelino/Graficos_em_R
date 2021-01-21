#https://plotly.com/r/radar-chart/
library(plotly)

fig <- plot_ly(
  type = 'scatterpolar',
  fill = 'toself'
) 
fig <- fig %>%
  add_trace(
    r = c(39, 28, 8, 7, 28, 39),
    theta = c('A','B','C', 'D', 'E', 'A'),
    name = 'Group A'
  ) 
fig <- fig %>%
  add_trace(
    r = c(1.5, 10, 39, 31, 15, 1.5),
    theta = c('A','B','C', 'D', 'E', 'A'),
    name = 'Group B'
  ) 
fig <- fig %>%
  layout(
    polar = list(
      radialaxis = list(
        visible = T,
        range = c(0,50)
      )
    )
  )

fig