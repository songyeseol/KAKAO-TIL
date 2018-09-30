# wordcloud2 라이브러리 (폰트, 컬러팔레트 적용)

```r
# 필요 라이브러리 설치 

library(RColorBrewer)
library(wordcloud2)
library(extrafont)

# 디렉토리 세팅 및 데이터 불러오기 

setwd('C://Users//KAKAO//Desktop')
data = read.csv('kwd.csv', header=TRUE, stringsAsFactors = FALSE)

head(data)
str(data)

# 특정 값을 가지는 행만 추출하기 

data6 = data[data$Category=='자동차',] # 자동차 카테고리를 가진 검색키워드와 이에 해당하는 qc만 추출

# 워드클라우드 그리기 

fonts() # embedding되어있는 폰트 확인 가능

pal = brewer.pal(11,'RdYlGn') # 컬러 팔레트 선정 

wordcloud2(data7[1:500,], size=1, color='random-dark', rotateRatio = 0, fontFamily = 'Kakao Bold') 
```
