#------------------------------------------------ 데이터 구조 (벡터, 행렬, 데이터프레임, 배열, )

### 벡터

c() ; seq() ; rep()

### 행렬

m = matrix(c(1,2,3,4,5,6), ncol=2) 
m

r1 = c(10,10)
rbind(m, r1)

### 데이터프레임

a1 = c(100,200,300)
b1 = c('a','b','c')
c1 = c(FALSE, FALSE, TRUE)
d = data.frame(income=a1, car=b1, marriage=c1)
d

### 배열

a = array(1:12, dim=c(3,4))
a

b = array(1:12, dim=c(2,2,3)) # 다차원
b

### 리스트 (연관 배열)

a = list(name="song", height=192)
a

#------------------------------------------------ 외부 데이터 불러오기  

### csv 

read.csv()

### txt

read.table()

### 엑셀파일 - 하지만 비추 그냥 csv 변환후 불러오는 것 추천 

install.packages('RODBC')
library(RODBC)
new = odbcConnectExcel()
mydata = sqlFetch(new, 'traffic_death')
mydata

#------------------------------------------------ 기초함수

### 수열 생성하기 

rep(1,3) #1을 세번 반복

rep(2:5, 3) #2-5까지 3번 반복

seq(1,3) # 1부터 3까지 1씩 증가

seq(1,11,by=2) # 1부터 11까지 2씩 증가  (by는 optional)

seq(1,20,length=9) # 1부터 20까지 9개가 죄조록 증가하는 수열 생성 

### 기초 행렬 계산 
 
a = 1:10

t(a)

a*a # 스칼라곱 

a%*%t(a) # 전치행렬에 행렬곱

solve() # 역행렬

### 기초적인 대푯값 및 분산 

c = 1:10

mean(c)

var(c)

sd(c)

### 기초적인 변환 및 상관계수, 공분산

sum(c)

median(c)

log(c)
 
a = 1:10
b = log(c)

cov(a,b) # 공분산 

cor(a,b) # 상관계수

summary(a) 


