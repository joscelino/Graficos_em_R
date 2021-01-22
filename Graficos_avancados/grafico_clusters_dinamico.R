# https://plotly.com/r/custom-buttons/
library(plotly)

x0 <- rnorm(400, mean=2, sd=0.4)
y0 <- rnorm(400, mean=2, sd=0.4)
x1 <- rnorm(400, mean=3, sd=0.6)
y1 <- rnorm(400, mean=6, sd=0.4)
x2 <- rnorm(400, mean=4, sd=0.2)
y2 <- rnorm(400, mean=4, sd=0.4)

# shapes components
cluster0 = list(
  type = 'circle',
  xref ='x', yref='y',
  x0=min(x0), y0=min(y0),
  x1=max(x0), y1=max(y0),
  opacity=0.25,
  line = list(color="#835AF1"),
  fillcolor="#835AF1")

cluster1 = list(
  type = 'circle',
  xref ='x', yref='y',
  x0=min(x1), y0=min(y1),
  x1=max(x1), y1=max(y1),
  opacity=0.25,
  line = list(color="#7FA6EE"),
  fillcolor="#7FA6EE")

cluster2 = list(
  type = 'circle',
  xref ='x', yref='y',
  x0=min(x2), y0=min(y2),
  x1=max(x2), y1=max(y2),
  opacity=0.25,
  line = list(color="#B8F7D4"),
  fillcolor="#B8F7D4")

# updatemenus component
updatemenus <- list(
  list(
    active = -1,
    type = 'buttons',
    buttons = list(
      
      list(
        label = "Nenhum",
        method = "relayout",
        args = list(list(shapes = c()))),
      
      list(
        label = "Grupo 1",
        method = "relayout",
        args = list(list(shapes = list(cluster0, c(), c())))),
      
      list(
        label = "Grupo 2",
        method = "relayout",
        args = list(list(shapes = list(c(), cluster1, c())))),
      
      list(
        label = "Grupo 3",
        method = "relayout",
        args = list(list(shapes = list(c(), c(), cluster2)))),
      
      list(
        label = "Todos",
        method = "relayout",
        args = list(list(shapes = list(cluster0,cluster1,cluster2))))
    )
  )
)

fig <- plot_ly(type = 'scatter', mode='markers') 
fig <- fig %>% add_trace(x=x0, y=y0, mode='markers', marker=list(color='#835AF1')) 
fig <- fig %>% add_trace(x=x1, y=y1, mode='markers', marker=list(color='#7FA6EE')) 
fig <- fig %>% add_trace(x=x2, y=y2, mode='markers', marker=list(color='#B8F7D4')) 
fig <- fig %>% layout(title = "Highlight Clusters", showlegend = FALSE,
                      updatemenus = updatemenus)

fig