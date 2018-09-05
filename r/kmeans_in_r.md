# K-means 군집 분석 

**군집분석**은 비지도학습 분석 중 하나  
즉, 사전 정보 없이 자료를 입력하고 유사한 대상끼리 묶어보라고 명령하는 것 
대상간의 유사도, 거리를 측정하는 방법에는 여러가지 존재  
  
**k-means 군집분석**은 **비계층적 군집 분석** 중 하나  
계산량이 적어 대용량 데이터로도 빠르게 처리 가능  

#### 알고리즘  
- 분석자가 설정한 k개의 군집 중심점을 랜덤하게 선정  
- 관측치를 가장 가까운 군집 중심에 할당한 후 군집 중심을 새로 계산  
- 기존의 중심과 새로 계산한 군집 중심이 같아질 때까지 반복  (엥?)

## K-means in R

```r

# 데이터 준비 

library(caret)
set.seed(123)
inTrain = createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training = iris[inTrain,]
test = iris[-inTrain,]

# 표준화 

training.data = scale(training[-5])

summary(training)
  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
 Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
 Median :5.800   Median :3.000   Median :4.400   Median :1.300  
 Mean   :5.841   Mean   :3.035   Mean   :3.789   Mean   :1.198  
 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.200   3rd Qu.:1.800  
 Max.   :7.900   Max.   :4.000   Max.   :6.900   Max.   :2.500  
       Species  
 setosa    :35  
 versicolor:35  
 virginica :35  
                
                
                
summary(training.data) # 차이비교
  Sepal.Length       Sepal.Width        Petal.Length    
 Min.   :-1.74163   Min.   :-2.57884   Min.   :-1.5421  
 1st Qu.:-0.83745   1st Qu.:-0.58599   1st Qu.:-1.2103  
 Median :-0.04629   Median :-0.08778   Median : 0.3381  
 Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000  
 3rd Qu.: 0.63185   3rd Qu.: 0.65954   3rd Qu.: 0.7805  
 Max.   : 2.32720   Max.   : 2.40328   Max.   : 1.7206  
  Petal.Width     
 Min.   :-1.4303  
 1st Qu.:-1.1698  
 Median : 0.1327  
 Mean   : 0.0000  
 3rd Qu.: 0.7840  
 Max.   : 1.6958  

# 모델 작성 

iris.kmeans = kmeans(training.data[,-5], center=3, iter.max=10000)
iris.kmeans$centers
  Sepal.Length Sepal.Width Petal.Length Petal.Width
1   0.01167492  -0.8925851    0.3508791   0.2763463
2   1.14228028   0.2738255    1.0159839   1.0529085
3  -1.02474316   0.7520636   -1.2908510  -1.2405049

# 군집 확인 

training$cluster = as.factor(iris.kmeans$cluster)
qplot(Petal.Width, Petal.Length, colour=cluster, data=training)

table(training$Species, training$cluster)
            
              1  2  3
  setosa      0  0 35
  versicolor 29  6  0
  virginica  10 25  0

```

setosa는 잘 구분하지만 versicolor나 virginica는 잘 구분하지 못함  

## 군집 중심의 갯수를 정하는 법 

### (1) NbClust 함수 사용

```r
# 1) NbClust 함수 사용 

install.packages('NbClust')
Error in install.packages : Updating loaded packages
library(NbClust)

nc = NbClust(training.data, min.nc=2, max.nc=15, method='kmeans')
*** : The Hubert index is a graphical method of determining the number of clusters.
                In the plot of Hubert index, we seek a significant knee that corresponds to a 
                significant increase of the value of the measure i.e the significant peak in Hubert
                index second differences plot. 
 
*** : The D index is a graphical method of determining the number of clusters. 
                In the plot of D index, we seek a significant knee (the significant peak in Dindex
                second differences plot) that corresponds to a significant increase of the value of
                the measure. 
 
******************************************************************* 
* Among all indices:                                                
* 7 proposed 2 as the best number of clusters 
* 10 proposed 3 as the best number of clusters 
* 1 proposed 5 as the best number of clusters 
* 2 proposed 8 as the best number of clusters 
* 1 proposed 10 as the best number of clusters 
* 2 proposed 14 as the best number of clusters 
* 1 proposed 15 as the best number of clusters 

                   ***** Conclusion *****                            
 
* According to the majority rule, the best number of clusters is  3 
 
 
******************************************************************* 
par(mfrow=c(1,1))
barplot(table(nc$Best.n[1,]),xlab="number of clusters", ylab="number of criteria", main = "number of clusters chosen")    


# 2) 그룹 내 sum of squares 확인 

wssplot <- function(data, nc=15, seed=123){
+   wss <- (nrow(data)-1)*sum(apply(data,2,var))
+   for (i in 2:nc){
+     set.seed(seed)
+     wss[i] <- sum(kmeans(data, centers=i)$withinss)}
+   plot(1:nc, wss, type="b", xlab="Number of Clusters",
+        ylab="Within groups sum of squares")}

wssplot(training.data)

# 새로운 데이터에 군집 할당 

training.data<-as.data.frame(training.data)

modFit <- train(x=training.data[,-5],
+                 y=training$cluster,
+                 method="rpart")

testing.data<-as.data.frame(scale(test[-5]))

testClusterPred <- predict(modFit,testing.data) 

table(testClusterPred ,test$Species)
               
testClusterPred setosa versicolor virginica
              1      0         11         5
              2      0          4        10
              3     15          0         0

```



