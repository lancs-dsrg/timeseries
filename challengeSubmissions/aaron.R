layout(1:2)
acf(DSRG); pacf(DSRG)

diff7_DSRG <- diff(DSRG, lag=7)
acf(diff7_DSRG); pacf(diff7_DSRG)

tsmod <- arima(ts(DSRG, frequency=7), order=c(2,0,0), seasonal=c(0,1,1))


plot.ts(DSRG)
plot.ts(DSRG)
lines(1:length(DSRG), DSRG-tsmod$residuals, col="blue")

prediction <- predict(tsmod, n.ahead=1)
sprintf("Aaron's prediction is: %.3f", prediction)
