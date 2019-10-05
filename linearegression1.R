#Linear Regression
ds <- data.frame(cbind(uniq, pop))  
dslm <- lm(uniq~pop, data=ds)
p1 <- (dslm$coefficients["pop"] * uw) + dslm$coefficients[1]
if(p1>1){p1 <- (p1/100)} 
p1

ds1 <- data.frame(cbind(m, sh))
dslm1 <- lm(m~sh, data = ds1)
p2 <- (dslm1$coefficients["sh"] * a2) + dslm1$coefficients[1]
p2
