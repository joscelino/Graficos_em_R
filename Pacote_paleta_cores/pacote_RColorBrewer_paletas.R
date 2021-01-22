library(RColorBrewer)

# Visualizando as paletas
RColorBrewer::display.brewer.all()

# Visualizar uma paleta
RColorBrewer::display.brewer.pal(n = 9, name = "GnBu")

# Sintaxe de uso
RColorBrewer::brewer.pal(n = 9, name = "RdBu")

# Exemplos simples
# Boxplot
boxplot(trees, col = RColorBrewer::brewer.pal(n = 9, name = "RdBu"))

# Barras
spray <- stats::aggregate( . ~ spray, data = InsectSprays, sum)
spray 

barplot(spray$count, col = RColorBrewer::brewer.pal(n = 9, name = "RdBu"),
        xlab = "Spray", ylab = "Total", names.arg = spray$spray)

