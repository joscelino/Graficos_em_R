
#https://plotly.com/r/3d-isosurface-plots/
library(plotly)

df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/clebsch-cubic.csv')

fig <- plot_ly(
  df,
  type='isosurface',
  x = ~x,
  y = ~y,
  z = ~z,
  value = ~value,
  isomin = -10,
  isomax = 10,
  surface = list(show = TRUE, count = 4, fill = 0.8, pattern = 'odd'),
  caps = list(
    x = list(show = TRUE),
    y = list(show = TRUE),
    z = list(show = TRUE)
  )
) 
fig <- fig %>%
  layout(
    margin=list(t = 0, l = 0, b = 0),
    scene=list(
      camera=list(
        eye=list(
          x = 1.86,
          y = 0.61,
          z = 0.98
        )
      )
    )
  )

fig