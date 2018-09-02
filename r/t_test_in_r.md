# t-test 

## t-test의 유형

- 독립표본 t-test
  - 서로 다른 두 그룹간의 평균 비교  
- 대응표본 t-test
  - 하나의 집단에 대한 비교 
- 단일표본 t-test
  - 특정 집단의 평균이 어떤 숫자와 같은지 다른지 비교
  
## t-test의 조건

두 집단에 대한 t-test를 실시하기 위해서는 **등분산성, 정규성**이 만족되어야 함  

- 정규성
  - 일반적으로 관측 갯수가 30개 이상일 때 만족한다고 판단할 수 있음 (?)
- 등분산성
  - var.test 함수 사용 

```r
a = c(175, 168, 168, 190, 156, 181, 182, 175, 174, 179)
b = c(185, 169, 173, 173, 188, 186, 175, 174, 179, 180)
 
var.test(a,b)
```
```p-value가 0.05보다 작은 경우, 두 집단의 분산은 유의미하게 다르다고 볼 수 있음```

## (1) 독립표본 t-test

```서로 다른 두 개의 그룹 간 평균의 차이가 유의미한가?```  

### 독립적이기 위해서는 아래의 조건을 만족해야함  
1) 두개의 표본이 서로 관계없는 모집단에서 추출
2) 표본 간에는 아무런 관계가 없음  
  
### 등분산성 확인 

### r에서 t-test 2가지 방법  
  
독립표본 t-test에서는 ```var.equal=TRUE```로 지정 
신뢰범위 default는 0.95  

#### 1) 두 집단의 평균을 각각 별개의 벡터 객체로 만들어 입력하는 방법
 ```r
# 문법
t.test(group1의 관측치 벡터, group2의 관측치 벡터, t-test유형, 신뢰범위)
 
# 예시
t.test(mtcars[mtcars$am==0,1 ], mtcars[mtcars$am==1, 1],  paired =
+            FALSE, var.equal = TRUE, conf.level = 0.95)

	Two Sample t-test

data:  mtcars[mtcars$am == 0, 1] and mtcars[mtcars$am == 1, 1]
t = -4.1061, df = 30, p-value = 0.000285
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -10.84837  -3.64151
sample estimates:
mean of x mean of y 
 17.14737  24.39231
 ```
#### 2) 하나의 데이터 프레임에서 집단을 구분하고자하는 기준을 입력
```r
# 문법
t.test(관측치~집단구분기준, 데이터프레임, t-test유형, 신뢰범위)

#예시
t.test(mpg ~ am, data=mtcars, var.equal=TRUE, conf.level = 0.95) 

	Two Sample t-test

data:  mpg by am
t = -4.1061, df = 30, p-value = 0.000285
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -10.84837  -3.64151
sample estimates:
mean in group 0 mean in group 1 
       17.14737        24.39231
```
  
```p-value = 0.001374로, 오토와 수동 자동차의 mpg차이는 유의함```

## (2) 대응표본 t-test

```동일한 집단의 전-후 차이 비교```
*(초콜렛을 하루 30g씩 섭취하는 것이 수면 시간에 영향을 미치는가? 과외를 받는 것이 학교 성적에 영향을 미치는가?)*

주의: 실험 전-후를 비교하는 것이기 때문에 입력하는 관측치의 수가 반드시 같아야함  

```r
mid = c(16, 20, 21, 22, 23, 22, 27, 25, 27, 28)
final = c(19, 22, 24, 24, 25, 25, 26, 26, 28, 32)
t.test(mid,final, paired=TRUE)

	Paired t-test

data:  mid and final
t = -4.4721, df = 9, p-value = 0.00155
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3.0116674 -0.9883326
sample estimates:
mean of the differences 
                     -2
```

```p-value = 0.00155로 전-후 평균 성적은 통계적으로 유의미함```

## (3) 단일표본 t-test

```하나의 집단의 평균이 특정 기준보다 유의미하게 다른지 혹은 큰지/작은지를 판단```

큰지/작은지/같은지는 alternative에서 'greater', 'less', 'two.sided'로 입력  

```r
# 문법
t.test(관측치, alternative=판별방향, mu=특정기준, conf.level=신뢰수준)

# 예시 
t.test(prem, alternative="greater", mu=24, conf.level = .95)

	One Sample t-test

data:  prem
t = 1.0093, df = 9, p-value = 0.1696
alternative hypothesis: true mean is greater than 24
95 percent confidence interval:
 23.10218      Inf
sample estimates:
mean of x 
     25.1
```

```p-value=0.1696으로 귀무가설 기각할 수 없음. 즉 95% 신뢰수준에서 학생들의 기말고사 성적은 24점보다 높다고 할 수 없음```






