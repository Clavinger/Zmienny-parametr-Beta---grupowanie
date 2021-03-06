#pakiet tworzy baze danych do badania
#wymaga podania poczatku i konca badania


############################################
#poczatek okresu badania 
data.poczatkowa='2009-01'
#koniec okresu badania
data.koncowa='2016-12'
############################################


#ladowanie wymaganych pakietow
library(quantmod)
library(PerformanceAnalytics)

#rm(list = ls())
setwd("C:/Users/user/Documents/github/Zmienny-parametr-Beta---grupowanie/Dane")

#wczytanie tiker�w z pliku
tikery=as.matrix(read.csv2(file="tikery.csv"))
tikery=tikery[,-1]


##############################################################################
#wczytywanie danych spelniajace krytyk�w 
baza.danych.tikery=c()

licznik=1
for(i in 1:length(tikery)){
  temp.x=read.csv.zoo(paste(tikery[i],"_zwroty.csv",sep=""),sep=',')
  temp.x=as.xts(temp.x)
  if(length (temp.x[paste("/",data.poczatkowa,sep="")])> 0 ){
    assign(paste(tikery[i],".zwroty",sep=""),value=temp.x[paste(data.poczatkowa,"/",data.koncowa,sep="")])
    baza.danych.tikery=c(baza.danych.tikery,tikery[i])
    licznik=licznik+1
    n=length(temp.x[paste(data.poczatkowa,"/",data.koncowa,sep="")])
    print(n)
  }

}
##############################################################################



##############################################################################
#tworzenie bazy danych
baza.danych.zwroty=matrix(0,nrow =n ,ncol=length(baza.danych.tikery))
for(i in 1:length(baza.danych.tikery)){
  baza.danych.zwroty[,i]=get(paste(baza.danych.tikery[i],".zwroty",sep=""))
}
colnames(baza.danych.zwroty)=baza.danych.tikery
baza.danych.zwroty=xts(baza.danych.zwroty,
                       order.by=index(get(paste(baza.danych.tikery[1],".zwroty",sep=""))))
write.zoo(baza.danych.zwroty,file="baza_danych_zwroty.csv",sep=',')
##############################################################################

#czyszczenie pamieci podrecznej
#rm(list = ls())


#przyklad uzycia bazy
#baza.danych.zwroty[,'ACP']


#przyklad jak odczytywa� baze danych
#baza.danych.zwroty=read.csv.zoo("baza_danych_zwroty.csv",sep=',')
#baza.danych.zwroty=as.xts(baza.danych.zwroty)
#is.xts(baza.danych.zwroty)
#baza.danych.zwroty['2012-03']
