#install.packages("reshape")
library(reshape) #gotta get that lib
library(tidyverse)
library(dplyr)
library(stringr)
library(forcats)
library(lubridate)


#read the data
mdata <- read_csv("SimResultsRaw.csv")
cdata <- read_csv("SimResultsCumul.csv")
avg <- read_csv("SimResultsAvg.csv")

#convert to tidy data
mdata2 <- mdata %>% 
  gather(`1`,`2`,`3`,`4`,`5`,`6`,`7`,`8`,`9`,`10`,`11`,`12`,`13`,`14`,`15`,`16`,`17`,`18`,`19`,
         `20`,`21`,`22`,`23`,`24`,`25`,`26`,`27`,`28`,`29`,`30`,`31`,`32`,key = 'Pick',value='Amount')%>%
  mutate(Pick = as.integer(Pick))

#convert to tidy data
cdata2 <- cdata %>% 
  gather(`1`,`2`,`3`,`4`,`5`,`6`,`7`,`8`,`9`,`10`,`11`,`12`,`13`,`14`,`15`,`16`,`17`,`18`,`19`,
         `20`,`21`,`22`,`23`,`24`,`25`,`26`,`27`,`28`,`29`,`30`,`31`,`32`,key = 'Pick',value='Amount')%>%
  mutate(Pick = as.integer(Pick))

#----violin plot a bunch of players-----
poi = c("Alex Turcotte","Bowen Byram","Dylan Cozens","Kirby Dach")
sdata <- mdata2 %>%
  filter(Player %in% poi) %>%
  filter(Amount>0)
sdata$Player <- factor(sdata$Player, levels = rev(poi)) #This puts it in reverse order of POI
ggplot(data=sdata,aes(x=Player,y=Pick,fill=Player))+
  geom_violin(stat = "identity", aes(violinwidth = Amount/400000))+
  theme_minimal()+
  #scale_y_continuous("Pick#", labels = as.character(sdata$Pick), breaks = sdata$Pick)+
  #scale_y_continuous(breaks = round(seq(min(sdata$Pick), 31, by = 2),1),minor_breaks=NULL,limits=c(1,31))+
  scale_y_continuous(breaks = round(seq(1, 31, by = 2),1),minor_breaks=NULL,limits=c(1,31))+
  coord_flip()+
  labs(y="Pick#",x="Relative Amount",
       title = "The Rear11 Sim Results - Ordered by Average Pick")+
  theme(plot.background = element_rect(fill='gray', colour='blue'))+ #makes the background of the whole thing gray
  guides(fill=FALSE)#gets rid of color legend

#------graph player n------
playerName = 'Arthur Kaliyev'
a1 <- avg %>%
  filter(Player==playerName)

avgRank = a1[[2]][1]

g0 <- ggplot(data=subset(mdata2,Player==playerName),aes(x=Pick,y=Amount,fill=Amount))+
  geom_bar(stat="identity")+
  geom_text(aes(label=ifelse(Amount>1000|Amount==0,str_c(as.character(round(Amount/10000,2)),'%'),"<.1%")), vjust=-.2, color="black", size=2.8)+
  scale_x_continuous(breaks = round(seq(1, 32, by = 1),1),minor_breaks=NULL,limits=c(1,33))+
  labs(y="Amount",
       title = "Sim Results")

g1 <- ggplot(data=subset(cdata2,Player==playerName),aes(x=Pick,y=Amount,fill=Amount))+
  geom_bar(stat="identity")+
  geom_text(aes(label=ifelse(Amount>=.1|Amount==0,str_c(as.character(round(Amount,1)),'%'),"<.1%")), vjust=-.2, color="black", size=2.8)+
  scale_x_continuous(breaks = round(seq(1, 32, by = 1),1),minor_breaks=NULL,limits=c(0,33))+
  labs(y="Percent", x="Pick# - Note 32 indicates: fell outside first round",
       title = str_c("Cumulative Probability ",playerName," still available at each pick"))+
  theme_minimal()

#combine sickass graphs
#on one plot:
p1 <- gridExtra::grid.arrange(g0,g1,
                              top = str_c(playerName," Draft Sim Results"),
                              bottom = str_c('Average Pick: ',as.character(avgRank)),
                              nrow = 2)

ggsave(str_c(playerName,'.png'),p1,"png",width = 30, height = 20, units = "cm",dpi=300)



#----#iterate through list of players and save graphs------
namelist <- c(cdata$Player)
for(playerName in namelist){
  a1 <- avg %>%
    filter(Player==playerName)
  
  avgRank = a1[[2]][1]
  
  g0 <- ggplot(data=subset(mdata2,Player==playerName),aes(x=Pick,y=Amount,fill=Amount))+
    geom_bar(stat="identity")+
    geom_text(aes(label=ifelse(Amount>1000|Amount==0,str_c(as.character(round(Amount/10000,2)),'%'),"<.1%")), vjust=-.2, color="black", size=2.8)+
    scale_x_continuous(breaks = round(seq(1, 32, by = 1),1),minor_breaks=NULL,limits=c(1,33))+
    labs(y="Amount",
         title = "Sim Results")
  
  g1 <- ggplot(data=subset(cdata2,Player==playerName),aes(x=Pick,y=Amount,fill=Amount))+
    geom_bar(stat="identity")+
    geom_text(aes(label=ifelse(Amount>=.1|Amount==0,str_c(as.character(round(Amount,1)),'%'),"<.1%")), vjust=-.2, color="black", size=2.8)+
    scale_x_continuous(breaks = round(seq(1, 32, by = 1),1),minor_breaks=NULL,limits=c(0,33))+
    labs(y="Percent", x="Pick# - Note 32 indicates: fell outside first round",
         title = str_c("Cumulative Probability ",playerName," still available at each pick"))+
    theme_minimal()
  
  #combine sickass graphs
  #on one plot:
  p1 <- gridExtra::grid.arrange(g0,g1,
                                top = str_c(playerName," Draft Sim Results"),
                                bottom = str_c('Average Pick: ',as.character(avgRank)),
                                nrow = 2)
  
  ggsave(str_c(playerName,'.png'),p1,"png",width = 30, height = 20, units = "cm",dpi=300)
}