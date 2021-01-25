library(corrgram)
library(RColorBrewer)

utils::fix(USArrests)
stats::cor(USArrests)

# Padrao
corrgram::corrgram(USArrests, order = TRUE, lower.panel = panel.shade,
                   upper.panel = panel.pie, text.panel = panel.txt,
                   main = "Prisoes nos USA")

# Inverte
corrgram::corrgram(USArrests, order = TRUE, lower.panel = panel.pie,
                   upper.shade = panel.shade, text.panel = panel.txt,
                   main = "Prisoes nos USA")

# Sem painel superior
corrgram::corrgram(USArrests, order = TRUE, lower.panel = panel.shade,
                   upper.panel = NULL, text.panel = panel.txt,
                   main = "Prisoes nos USA")

# Confidence ellipse and smoothed line
corrgram::corrgram(USArrests, order = TRUE, lower.panel = panel.ellipse,
                   upper.panel = NULL, text.panel = panel.txt,
                   main = "Prisoes nos USA")

# Grafico de dispersao
corrgram::corrgram(USArrests, order = TRUE, lower.panel = panel.pts,
                   upper.panel = NULL, text.panel = panel.txt,
                   main = "Prisoes nos USA")

# Sem painel superior usando paleta de cores (n sempre igual a numero de variaveis)
corrgram::corrgram(USArrests, order = TRUE, lower.panel = panel.shade,
                   upper.panel = NULL, text.panel = panel.txt,
                   main = "Prisoes nos USA",
                   col.regions = grDevices::colorRampPalette(
                     RColorBrewer::brewer.pal(n = 4, name = "YlOrRd")
                   ))
