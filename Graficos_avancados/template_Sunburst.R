library(plotly)
library(readr)

df = read_csv('https://raw.githubusercontent.com/plotly/datasets/718417069ead87650b90472464c7565dc8c2cb1c/coffee-flavors.csv')

fig <- plot_ly()

fig <- fig %>% add_trace(
  type='sunburst',
  ids=df$ids,
  labels=df$labels,
  parents=df$parents,
  domain=list(column=1),
  maxdepth=2,
  insidetextorientation='radial'
)
fig
