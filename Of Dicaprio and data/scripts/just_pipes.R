library(tidyverse)
library(ggtext)
library(ggimage)
library(sysfonts)
library(showtext)
library(ggbrace)
library(ggimage)

#import fonts
font_add_google("roboto", "roboto")
font_add_google("open sans", "open sans")
showtext_auto()

#create main dataframe 
df<-data.frame(
  year = 1999:2019,
  age_leo = 24:44,
  gf = c(
    rep("Gisele Bundchen",6),
    rep("Bar Refaeli",6),
    "Blake Lively",
    "Erin Heatherton",
    rep("Toni Garrn",2),
    "Kelly Rohrbach",
    rep("Nina Agdal",2),
    rep("Camila Morrone",6)
  ),
  age_gf = c(
    18:23,
    20:25, 
    23, 
    22, 
    20:21,
    25,
    24:25, 
    20:21
  )
)

#data for annotations about max age limit
max_points<-data.frame(x=c(2010, 2015, 2017), y=rep(25,3))

#data for year segments by girlfriend
by_gf<-df|>
  group_by(gf)|>
  summarise(min_year = min(year),
            max_year = max(year))

#data for images and respective positions on x axis
images<-data.frame(name=c("Leonardo DiCaprio", unique(df$gf)),
                   pos = seq(from=1999, to=2019, length.out = 9),
                   pal_label<-c("#FD7600", rep('#24C4C4',8)))|>
  mutate(path = paste0(str_replace_all(tolower(name)," ","_"),".png"))


#data frame for connector segments from images to years
connectors<-data.frame(
  x= c(2001.5,2004,2005.5,2006.5, 2006.5,2011,2009,2009,2012,2011.5,2013.5,2014,2015,2016.5,2019,2018.5),
  xend = c(2001.5, 2005.5,2005.5,2006.5,2011,2011,2009,2012,2012,2013.5,2013.5,2015,2015,2016.5,2018.5,2018.5),
  y= c(-10,-10,-10,-10,-6,-6,-10,-8,-8,-10,-10,-10,-10,-10,-10,-10),
  yend= c(-4,-10,-4,-6,-6,-4,-8,-8,-4,-10,-4,-10,-4,-4,-10,-4)
)


#data for images and respective positions on x axis
images<-data.frame(name=c("Leonardo DiCaprio", unique(df$gf)),
                   pos = seq(from=1999, to=2019, length.out = 9),
                   pal_label<-c("#FD7600", rep('#24C4C4',8)))|>
  mutate(path = paste0(str_replace_all(tolower(name)," ","_"),".png"))

#plot
ggplot(data=df, aes(x=year)) +
  
  # geom_brace(aes(c(4,7), c(4, 4.5),label="my label"),
  #            inherit.data=F,
  #            rotate = 180,
  #            color = "#24C4C4",
  #            labelsize=5) + 
 
  #x axis girlfriend groupings
  geom_segment(data=by_gf, mapping=aes(x=min_year, xend=max_year, y=-4, yend=-4), color='#24C4C4') +
  geom_segment(data=by_gf, mapping=aes(x=min_year, xend=min_year, y=-4, yend=-3), color='#24C4C4') +
  geom_segment(data=by_gf, mapping=aes(x=max_year, xend=max_year, y=-4, yend=-3), color='#24C4C4') +
  #segments to connect images to groupings
  geom_segment(data=connectors, mapping=aes(x=x,xend=xend,y=y,yend=yend),
               linejoin= "round",
              lineend = "round",
               color="#24C4C4") + 
    
    #segments to connect images to groupings
    geom_segment(data=images|>filter(name!="Leonardo DiCaprio"),
                 mapping=aes(x=pos, xend=pos, y=-13, yend=-10), color='#24C4C4')+
    geom_segment(data=connectors, mapping=aes(x=x,xend=xend,y=y,yend=yend), color='#24C4C4')+
    #plot images
    geom_image(data=images, mapping=aes(y=-14, x=pos, image=path), size=0.07)+
    geom_richtext(data=images, 
                  mapping=aes(y=-19.5, x=pos, color=pal_label, label=str_replace(name," ","<br>")),
                  fill = NA, label.color = NA, hjust=0.4,
                  show.legend = FALSE, fontface="bold")+
    scale_color_identity()


# Extras ------------------------------------------------------------------

scale_y_continuous(limits=c(-20,50), breaks=seq(from=0, to=50, by=5))

# checkout the comments and compile to readme

