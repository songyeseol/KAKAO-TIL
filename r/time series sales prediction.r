install.packages(c('astsa','fpp','tidyverse'))
install.packages('dpylr')

library(astsa)
library(fpp)
library(tidyverse)
library(dplyr)

data("AirPassengers")
View(AirPassengers)

test = aggregate(data$SALES, by=list(DATE=data$DATE), FUN=sum)
length(test$x)
test = test[1:100,]

test_ts <- ts(test$x, frequency = 7, start=1, end = 100)
test_ts_test <- ts(test_ts, start=171)


ap_ts_test <- window(AirPassengers, start=1959)

par(mfrow=c(2,1))
par(mar=c(2, 3, 0, 2), xaxs='i', yaxs='i')

plot(ap_ts, ylab="항공여객 (천명)", type="c", pch =20, xaxt='n', xlab="")
text(ap_ts, col=1:12, labels=1:12, cex=.7)

plot(ap_ts, ylab="항공여객 (천명)", type="o", pch =20, xlab="")


ap_ts_decompM <- decompose(test_ts, type = "multiplicative")
plot(ap_ts_decompM, xlab="")

seasonplot(ap_ts, ylab="항공여객 (천명)", xlab="", 
           main="",
           year.labels=TRUE, year.labels.left=TRUE, col=1:20, pch=19)

monthplot(ap_ts, ylab="항공여객 (천명)", xlab="", xaxt="n", main="")
axis(1, at=1:12, labels=month.abb, cex=0.8)



# 3. 모형선정 ------------------------------------------------------------------------
models <- list (
  mod_arima = auto.arima(test2, ic='aicc', stepwise=FALSE),
  mod_exponential = ets(test2, ic='aicc', restrict=FALSE),
  mod_neural = nnetar(test2, p=7, size=25),
  mod_tbats = tbats(test2, ic='aicc', seasonal.periods=7),
  mod_bats = bats(test2, ic='aicc', seasonal.periods=7),
  mod_stl = stlm(test2, s.window=7, ic='aicc', robust=TRUE, method='ets'),
  mod_sts = StructTS(test2)
)

forecasts <- lapply(models, forecast, 12)
forecasts
forecasts$naive <- naive(test2, 12)

par(mfrow=c(4, 2))
par(mar=c(2, 2, 1.5, 2), xaxs='i', yaxs='i')

for(f in forecasts){
  plot(f, ylim=c(0,600), main="", xaxt="n")
  lines(test2, col='red')
}
acc <- lapply(forecasts, function(f){
  accuracy(f, test2)[2,drop=FALSE]
})

acc <- Reduce(rbind, acc)
row.names(acc) <- names(forecasts)
acc <- acc[order(acc[,'MASE']),]
round(acc, 2)

# 4. 모형적합 ------------------------------------------------------------------------

ap_tbats_fit <- tbats(test_ts, ic='aicc', seasonal.periods=12)
plot(ap_tbats_fit)

ap_stl_fit <- stl(ap_ts, s.window = 12)

par(mfrow = c(2,2))
monthplot(ap_ts, ylab = "data", cex.axis = 0.8)
monthplot(ap_stl_fit, choice = "seasonal", cex.axis = 0.8)
monthplot(ap_stl_fit, choice = "trend", cex.axis = 0.8)
monthplot(ap_stl_fit, choice = "remainder", type = "h", cex.axis = 0.8)


# 5. 예측 ------------------------------------------------------------------------
# 최적 모형
par(mfrow = c(1,1))
par(mar=c(2, 2, 1.5, 2), xaxs='i', yaxs='i')

ap_tbats_fit_fcast <- forecast(ap_tbats_fit)
plot(ap_tbats_fit_fcast, xaxt="n")

#최저 모형
mod_sts_fit <- StructTS(ap_ts)
ap_sts_fit_fcast <- forecast(mod_sts_fit)
plot(ap_sts_fit_fcast)

#----------------------------------------------------------------------------------


test = aggregate(data$SALES, by=list(DATE=data$DATE), FUN=sum)
test = test[1:100,]

length(test$x)

test2 = ts(test$x, frequency=7)
str(test2)

plot(test2)

plot(stl(test2, s.window = 'periodic'))

library(tseries)

adf.test(diff(log(test2)), alternative='stationary', k=0)


library(forecast)

auto.arima(diff(log(test2)))

tsdiag(auto.arima(diff(log(test2))))

fit = arima(log(test2), c(0,0,1), seasonal=list(order=c(1,1,1), period=7))

pred = predict(fit, n.ahead = 7*10)
ts.plot(test2,2.718^pred$pred, log = "y", lty = c(1,3)) 


2.718^pred$pred

-----------------
  
models <- list (
  mod_arima = auto.arima(test2, ic='aicc', stepwise=FALSE),
  mod_exponential = ets(test2, ic='aicc', restrict=FALSE),
  mod_neural = nnetar(test2, p=7, size=25),
  mod_tbats = tbats(test2, ic='aicc', seasonal.periods=7),
  mod_bats = bats(test2, ic='aicc', seasonal.periods=7),
  mod_stl = stlm(test2, s.window=7, ic='aicc', robust=TRUE, method='ets'),
  mod_sts = StructTS(test2)
)

forecasts <- lapply(models, forecast, 7)
forecasts$naive <- naive(test2, 7)

par(mfrow=c(4, 2))
par(mar=c(2, 2, 1.5, 2), xaxs='i', yaxs='i')

for(f in forecasts){
  plot(f, main="", xaxt="n")
  lines(test2, col='red')
}

acc <- lapply(forecasts, function(f){
  accuracy(f, test2)[2]
})

acc <- Reduce(rbind, acc)
row.names(acc) <- names(forecasts)
acc <- acc[order(acc[,'MASE']),]
round(acc, 2)


-----------------------------------
  
  
library(forecast)
# Read SuperStore data from Github.
SuperstoreSales <- read.csv("https://raw.githubusercontent.com/keberwein/Data_Science_Riot/master/Tableau%20R%20Forecast/SuperstoreSales.csv")
# Date formatting is bad, convert to correct format
test
test$DATE <- as.Date(as.character(test$DATE), format="%m/%d/%y")
# Create time sereis
time <- ts(data=test$x, start=c(2018,1), frequency = 7)
# Forecast
fcast <- forecast(time)

# Or, you can do an Arima Model
time <- ts(data=test$x, start=c(2018,1), frequency = 7)
timeArima <- auto.arima(time)
fcastArima <- forecast.Arima(timeArima)



SuperstoreSales <- read.csv("https://raw.githubusercontent.com/keberwein/Data_Science_Riot/master/Tableau%20R%20Forecast/SuperstoreSales.csv")
# Date formatting is bad, convert to correct format
SuperstoreSales$Order.Date <- as.Date(as.character(SuperstoreSales$Order.Date), format="%m/%d/%y")
time <- ts(data=SuperstoreSales$Sales, start=c(2010, 1), deltat=1/12)
timeArima <- auto.arima(time)
fcastArima <- forecast(timeArima)


# Determine accuracy of fit
accuracy(fcast)

# Plot fitted model
plot(forecast(time))
lines(fitted(fcast),col="blue")

