ds2 <- data.frame(cbind(d, sh))
dslm2 <- lm(d~sh, data = ds2)
p3 <- (dslm2$coefficients["sh"] * a3) + dslm2$coefficients[1]
if(p3>1){p3 <- (p3/1000)}
p3


c3 <- read.csv("final.csv", na.strings = "", header = T)
c4 <- c3[, 2:3]
