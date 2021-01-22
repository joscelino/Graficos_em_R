library(plotly)
library(quantmod)

invisible(getSymbols("PETR4.SA",src='yahoo'))

df <- data.frame(Date=index(PETR4.SA),coredata(PETR4.SA))
df <- tail(df, 30)
df$ID <- seq.int(nrow(df))

accumulate_by <- function(dat, var) {
  var <- lazyeval::f_eval(var, dat)
  lvls <- plotly:::getLevels(var)
  dats <- lapply(seq_along(lvls), function(x) {
    cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])
  })
  dplyr::bind_rows(dats)
}

df <- df %>%
  accumulate_by(~ID)

p <- ggplot(df,aes(ID, PETR4.SA.Close, frame = frame)) +
  geom_line()

fig <- ggplotly(p) %>%
  layout(
    title = "PETR4: Ultimos 30 dias",
    yaxis = list(
      title = "Fechamento",
      zeroline = F,
      tickprefix = "$"
    ),
    xaxis = list(
      title = "Day",
      zeroline = F, 
      showgrid = F
    )
  ) %>% 
  animation_opts(
    frame = 100, 
    transition = 0, 
    redraw = FALSE
  ) %>%
  animation_slider(
    currentvalue = list(
      prefix = "Day "
    )
  )

fig