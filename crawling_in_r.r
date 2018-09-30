install.packages('rvest')
library(rvest)
install.packages('httr')
library(httr)
library(xml2)

install.packages('stringi')
library(stringi)
library(dplyr)

Sys.getlocale()

url = 'http://picbear.club/tag/%EC%95%84%EC%9A%B0%EC%96%B4%EB%B2%A0%EC%9D%B4%EC%BB%A4%EB%A6%AC'

dat = GET(url)
box = read_html(dat, encoding = "ISO-8859-1")

hash = html_nodes(box, css='.grid-media')



############

hash2 = html_nodes(box, '.grid-media') 
length(hash2)

head(hash2)

hash3 = html_nodes(hash2,'p.grid-m3edia-caption') %>% html_text
length(hash2)
class(hash3)

hash3[1]


###############
install.packages('RSelenium')
library(RSelenium)
pJS = wdman::phantomjs(port=4567L)
remDr = remoteDriver(port=4567L, browserName='phantomjs')
remDr$open()
remDr$navigate("http://picbear.club/tag/%EC%95%84%EC%9A%B0%EC%96%B4%EB%B2%A0%EC%9D%B4%EC%BB%A4%EB%A6%AC")
remDr$screenshot(display = T)

webElem <- remDr$findElement("css", "body")
webElem$sendKeysToElement(list(key = "end"))
remDr$screenshot(display = T)




webElem <- remDr$findElement(using = "css", "[name = 'q']")
webElem$sendKeysToElement(list("R Cran"))
remDr$screenshot(display = T)

webElem$sendKeysToElement(list(key = "enter"))
remDr$screenshot(display = T)

webElems <- remDr$findElements(using = 'css selector', "h3.r")
resHeaders<-unlist(lapply(webElems, function(x){x$getElementText()}))
resHeaders

remDr$mouseMoveToLocation(webElement = webElems[[1]])
remDr$click(1)
remDr$screenshot(display = T)
remDr$getCurrentUrl()

remDr$getTitle()[[1]]
remDr$screenshot(display = T)
remDr$close()
pJS$stop()
