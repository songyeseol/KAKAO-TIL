# 일원배치 분산분석

독립된 세 집단 이상의 평균을 비교하고자 할 때  
각 집단이 서로 다른 유의미한 차이를 보이는가?  

## 전제 조건: 오차의 등분산성 검정 
```r
bartlett.test(Sepcal.Width~Species, data=iris)
```
p-value가 0.05보다 크다면 귀무가설 기각 불가  
**즉, 오차의 등분산성 가정을 만족**  


## iris 데이터를 활용한 일원배치 분산분석
```r
analysis = aov(Sepal.Width~Species, data=iris)
summary(analysis)
```
주의: 그룹 변수는 factor로 입력할 것 (as.factor 활용)  
**결과 p-value값을 확인하고 귀무가설 기각 여부 결정**
