library(RColorBrewer)

utils::fix(USArrests)
base::class(USArrests)
usaarrests <- base::as.matrix(USArrests)

# Heatmap padrao com dendograma
stats::heatmap(usaarrests)

# Heatmap padrao sem dendograma
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column")

# Paletas nativas do R
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = grDevices::cm.colors(128))
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = grDevices::terrain.colors(128))
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
              col = grDevices::rainbow(128))

# Paletas RCOlorBrewer
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 12, name = "Set3"))

stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 12, name = "Paired"))

stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 9, name = "Spectral"))

# Paletas com nocao de grandeza
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"))

stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 9, name = "Greys"))

# Paletas com nocao de grandeza com ajuste de valores
stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
               margins = c(8,4))

stats::heatmap(usaarrests, Colv = NA, Rowv = NA, scale = "column",
               col = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
               margins = c(10,4),
               labCol = c("Assassinato", "Assalto", "Pop. Urbana",
                          "Estupro"))
