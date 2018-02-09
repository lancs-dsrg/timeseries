# Time Series in Data Science
From my perusal of the internet, and DS blogs, it seems that Time Series are sometimes not given the attention they deserve. So, as an avid fan of Time Series and Forecasting, I decided that the first session of our Data Science series, specifically aimed at those completing a PhD in a Statistics or OR discipline, should be about just that. 

In the following, we give a brief rundown of some of the key considerations for building a Time Series model used for Forecasting. It focuses on features of the Time Series, and not necessarily the underlying model used.

Visit https://github.com/jamieleigh/forecastCPS for some R functions which allow easy modelling of some more interesting Time Series features.

## Basics
There are some basic components of a Time Series:
1. Level and Trend
2. Seasonality
3. Noise
4. Outliers

### Level and Trend
A non-zero level, or an increasing or decreasing trend, are easily incorporated into your model. For example, ETS() https://www.rdocumentation.org/packages/forecast/versions/8.1/topics/ets will explicitly capture the level or trend, and if you are fitting an ARIMA model, you can regress on time. At times, however, the level and trend may be harder to capture.


| Feature             | Modelling Technique      |
| ------------------- |:------------------------:|
| Piecewise Mean      | Use dummy step functions |

### Seasonality and Calendar Effects
Often your Time Series will have some sort of seasonality, possibly a weekly pattern or a yearly pattern. In a regression setting, these can be modelled using dummy variables - many models already incorporate seasonality, a SARIMA model for example. 

Sometimes you may not have enough data to capture seasonality well. For example, estimating the yearly seasonality for a time series with only one year of data will be difficult. In this case, consider using a proxy for seasonality, temperature for example. 

There are also some more obscure forms of seasonality you need to look out for
* Calendar effects such as Christmas, Easter and Bank Holidays

These are going to be tricky: Christmas day on a Saturday is probably going to behave very differently to a Christmas day on a Wednesday - and you are not going to have much data anyway for these cases!

| Feature             | Modelling Technique                                                   |
| ------------------- |:---------------------------------------------------------------------:|
| One day disturbance | Use a dummy variable                                                  |
| Disturbance period  | Use an individual dummy varible for each day in the disturbance period|

There are some ways you can identify the start and end of a disturbance period in an automated way, see https://github.com/jamieleigh/forecastCPS.

### Noise
Once you have considered the above, what you are left with is "noise". If it is not white noise, then be sure to model any correlations or revise your original model. 

### Outliers
And pesky outliers! Be careful with these ones. They can be incorporated using a dummy variable, or you could remove them. It really depends what they represent: A data input error? An event?

If you are trying to identify "outliers" by considering how many standard deviations it lies away from the mean, then make sure you check the assumptions you have placed on the distribution of your data. Remember, if your Time Series contains any changes in level or volatility, then this approach may fail. 

## Techniques
I haven't mentioned about what models you may want to use for your Time Series. If you want to investigate further, then here are some things you may like to look up:
* Linear Regression 
* Exponential Smoothing
* ARIMA
* Bayesian structural time series

I would recommend https://otexts.org/fpp/ or https://otexts.org/fpp2/

Remember, **“The whole is greater than the sum of its parts”**, so when you are incorporating the features we have discussed above, fit your model simultaneously! (For example, avoid de-trening your model first and then moving onto modelling some other feature of the data set.) 

## Evaluation and Diagnostics
To evaulate our forecasting model we ideally want a training set and a testing set. So, build your model on "most" of the data, but keep some aside to test how well your model forecasts. 

| In-Sample Evaluation                                           | Out-of-Sample Evaluation                             |
| -------------------------------------------------------------- |:----------------------------------------------------:|
| Information criterion between models                           | Forecast from your model and compare to the truth    |
| Error measures between true and fitted values                  | Does the truth lie within your confidence intervals? |
| Check if you missed anything by checking the errors/residuals  | Compare a small forecast horizon to a larger one     |

Be careful in decided which error metrics you use. For example, don't use MAPE if you are forecasting small values or zeros!

## Challenge
To put some of these considerations into action, I have sent you all a data set, but kept a couple of observations to myself. Go away and build a model and forecast one-step-ahead. Then submit your results to me and I will place you on the leader board. Please commit your code to GitHub so we can all try each others' models! Good luck! 

