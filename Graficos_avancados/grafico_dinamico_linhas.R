library(plotly)
fig1 <- plot_ly(economics, x = ~date, y = ~unemploy)
fig1 <- fig1 %>% add_lines(name = ~"unemploy")
fig2 <- plot_ly(economics, x = ~date, y = ~uempmed)
fig2 <- fig2 %>% add_lines(name = ~"uempmed")
fig <- subplot(fig1, fig2)

fig