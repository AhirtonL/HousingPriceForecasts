Joseph Sternberg, Dongpeng Xia
Appendix, R Code:

Summaries of Individual Variables:
> summary(`Median Sales Price`)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  18500   48850  120000  129100  210600  318200 
> summary(`Household Estimates`)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  55980   74660   94600   91220  106900  119100 
> summary(`Real GDP per Capita`)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  19230   27040   35630   36050   46670   52680
> summary(`Unemployment Rate`)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  3.200   4.850   5.700   6.065   7.100  11.200

Regression of Median Sales Price on Time:
> t<-c(1: length(`Median Sales Price`))
> fit<-lm(`Median Sales Price`~t)
> summary(fit)

Call:
lm(formula = `Median Sales Price` ~ t)
Residuals:
   Min     1Q Median     3Q    Max 
-23365 -13986  -5306  12308  43533 
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -19175.7     2416.8  -7.934 1.19e-13 ***
t             1373.1       19.4  70.770  < 2e-16 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 17660 on 213 degrees of freedom
Multiple R-squared:  0.9592,	Adjusted R-squared:  0.959 
F-statistic:  5008 on 1 and 213 DF,  p-value: < 2.2e-16

> plot.ts(`Median Sales Price`)
> abline(fit)
> plot(`Median Sales Price`, fit$fitted.values, type='l')
> plot.ts(fit$residuals)
> plot.ts(rstudent(fit))
> acf(`Median Sales Price`, 25)
> myacf = acf(`Median Sales Price`)
> myacf
Autocorrelations of series ‘Median Sales Price’, by lag
    1     2     3     4     5     6     7     8     9    10    11    12    13 
0.984 0.968 0.953 0.937 0.921 0.905 0.889 0.872 0.856 0.840 0.824 0.807 0.791 
   14    15    16    17    18    19    20    21    22    23 
0.775 0.760 0.745 0.731 0.716 0.703 0.691 0.678 0.667 0.656 
> myacf=acf(`Median Sales Price`, type="covariance")
> myacf
Autocovariances of series ‘Median Sales Price’, by lag
       0        1        2        3        4        5        6        7 
7.57e+09 7.45e+09 7.33e+09 7.21e+09 7.09e+09 6.97e+09 6.85e+09 6.73e+09 
       8        9       10       11       12       13       14       15 
6.60e+09 6.48e+09 6.36e+09 6.24e+09 6.11e+09 5.99e+09 5.87e+09 5.75e+09 
      16       17       18       19       20       21       22       23 
5.64e+09 5.53e+09 5.42e+09 5.32e+09 5.23e+09 5.14e+09 5.05e+09 4.97e+09 
> pacf(`Median Sales Price`, 25)

Seasonal Models:
> library(TSA)
> mdqrtr<-season(ts(Date, frequency=4))
> mdHousePrice<-ts(`Median Sales Price`, frequency=4)
> mdHouseholdEst<-ts(`Household Estimates`, frequency=4)
> mdGDP<-ts(`Real GDP per Capita`, frequency=4)
> mdUnemploy<-ts(`Unemployment Rate`,frequency=4)

Seasonal Model With Intercept:
> fit1<-lm(mdHousePrice~mdqrtr)
> summary(fit1)

Call:
lm(formula = mdHousePrice ~ mdqrtr)
Residuals:
    Min      1Q  Median      3Q     Max 
-111144  -80901   -9457   82114  188156 
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 128214.8    11952.4  10.727   <2e-16 ***
mdqrtr2Q      1829.6    16903.2   0.108    0.914    
mdqrtr3Q      1242.6    16903.2   0.074    0.941    
mdqrtr4Q       536.1    16982.8   0.032    0.975    
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 87830 on 211 degrees of freedom
Multiple R-squared:  6.374e-05,	Adjusted R-squared:  -0.01415 
F-statistic: 0.004483 on 3 and 211 DF,  p-value: 0.9996

> tapply(mdHousePrice, mdqrtr, summary)
$`1Q`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  18500   47980  119800  128200  203500  313100 
$`2Q`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  18900   50500  120000  130000  211200  318200 
$`3Q`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  18900   50620  120000  129500  208100  315200 
$`4Q`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  19400   51600  121500  128800  198800  310900 

Seasonal Model Without Intercept:
> fit2<-lm(mdHousePrice~mdqrtr-1)
> summary(fit2)

Call:
lm(formula = mdHousePrice ~ mdqrtr - 1)
Residuals:
    Min      1Q  Median      3Q     Max 
-111144  -80901   -9457   82114  188156 
Coefficients:
         Estimate Std. Error t value Pr(>|t|)    
mdqrtr1Q   128215      11952   10.73   <2e-16 ***
mdqrtr2Q   130044      11952   10.88   <2e-16 ***
mdqrtr3Q   129457      11952   10.83   <2e-16 ***
mdqrtr4Q   128751      12065   10.67   <2e-16 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 87830 on 211 degrees of freedom
Multiple R-squared:  0.6877,	Adjusted R-squared:  0.6818 
F-statistic: 116.2 on 4 and 211 DF,  p-value: < 2.2e-16

Harmonic Model:
> har=harmonic(mdHousePrice,1)
> fit4=lm(mdHousePrice~har)
> summary(fit4)

Call:
lm(formula = mdHousePrice ~ har)
Residuals:
    Min      1Q  Median      3Q     Max 
-110865  -80901   -9737   81834  188435 
Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)    129115.6     5976.1  21.605   <2e-16 ***
harcos(2*pi*t)   -621.3     8431.7  -0.074    0.941    
harsin(2*pi*t)    649.4     8471.2   0.077    0.939    
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 87620 on 212 degrees of freedom
Multiple R-squared:  5.333e-05,	Adjusted R-squared:  -0.00938 
F-statistic: 0.005653 on 2 and 212 DF,  p-value: 0.9944

> plot(ts(fitted(fit4),freq=4),ylab='Median Home Price',type='l', ylim=range(c(fitted(fit4),mdHousePrice)))
> points(mdHousePrice)

Model (Polynomial of Time):
> t=c(1:length(`Median Sales Price`))
> tc=t-mean(t)
> fit.p1=lm(`Median Sales Price`~tc)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p1), col='red')
> plot.ts(rstudent(fit.p1))
> t2=tc^2
> fit.p2=lm(`Median Sales Price`~tc+t2)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p2), col='red')
> plot.ts(rstudent(fit.p2))
> t3=tc^3
> fit.p3=lm(`Median Sales Price`~tc+t2+t3)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p3), col='red')
> plot.ts(rstudent(fit.p3))
> t4=tc^4
> fit.p4=lm(`Median Sales Price`~tc+t2+t3+t4)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p4), col='red')
> plot.ts(rstudent(fit.p4))
> t5=tc^5
> fit.p5=lm(`Median Sales Price`~tc+t2+t3+t4+t5)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p5), col='red')
> plot.ts(rstudent(fit.p5))
> t6=tc^6
> fit.p6=lm(`Median Sales Price`~tc+t2+t3+t4+t5+t6)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p6), col='red')
> plot.ts(rstudent(fit.p6))
> t7=tc^7
> fit.p7=lm(`Median Sales Price`~tc+t2+t3+t4+t5+t6+t7)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p7), col='red')
> plot.ts(rstudent(fit.p7))
> t8=tc^8
> fit.p8=lm(`Median Sales Price`~tc+t2+t3+t4+t5+t6+t7+t8)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p8), col='red')
> plot.ts(rstudent(fit.p8))
> t9=tc^9
> fit.p9=lm(`Median Sales Price`~tc+t2+t3+t4+t5+t6+t7+t8+t9)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p9), col='red')
> plot.ts(rstudent(fit.p9))
> t10=tc^10
> fit.p10=lm(`Median Sales Price`~tc+t2+t3+t4+t5+t6+t7+t8+t9+t10)
> plot.ts(`Median Sales Price`)
> lines(fitted(fit.p10), col='red')
> plot.ts(rstudent(fit.p10))
> AIC(fit.p1)
[1] 4819.051
> AIC(fit.p2)
[1] 4623.237
> AIC(fit.p3)
[1] 4624.662
> AIC(fit.p4)
[1] 4616.043
> AIC(fit.p5)
[1] 4617.563
> AIC(fit.p6)
[1] 4604.735
> AIC(fit.p7)
[1] 4568.42
> AIC(fit.p8)
[1] 4570.291
> AIC(fit.p9)
[1] 4537.316
> AIC(fit.p10)
[1] 4440.23

Regression of Median Sales Price on Economic Indicators:
> pairs(~`Median Sales Price`+`Household Estimates`+`Real GDP per Capita`+`Unemployment Rate`)

Regression 1, Median Sales Price vs Individual Economic Indicators:
> fit2<-lm(mdHousePrice~mdHouseholdEst)
> fit3<-lm(mdHousePrice~mdGDP)
> fit4<-lm(mdHousePrice~mdUnemploy)
> plot(`Household Estimates`, `Median Sales Price`)
> abline(fit2)
> plot(`Real GDP per Capita`, `Median Sales Price`)
> abline(fit3)
> plot(`Unemployment Rate`, `Median Sales Price`)
> abline(fit4)

Median Sales Price vs Household Estimates:
> summary(fit2)

Call:
lm(formula = mdHousePrice ~ mdHouseholdEst)
Residuals:
   Min     1Q Median     3Q    Max 
-36550 -26022  -5968  23384  67961 
Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)    -2.700e+05  9.315e+03  -28.98   <2e-16 ***
mdHouseholdEst  4.375e+00  1.000e-01   43.75   <2e-16 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 27660 on 213 degrees of freedom
Multiple R-squared:  0.8999,	Adjusted R-squared:  0.8994 
F-statistic:  1914 on 1 and 213 DF,  p-value: < 2.2e-16

Median Sales Price vs GDP Per Capita:
> summary(fit3)

Call:
lm(formula = mdHousePrice ~ mdGDP)
Residuals:
   Min     1Q Median     3Q    Max 
-38581  -8461  -2588   5444  51358 
Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -1.753e+05  4.283e+03  -40.93   <2e-16 ***
mdGDP        8.445e+00  1.144e-01   73.82   <2e-16 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 16960 on 213 degrees of freedom
Multiple R-squared:  0.9624,	Adjusted R-squared:  0.9622 
F-statistic:  5450 on 1 and 213 DF,  p-value: < 2.2e-16

Median Sales Price vs Unemployment Rate:
> summary(fit4)

Call:
lm(formula = mdHousePrice ~ mdUnemploy)
Residuals:
    Min      1Q  Median      3Q     Max 
-110962  -82261  -10477   74275  193813 
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   113729      22656   5.020 1.09e-06 ***
mdUnemploy      2538       3604   0.704    0.482    
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 87320 on 213 degrees of freedom
Multiple R-squared:  0.002322,	Adjusted R-squared:  -0.002362 
F-statistic: 0.4956 on 1 and 213 DF,  p-value: 0.4822

Regression 3, Median Sales Price vs GDP, Household Estimates, and Unemployment:
> fit.all<-lm(mdHousePrice~mdGDP+mdHouseholdEst+mdUnemploy)
> summary(fit.all)

Call:
lm(formula = mdHousePrice ~ mdGDP + mdHouseholdEst + mdUnemploy)
Residuals:
   Min     1Q Median     3Q    Max 
-36512  -8651  -1438   6189  51824 
Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)    -1.366e+05  8.238e+03 -16.585  < 2e-16 ***
mdGDP           1.226e+01  6.324e-01  19.379  < 2e-16 ***
mdHouseholdEst -2.095e+00  3.429e-01  -6.110 4.73e-09 ***
mdUnemploy      2.477e+03  7.798e+02   3.176  0.00171 ** 
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 15700 on 211 degrees of freedom
Multiple R-squared:  0.968,	Adjusted R-squared:  0.9676 
F-statistic:  2131 on 3 and 211 DF,  p-value: < 2.2e-16

Regression 4, Median Sales Price vs GDP and Household Estimates: 
> fit.all<-lm(mdHousePrice~mdGDP+mdHouseholdEst)
> summary(fit.all)

Call:
lm(formula = mdHousePrice ~ mdGDP + mdHouseholdEst)
Residuals:
   Min     1Q Median     3Q    Max 
-41054  -8068  -1116   4796  48156 
Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)    -1.376e+05  8.406e+03 -16.372  < 2e-16 ***
mdGDP           1.117e+01  5.439e-01  20.543  < 2e-16 ***
mdHouseholdEst -1.491e+00  2.914e-01  -5.118 6.92e-07 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 16030 on 212 degrees of freedom
Multiple R-squared:  0.9665,	Adjusted R-squared:  0.9662 
F-statistic:  3060 on 2 and 212 DF,  p-value: < 2.2e-16

> plot.ts(rstudent(fit.all))
> acf(rstudent(fit.all))
> hist(rstudent(fit.all))

Durbin-Watson Test 1:
> fit7<-lm(mdHousePrice~mdGDP+mdHouseholdEst+mdUnemploy)
> dwtest(fit7)
	Durbin-Watson test
data:  fit7
DW = 0.1117, p-value < 2.2e-16
alternative hypothesis: true autocorrelation is greater than 0

Regression 5, Median Sales Price vs Household Estimates and Time:
> fit.all<-lm(mdHousePrice~mdGDP+mdHouseholdEst+mdqrtr)
> summary(fit.all)

Call:
lm(formula = mdHousePrice ~ mdGDP + mdHouseholdEst + mdqrtr)
Residuals:
   Min     1Q Median     3Q    Max 
-41697  -7511  -1445   4905  47508 
Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)    -1.371e+05  8.649e+03 -15.851  < 2e-16 ***
mdGDP           1.117e+01  5.473e-01  20.410  < 2e-16 ***
mdHouseholdEst -1.490e+00  2.933e-01  -5.081 8.31e-07 ***
mdqrtr2Q        4.904e+01  3.105e+03   0.016    0.987    
mdqrtr3Q       -1.736e+03  3.105e+03  -0.559    0.577    
mdqrtr4Q       -6.738e+02  3.120e+03  -0.216    0.829    
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 16130 on 209 degrees of freedom
Multiple R-squared:  0.9666,	Adjusted R-squared:  0.9658 
F-statistic:  1209 on 5 and 209 DF,  p-value: < 2.2e-16

Smoothing (Moving Average, Kernel, Nearest Neighbor, Lowess, Smoothing Splines):

Moving Average Smoother:
> plot(`Median Sales Price`, type="p", ylab="Median Sales Price")
> lines( filter(`Median Sales Price`, sides=2, rep(1,3)/3), col='red')
> lines(filter(`Median Sales Price`, sides=2, rep(1,43)/43), col='blue')

Kernel Smoother:
> plot(`Median Sales Price`, type="p", ylab="Median Sales Price")
> lines(ksmooth(time(`Median Sales Price`), `Median Sales Price`, "normal", bandwidth=5/12), col='red')
> lines(ksmooth(time(`Median Sales Price`), `Median Sales Price`, "normal", bandwidth=20), col='blue')

Nearest Neighbor Smoother:
> plot(`Median Sales Price`, type="p", ylab="Median Sales Price")
> lines(supsmu(time(`Median Sales Price`), `Median Sales Price`, span=.4), col='red')
> lines(supsmu(time(`Median Sales Price`), `Median Sales Price`, span=.01), col='blue')

Lowess Smoother:
> plot(`Median Sales Price`, type="p", ylab="Median Sales Price")
> lines(lowess(`Median Sales Price`, f=.3), col='red')
> lines(lowess(`Median Sales Price`, f=.01), col='blue')

Smoothing Splines Regression:
> plot(`Median Sales Price`, type="p", ylab="Median Sales Price")
> lines(smooth.spline(time(`Median Sales Price`), `Median Sales Price`, spar=.85), col='red')
> lines(smooth.spline(time(`Median Sales Price`), `Median Sales Price`, spar=.1), col='blue')

Decomposition:
> mdHousePrice.decomp<-decompose(mdHousePrice)
> plot(mdHousePrice.decomp)
> mdHousePrice.dm<-decompose(mdHousePrice, type = "multiplicative")
> plot(mdHousePrice.dm)
Additive Deseasonalized:
> plot(mdHousePrice.decomp$trend+mdHousePrice.decomp$random)
Multiplicative Deseasonalized:
> plot(mdHousePrice/mdHousePrice.dm$seasonal, main="Deseasonalized Series")
Additive Detrended:
> plot(mdHousePrice.decomp$seasonal+mdHousePrice.decomp$random)
Multiplicative Detrended:
> plot(mdHousePrice/mdHousePrice.dm$trend, main="Detrended Series")
Additive Denoised:
> plot(mdHousePrice.decomp$trend+mdHousePrice.decomp$seasonal)
Multiplicative Denoised:
> plot(mdHousePrice/mdHousePrice.dm$random, main="Denoised Series")

Holt-Winters Predictions:

Predict last quarter (2017 Q3) with multiplicative seasonal model:
> n<-length(`Median Sales Price`)
> tempHousePrice<-ts(`Median Sales Price`[1:(n-1)], frequency=4)
> u.hwm<-HoltWinters(tempHousePrice, seasonal = "mult")
> u.hwm$SSE
[1] 3644496176
> u.hwmp<-predict(u.hwm, n.ahead=1, prediction.interval = TRUE, level=.95)
> plot(u.hwm, u.hwmp)
> u.hwmp
           fit      upr    lwr
54 Q3 315886.5 320269.1 311504

Predict last two quarters (2017 Q2, Q3) with multiplicative seasonal model:
> tempHousePrice<-ts(`Median Sales Price`[1:(n-2)], frequency=4)
> u.hwm<-HoltWinters(tempHousePrice, seasonal = "mult")
> u.hwm$SSE
[1] 3642654648
> u.hwmp<-predict(u.hwm, n.ahead=2, prediction.interval = TRUE, level=.95)
> plot(u.hwm, u.hwmp)
> u.hwmp
           fit      upr      lwr
54 Q2 316841.2 321229.6 312452.8
54 Q3 314946.3 322105.7 307787.0

Predict last three quarters (2017 Q1, Q2, Q3) with multiplicative seasonal model:
> tempHousePrice<-ts(`Median Sales Price`[1:(n-3)], frequency=4)
> u.hwm<-HoltWinters(tempHousePrice, seasonal = "mult")
> u.hwm$SSE
[1] 3642220203
> u.hwmp<-predict(u.hwm, n.ahead=3, prediction.interval = TRUE, level=.95)
> plot(u.hwm, u.hwmp)
> u.hwmp
           fit      upr      lwr
54 Q1 313768.2 318167.1 309369.3
54 Q2 317306.6 324561.2 310052.1
54 Q3 315534.7 325776.2 305293.2

Predict last four quarters (2016 Q4, 2017 Q1, Q2, Q3) with multiplicative seasonal model:
> tempHousePrice<-ts(`Median Sales Price`[1:(n-4)], frequency=4)
> u.hwm<-HoltWinters(tempHousePrice, seasonal = "mult")
> u.hwm$SSE
[1] 3637418448
> u.hwmp<-predict(u.hwm, n.ahead=4, prediction.interval = TRUE, level=.95)
> plot(u.hwm, u.hwmp)
> u.hwmp
           fit      upr      lwr
53 Q4 308697.7 313093.1 304302.3
54 Q1 312254.0 319519.0 304989.1
54 Q2 315326.8 325729.0 304924.6
54 Q3 313152.2 326050.6 300253.8

Predict next four quarters (2017 Q4, 2018 Q1, Q2, Q3) with multiplicative seasonal model:
> u.hwm<-HoltWinters(mdHousePrice, seasonal = "mult")
> u.hwm$SSE
[1] 3644966412
> u.hwmp<-predict(u.hwm, n.ahead=4, prediction.interval = TRUE, level=.95)
> plot(u.hwm, u.hwmp)
> u.hwmp
           fit      upr      lwr
54 Q4 321303.3 325675.3 316931.2
55 Q1 325171.3 332382.9 317959.8
55 Q2 328822.2 339142.6 318501.7
55 Q3 326811.6 339594.5 314028.8

Cochrane-Orcutt Model 1 (House Price vs GDP, Household, and Unemployment):
> res<-fit7$residuals
> rnum<-0
> rdenom<-0
> for(i in 2:20){
+     rnum<-rnum+res[i]*res[i-1]
+     rdenom<-rdenom+res[i-1]^2
+ }
> rhat<- rnum/rdenom
> yprime<-rep(0,215-1)
> x1prime<-rep(0,215-1)
> x2prime<-rep(0,215-1)
> x3prime<-rep(0,215-1)
> for (i in 1:214){
+ yprime[i]<-mdHousePrice[i+1]-rhat*mdHousePrice[i]
+ x1prime[i]<-mdHouseholdEst[i+1]-rhat*mdHouseholdEst[i]
+ x2prime[i]<-mdUnemploy[i+1]-rhat*mdUnemploy[i]}
> for (i in 1:214){
+ yprime[i]<-mdHousePrice[i+1]-rhat*mdHousePrice[i]
+ x1prime[i]<-mdHouseholdEst[i+1]-rhat*mdHouseholdEst[i]
+ x2prime[i]<-mdUnemploy[i+1]-rhat*mdUnemploy[i]
+ x3prime[i]<-mdGDP[i+1]-rhat*mdGDP[i]}
> fit.trans<-lm(yprime~x1prime+x2prime+x3prime)

Durbin-Watson Test (for Cochrane Orcutt 1):
> dwtest(fit.trans)
	Durbin-Watson test
data:  fit.trans
DW = 2.3456, p-value = 0.9934
alternative hypothesis: true autocorrelation is greater than 0

Transforming Back (Cochrane Orcutt 1):
> b0
(Intercept) 
  -205023.8 
> b1
  x1prime 
0.7131439 
> b2
  x2prime 
-61.27356 
> b3
 x3prime 
7.471687 

Determine fit of Cochrane-Orcutt 1 Transformed Model:
> salespredict=b1*mdHouseholdEst+b2*mdUnemploy+b3*mdGDP+b0
> plot.ts(salespredict)
> points(mdHousePrice)

Cochrane-Orcutt Model 2 (House Price vs GDP and Household Estimates):
> res<-fit.all$residuals
> rnum<-0
> rdenom<-0
> for(i in 2:20){
+     rnum<-rnum+res[i]*res[i-1]
+     rdenom<-rdenom+res[i-1]^2
+      }
> rhat<- rnum/rdenom
> yprime<-rep(0,215-1)
> x1prime<-rep(0,215-1)
> x2prime<-rep(0,215-1)
> for (i in 1:214){
+     yprime[i]<-mdHousePrice[i+1]-rhat*mdHousePrice[i]
+     x1prime[i]<-mdHouseholdEst[i+1]-rhat*mdHouseholdEst[i]
+     x2prime[i]<-mdGDP[i+1]-rhat*mdGDP[i]}
> fit.trans<-lm(yprime~x1prime+x2prime)
> summary(fit.trans)

Call:
lm(formula = yprime ~ x1prime + x2prime)
Residuals:
     Min       1Q   Median       3Q      Max 
-15693.4  -2743.8    -65.4   1971.8  18846.5 
Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -2.107e+04  2.009e+03 -10.487   <2e-16 ***
x1prime      4.867e-01  4.825e-01   1.009    0.314    
x2prime      7.850e+00  8.693e-01   9.029   <2e-16 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4867 on 211 degrees of freedom
Multiple R-squared:  0.7948,	Adjusted R-squared:  0.7929 
F-statistic: 408.8 on 2 and 211 DF,  p-value: < 2.2e-16
	
Durbin-Watson Test (for Cochrane Orcutt 2):
> dwtest(fit.trans)
	Durbin-Watson test
data:  fit.trans
DW = 2.2492, p-value = 0.959
alternative hypothesis: true autocorrelation is greater than 0

> acf(rstudent(fit.trans))
> b0
(Intercept) 
  -198300.4 
> b1
  x1prime 
0.4867113 
> b2
 x2prime 
7.849562 

The Significance of Unemployment Rate after Removing Trend:
> fit10<-lm(mdHousePrice~time(mdHousePrice))
> res2=residuals(fit10)
> fit11<-lm(res2~mdUnemploy)
> summary(fit11)

Call:
lm(formula = res2 ~ mdUnemploy)
Residuals:
   Min     1Q Median     3Q    Max 
-31663  -8715  -2204   8757  36977 
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  30230.9     4047.1   7.470 2.04e-12 ***
mdUnemploy   -4984.8      643.9  -7.742 3.90e-13 ***
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
Residual standard error: 15600 on 213 degrees of freedom
Multiple R-squared:  0.2196,	Adjusted R-squared:  0.2159 
F-statistic: 59.94 on 1 and 213 DF,  p-value: 3.899e-13

> plot(res2)
> abline(fit11)
> plot(mdUnemploy,res2)
> abline(fit11)

ARIMA Models:

Augmented Dickey-Fuller Test:
> adf.test(mdHousePrice)
	Augmented Dickey-Fuller Test
data:  mdHousePrice
Dickey-Fuller = -2.4078, Lag order = 5, p-value = 0.4049
alternative hypothesis: stationary

ARIMA(1, 1, 1):
> fit1<-arima(mdHousePrice,order=c(1,1,1))
> summary(fit1)
          Length Class  Mode     
coef        2    -none- numeric  
sigma2      1    -none- numeric  
var.coef    4    -none- numeric  
mask        2    -none- logical  
loglik      1    -none- numeric  
aic         1    -none- numeric  
arma        7    -none- numeric  
residuals 215    ts     numeric  
call        3    -none- call     
series      1    -none- character
code        1    -none- numeric  
n.cond      1    -none- numeric  
model      10    -none- list     
> fit1
Call:
arima(x = mdHousePrice, order = c(1, 1, 1))
Coefficients:
          ar1     ma1
      -0.4541  0.2749
s.e.   0.2143  0.2267
sigma^2 estimated as 21890311:  log likelihood = -2112.14,  aic = 4228.28

ARIMA(2,1,1):
> fit2
Call:
arima(x = mdHousePrice, order = c(2, 1, 1))
Coefficients:
         ar1     ar2      ma1
      0.5340  0.3943  -0.7911
s.e.  0.0769  0.0642   0.0582
sigma^2 estimated as 18541821:  log likelihood = -2094.66,  aic = 4195.32

ARIMA(1,1,0):
> fit3<-arima(mdHousePrice,order=c(1,1,0))
> fit3
Call:
arima(x = mdHousePrice, order = c(1, 1, 0))
Coefficients:
          ar1
      -0.1785
s.e.   0.0672
sigma^2 estimated as 22058381:  log likelihood = -2112.95,  aic = 4227.91

ARIMA(0,1,1):
> fit4<-arima(mdHousePrice,order=c(0,1,1))
> fit4
Call:
arima(x = mdHousePrice, order = c(0, 1, 1))
Coefficients:
          ma1
      -0.1242
s.e.   0.0539
sigma^2 estimated as 22270348:  log likelihood = -2113.97,  aic = 4229.94

Optimizing ARIMA for Minimal AIC:
> best.arima <- function(x, maxord = c(1,1,1))
{
     best.aic <- 100000000
     n <- length(x)
     for (p in 0:maxord[1]) for(d in 0:maxord[2]) for(q in 0:maxord[3])  
     {
         fit <- arima(x, order = c(p,d,q), method="ML")
         fit.aic <- -2 * fit$loglik + 2 * length(fit$coef)
         if (fit.aic < best.aic) 
         {
             best.aic <- fit.aic
             best.fit <- fit
             best.model <- c(p,d,q) 
         }
     }
     list(best.aic, best.fit, best.model)
}

> best.arima(mdHousePrice, maxord=c(1,1,1))
[[1]]
[1] 4227.908
[[2]]
Call:
arima(x = x, order = c(p, d, q), method = "ML")
Coefficients:
          ar1
      -0.1785
s.e.   0.0672
sigma^2 estimated as 22058381:  log likelihood = -2112.95,  aic = 4227.91
[[3]]
[1] 1 1 0

> best.arima(mdHousePrice, maxord=c(2,2,2))
[[1]]
[1] 4169.33
[[2]]
Call:
arima(x = x, order = c(p, d, q), method = "ML")
Coefficients:
          ma1     ma2
      -1.2976  0.4972
s.e.   0.0559  0.0571
sigma^2 estimated as 18046606:  log likelihood = -2082.67,  aic = 4169.33
[[3]]
[1] 0 2 2

ARIMA(0,2,2):
> fit9<-arima(mdHousePrice, order=c(0,2,2))
> fit9
Call:
arima(x = mdHousePrice, order = c(0, 2, 2))
Coefficients:
          ma1     ma2
      -1.2976  0.4972
s.e.   0.0559  0.0571
sigma^2 estimated as 18046605:  log likelihood = -2082.67,  aic = 4169.33

Forecasting Using the ARIMA (0,2,2)
> n<-length(`Median Sales Price`)
> tempHousePrice<-ts(`Median Sales Price`[1:(n-4)], frequency=4)
> fittemp<-arima(tempHousePrice, order=c(0,2,2))
> frec<- predict(fittemp, n.ahead=4)
> ts.plot(tempHousePrice, frec$pred, col=1:2, xlim=c(35,55))
> lines(frec$pred, type="p", col=2)
> lines(frec$pred + 1*frec$se, lty="dashed", col=4)
> lines(frec$pred - 1*frec$se, lty="dashed", col=4)

> frec
$pred
       Qtr1     Qtr2     Qtr3     Qtr4
53                            307646.5
54 309642.3 311638.0 313633.7         

$se
       Qtr1     Qtr2     Qtr3     Qtr4
53                            4263.338
54 5214.790 6488.903 8024.082  

> ts.plot(mdHousePrice, frec$pred, col=1:2, xlim=c(35,55))
> lines(frec$pred, type="p", col=2)
> lines(frec$pred + 1*frec$se, lty="dashed", col=4)
> lines(frec$pred - 1*frec$se, lty="dashed", col=4)