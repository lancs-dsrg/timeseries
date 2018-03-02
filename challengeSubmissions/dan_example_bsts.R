# Using the bsts package - example script

# Dependencies

library(forecast)
library(bsts)

# Data exploration

load("~/DSRG.RData")

plot(DSRG,type="l")

# The data looks to have two seasonal components, plus holiday periods around Easter and Christmas.

which(DSRG < 5000)
# 7th March 2016 is some sort of outlier - treat as holiday?

# Define structural components

ss <- AddLocalLinearTrend(list(),DSRG)
ss <- AddSeasonal(ss, DSRG, nseasons = 7)
ss <- AddFixedDateHoliday(ss,holiday.name = "xmas",y = DSRG, month = "Dec", day = 25,days.before = 1,
                          days.after = 1,time0 = as.POSIXct(names(DSRG[1])))
ss <- AddFixedDateHoliday(ss,holiday.name = "NY",y = DSRG, month = "Jan", day = 1,days.before = 0,
                          days.after = 0,time0 = as.POSIXct(names(DSRG[1])))
ss <- AddNamedHolidays(ss, named.holidays = c("EasterSunday"),y = DSRG, time0 = as.POSIXct(names(DSRG[1])),days.before = 0, days.after = 0)

# Fit a model using the bsts function

model1 <- bsts(DSRG,state.specification = ss, niter = 1000)

plot(model1)
plot(model1, "components")

# Prediction

pred1 <- predict(model1, horizon = 100)
plot(pred1, plot.original = 200)