# 다중회귀분석 (Multiple Regression)

설명변수가 두개 이상인 회귀분석   

## 다중회귀분석의 순서 

### (1) lm 함수를 사용하여 회귀분석 모델을 생성

### (2) 모델이 통계적으로 유의한지 여부 확인 

#### A. F-test

회귀분석 모델 전체에 대해 통계적으로 의미가 있는지 결정하기 위해 사용  
회귀분석 모델에서 F-statistic의 p-value 값이 0.05보다 작은 경우 회귀식 전체는 유의하다고 볼 수 있음  

#### B. P-value

변수의 p-value는 각 변수가 대상 변수에 유의하게 영향을 미치는지 확인하기 위해 사용  
0.05보다 작은 경우 각 변수는 유의하게 결과 변수를 설명한다고 볼 수 있음  

#### C. adjusted-r 제곱 

모델이 대상 변수의 몇 %를 설명하는지 확인  

### (3) 필요한 경우 partial F-test를 통해 추가할 새로운 변수나 삭제할 변수가 없는지 확인 

### (4) predict 함수를 사용하여 새로운 데이터 셋에 대한 예측값 구함  

## R 예제

```r
> require(datasets); require(ggplot2)
> data(swiss)
> str(swiss)
'data.frame':	47 obs. of  6 variables:
 $ Fertility       : num  80.2 83.1 92.5 85.8 76.9 76.1 83.8 92.4 82.4 82.9 ...
 $ Agriculture     : num  17 45.1 39.7 36.5 43.5 35.3 70.2 67.8 53.3 45.2 ...
 $ Examination     : int  15 6 5 12 17 9 16 14 12 16 ...
 $ Education       : int  12 9 5 7 15 7 7 8 7 13 ...
 $ Catholic        : num  9.96 84.84 93.4 33.77 5.16 ...
 $ Infant.Mortality: num  22.2 22.2 20.2 20.3 20.6 26.6 23.6 24.9 21 24.4 ...
> summary(swiss)
   Fertility      Agriculture     Examination      Education        Catholic       Infant.Mortality
 Min.   :35.00   Min.   : 1.20   Min.   : 3.00   Min.   : 1.00   Min.   :  2.150   Min.   :10.80   
 1st Qu.:64.70   1st Qu.:35.90   1st Qu.:12.00   1st Qu.: 6.00   1st Qu.:  5.195   1st Qu.:18.15   
 Median :70.40   Median :54.10   Median :16.00   Median : 8.00   Median : 15.140   Median :20.00   
 Mean   :70.14   Mean   :50.66   Mean   :16.49   Mean   :10.98   Mean   : 41.144   Mean   :19.94   
 3rd Qu.:78.45   3rd Qu.:67.65   3rd Qu.:22.00   3rd Qu.:12.00   3rd Qu.: 93.125   3rd Qu.:21.70   
 Max.   :92.50   Max.   :89.70   Max.   :37.00   Max.   :53.00   Max.   :100.000   Max.   :26.60   
> 
> # 정규성 확인 
> 
> hist(swiss$Infant.Mortality)
> qqnorm(swiss$Infant.Mortality)
> qqline(swiss$Infant.Mortality)
```
직선에서 점들이 크게 벗어나지 않으면 정규분포를 따른다고 볼 수 있음 

```r
> # 문법 : lm(대상변수~설명변수1+설명변수2, data= 사용할 데이터 셋 명)
> 
> model<-lm(Infant.Mortality~. ,data=swiss)
> summary(model)

Call:
lm(formula = Infant.Mortality ~ ., data = swiss)

Residuals:
    Min      1Q  Median      3Q     Max 
-8.2512 -1.2860  0.1821  1.6914  6.0937 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)   
(Intercept)  8.667e+00  5.435e+00   1.595  0.11850   
Fertility    1.510e-01  5.351e-02   2.822  0.00734 **
Agriculture -1.175e-02  2.812e-02  -0.418  0.67827   
Examination  3.695e-02  9.607e-02   0.385  0.70250   
Education    6.099e-02  8.484e-02   0.719  0.47631   
Catholic     6.711e-05  1.454e-02   0.005  0.99634   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.683 on 41 degrees of freedom
Multiple R-squared:  0.2439,	Adjusted R-squared:  0.1517 
F-statistic: 2.645 on 5 and 41 DF,  p-value: 0.03665
```

**(1)** f-stat의 p-value를 보면 0.03665로 0.05보다 작아 **이 모델은 유의하게 Infact.Fertility를 설명하는데 사용할 수 있음**  
**(2)** coefficients에서 여러 변수들의 p-value를 확인할 결과 Infact.Fertility와 유의한 관계에 있는 별수는 Fertility 하나 (p-value=0.00734)  
그렇다면, Fertility 변수를 제외한 다른 변수들을 모두 삭제했을 때 모델이 통계적으로 달라지는지 확인하기 위해 **Partial F-test** 진행  

```r
> model_simple = lm(Infant.Mortality~Fertility, data=swiss)
> anova(model, model_simple)
Analysis of Variance Table

Model 1: Infant.Mortality ~ Fertility + Agriculture + Examination + Education + 
    Catholic
Model 2: Infant.Mortality ~ Fertility
  Res.Df    RSS Df Sum of Sq      F Pr(>F)
1     41 295.07                           
2     45 322.54 -4   -27.472 0.9543 0.4427
```
Fertility와 Infant.Fertility 두 개의 변수만을 사용하여 model_simple 객체를 만들고 anova 함수로 두 모델을 비교  
p-value는 0.4427로 두 모델의 Infact.Mortality에 대한 설명력에는 차이가 없다고 볼 수 있음  
  
다음에는 predict함수를 사용하여 새로운 Fertility에 대한 Infant.Mortality 예측  
```r
> new_Fertility<-rnorm(10, mean=mean(swiss$Fertility), sd=sd(swiss$Fertility))
> new_Fertility<-as.data.frame(new_Fertility)
> colnames(new_Fertility)<-c("Fertility")
> predict(model_simple, new_Fertility, interval="prediction")
        fit      lwr      upr
1  19.95792 14.50864 25.40719
2  20.74581 15.27118 26.22043
3  20.06569 14.61583 25.51555
4  19.35279 13.88984 24.81574
5  17.75597 12.12149 23.39045
6  20.53177 15.06884 25.99469
7  21.47787 15.93652 27.01923
8  20.18215 14.73063 25.63368
9  19.49950 14.04251 24.95649
10 18.16890 12.59708 23.74072
```
새로운 10개 Fertility에 대한 예측 값은 fit컬럼에, 95% 신뢰구간은 lwr/upr에서 확인  
새로 입력하는 데이터셋의 변수명은 모델에서 사용한 변수명과 동일하게 지정해야함  

## 주의! 다중공선성 문제 

회귀모델의 설명 변수들 사이에 상관관계가 있는 경우를 '다중공선성'이라고 함  
다중공선성은 모델의 정확도를 낮추기 때문에, 설명력이 더 적은 변수를 제거하는 등의 방법으로 모델을 재구성  
  
다중공선성을 판단하는 방법 중 하나는 **vif 함수**를 사용하여 VIF값을 구하고, 보통 4가 넘으면 다중공선성이 존재한다고 봄

```r
require(car)
vif(model)

Fertility Agriculture Examination   Education    Catholic 
   2.855428    2.606925    3.754457    4.253857    2.349161
```

 



