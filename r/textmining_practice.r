install.packages('rJava')
library(rJava)
library(dplyr)
library(KoNLP)
library(stringr)
library(RColorBrewer)
library(wordcloud)
useNIADic()
keyword <- read.csv("living.csv",stringsAsFactors = F)
str(keyword)
head(keyword)
dim(keyword)

word = strsplit(keyword$keyword, ' ')
word <- str_replace_all(keyword$keyword,"\\W","")
word <- extractNoun(word)
head(word)
wordcount <- table(unlist(word))
head(wordcount)
df_word <- as.data.frame(wordcount,stringsAsFactors = F)
df_word <- rename(df_word,
                  word=Var1,
                  freq=Freq)
df_word <- filter(df_word,nchar(word)>=2)
dim(df_word)
View(df_word)
dim(df_word)
write.csv(df_word, 'livingnoun.csv')


top20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(50)
View(top20)

wordcloud(words=df_word$word,
          freq=df_word$freq,
          max.words = 70,
          min.freq = 0,
          random.order = F,
          rot.per = 0,
          scale=c(5,1),
          colors=brewer.pal(8,"Dark2"))

install.packages('HMM')
library(HMM)

#문자열 코딩, 00101 
makeCorpus <- function(str){
  strv <- strsplit(str,split="")[[1]]
  lenstrv <- length(strv)
  spacev <- vector(mode="character",length=lenstrv)
  charv  <- vector(mode="character",length=lenstrv)
  vidx <- 1
  for(i in 1:lenstrv){
    if(strv[i] == " ") {
      next
    }
    if(i + 1 <= lenstrv && strv[i + 1] == " "){
      #spacev <- append(spacev, "1")
      spacev[vidx] <- "1"
    }else{
      if(i == lenstrv){
        spacev[vidx] <- "1"
      }else{
        spacev[vidx] <- "0"
      }
    }
    charv[vidx] <- strv[i]
    vidx <- vidx + 1
  }
  return(data.frame(status=spacev,char=charv))
}


#전이확률 계산 
getTransprob <- function(str){
  charv <- strsplit(str,split="")[[1]]
  status <- unique(charv)
  transMat <- matrix(0,nrow=length(status),ncol=length(status), 
                     dimnames=list(status, status))
  for(i in 1:(length(charv) -1)){
    rowidx <- which(rownames(transMat) == charv[i])
    colidx <- which(colnames(transMat) == charv[i + 1])
    transMat[rowidx, colidx] <- transMat[rowidx, colidx] + 1
  }
  prop.table(transMat,margin=1)
}

#관측확률 계산
observProb <- function(rawcorpus){
  statecntdf <- aggregate(rawcorpus[[1]], by=list(rawcorpus[[2]]), table)  
  statecnts <- as.data.frame(statecntdf$x)
  prob0 <- statecnts$`0`/rowSums(statecnts)
  prob1 <- statecnts$`1`/rowSums(statecnts)
  cbind(char=statecntdf[,1], statecnts, prob0, prob1)
}


# 모델을 가지고 하는 띄어쓰기
spacing <- function(hmm, str){
  strsp <- strsplit(str, split="")[[1]]
  emissions <- viterbi(hmm, strsp)
  if(length(strsp) != length(emissions)){
    stop("lengths are not match!")
  }
  strspacing <- vector(mode="character",length=length(strsp) * 2)
  spacingidx <- 1
  for(i in 1:length(emissions)){
    strspacing[spacingidx] <- strsp[i]
    if(emissions[i] == "1"){
      spacingidx <- spacingidx + 1
      strspacing[spacingidx] <- " "
    }
    spacingidx <- spacingidx + 1
  }
  return(paste(strspacing[1:spacingidx-1], collapse=""))
}



################ 실행 ########################################################


#코퍼스 파일 읽음 
fp <- file("choi.txt", encoding="UTF-8")
lines <- readLines(data$keyword)
close(fp)
fullstr <- paste(data$keyword, collapse="")
#띄어쓰기 코딩 
fullrawcorpus <- makeCorpus(fullstr)
#관측확률 계산 
oprob <- observProb(fullrawcorpus)
#전이확률 계산 
trprob <- getTransprob(paste(fullrawcorpus$status,collapse=""))

#HMM 모델 빌드
hmm <- initHMM(c("0", "1"), oprob$char, 
               startProbs=c(.9,.1), transProbs=trprob, emissionProbs=t(as.matrix(oprob[,c(5,6)])))

# 비터비 알고리즘으로 띄어 쓰기  
spacing(hmm, "일정한조건에따르면,자유롭게이것을재배포할수가있습니다.")


