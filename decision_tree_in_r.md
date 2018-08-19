# Decision Tree in R

[blog link](http://www.dodomira.com/2016/05/29/564/)

## 의사결정나무?

- 기계학습 중 하나로 특정 항목에 대한 의사결정 규칙을 나무형태로 분류해나가는 분석기법
- 장점
  - 분석과정이 직관적이고 이해하기 쉬움 (화이트박스 모델)
    - 반면 인공신경망의 경우, 결과에 대한 설명을 이해하기 어려운 대표적인 블랙박스 모델 
  - 수치형/범주형 변수 모두 사용 가능 
  - 계산 비용이 낮아 대규모의 데이터 셋에서도 빠르게 연산 가능 
- 분석방법
  - 카이스퀘어, T검정, F검정 등 통계학에 기반한 CART 및 CHAID 알고리즘
  - 엔트로피, 정보 이득 등 기계학습에 기반한 ID3, C4.5, C5.0 알고리즘
  
## R에서 패키지 비교 (TREE, RPART, PARTY 패키지)

- 의사결정나무를 만들 때 가지치기를 하는 방법에 차이가 존재 
  - (1) TREE - Binary Recursive Partitionaing
  - (2) RPART - CART (Classification and Regression Trees)  
    - 이 패키지들은 엔트로피, 지니계수를 기준으로 가지치기를 할 변수를 결정 
    - 상대적으로 속도를 빠르지만 과적합화의 위험성 존재  
    - 따라서 pruning의 과정을 거쳐서 의사결정나무를 최적화하는 과정 필요  
  - (3) PARTY - Unbiased recursive partitionaing based on permutation tests 
    - p-test를 거친 significance를 기준으로 가지치기를 할 변수를 결정 
    - biased될 위험이 없어 별도로 pruning할 필요 없음 
    - 하지만 변수의 레벨이 31개까지로 제한 
    
#### TREE 패키지를 사용한 의사결정 나무 분석


```r
df = read_csv('Kor_Train_TrafficAccident_OSX.txt')

library(caret)

set.seed(1000)

intrain = createDataPartition(y=df$killed, p=0.7, list=FALSE)
train = df[intrain,]
test = df[-intrain,]

colnames(df) = c('night','week','killed','middle','high','report','road','type','violation','roadtype','1cate','2cate')

head(train)
dim(train)
dim(test)


#### tree package

install.packages('tree')
library(tree)

treemod = tree(killed~. , data=train)
View(train)

```

  
