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

![image](https://user-images.githubusercontent.com/28600272/46255503-a7ae5400-c4d8-11e8-8287-668233e5936a.png)

### (참고) RColorBrewer 팔레트 

[R documentation on RColorBrewer](https://www.rdocumentation.org/packages/RColorBrewer/versions/1.1-2/topics/RColorBrewer)  
[R Color Palette](https://moderndata.plot.ly/create-colorful-graphs-in-r-with-rcolorbrewer-and-plotly/)  
![image](https://user-images.githubusercontent.com/28600272/46255534-17244380-c4d9-11e8-917b-b59d7fb8e8a5.png)


