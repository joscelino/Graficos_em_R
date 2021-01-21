require(Hmisc)

# Primeira forma de criar vetor
idade <- c(rep(10, 4), rep(30, 8), rep(50, 4), rep(70, 3), 90)

frequencia_simples <- table(idade)

# Data frame
df <- data.frame(frequencia_simples)

# Frequencia acumulada
frequencia_acumulada <- cumsum(frequencia_simples)

# Adicionando coluna com acumulada
df$frequencia_acumulada <- frequencia_acumulada

# Frequencia relativa simples
frequencia_relativa_simples <- frequencia_simples/sum(frequencia_simples)

# Adicionando frequencia relativa simples
df$frequencia_relativa_simples <- frequencia_relativa_simples

# Frequencia relativa acumulada
frequencia_relativa_acumulada <- cumsum(frequencia_relativa_simples)

# Adicionando frequencia relativa acumulada
df$frequencia_relativa_acumulada <- frequencia_relativa_acumulada

# Achando automaticamente as frequencias simples e acumuladas
describe(idade)

