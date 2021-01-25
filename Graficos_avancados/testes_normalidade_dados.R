library(semTools)

# Gerando dados nao normais
z <- mvrnonnorm(1000, c(1, 2), matrix(c(10, 2, 2, 5), 2, 2),
                skewness = c(5, 2), kurtosis = c(3, 3))

# dados normais
x <- stats::rnorm(1000)

graphics::par(mfrow = c(2,2))
graphics::hist(z)
stats::qqnorm(z)
stats::qqline(z)
graphics::hist(x)
stats::qqnorm(x)
stats::qqline(x)
graphics::par(mfrow = c(1,1))

