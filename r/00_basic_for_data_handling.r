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

#------------------------------------------------ 데이터 핸들링

### 벡터형 변수 

b = c('a', 'b','c')
b[2]
b[-3]
b[c(1,2)]

### 반복구문과 조건문 

# for 반복구문

a = c()

for (i in 1:9) {
  a[i]= i*i
}

a

# while 반복구문

x=1

while(x<5) {
  x=x+1
  print(x)
}

# if-else 조건문

x = 1
ifelse(x>0, '양수', '양수아님')

### 사용자 정의 함수

foruse = function(a) {
  isum = 0
  for (i in 1:a){
    isum = isum + i 
  }
  print(isum)
}

foruse(3)

### 기타 유용한 함수 

# paste

number = 1:5
alphabet = c('a','b','c')

paste(number, alphabet)

paste(number, alphabet, sep='to the')

# substr

country = c('korea','japan')
substr(country,1,2)

# 자료형 데이터 구조변환

as.data.frame()
as.list()
as.matric()
as.vector()
as.factor()
as.integer() # 실수를 정수로 
as.numeric() 
as.logical() # 0은 false

as.Date() # 문자열을 날짜로 / 기본으로 문자열이 yyyy-dd-mm일거라고 가정 
as.Date('01/13/2018',format='%m/%d/%y') # 날짜형 스타일 지정 

format(Sys.Date()) # 날짜를 문자열로 


format(Sys.Date(), '%a') # 요일 (금)
format(Sys.Date(), '%A') # 요일 (금요일)

format(Sys.Date(), '%b') # 월 (8)
format(Sys.Date(), '%B') # 월 (8월)

format(Sys.Date(), '%c') # full (금 8 24 00:00:00 2018)
format(Sys.Date(), '%C') # ??

format(Sys.Date(), '%d') # 일 (14)
format(Sys.Date(), '%D') # FULL (08/24/18)

format(Sys.Date(), '%y') # 연도 (18)
format(Sys.Date(), '%Y') # 연도 (2018)

