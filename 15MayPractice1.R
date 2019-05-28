library ("tidyverse")
#15May2ndPartClass Loading TidyVerse. Some conflicts appear, if you have more packages loaded there would appear more conflicts


####pipes %>%ctrl-shift-m####
#Why do we use pipes? 
data (BCI, package="vegan") #I don´t have the package, so it will not retrieve the BCI dataset. 

x11() #this makes it open a new plot window

plot (
  sort(
    colSUM(BCI), 
    decreasing = TRUE)) #ploting the colums decreasingly. Putting spaces so it is easy to read. 

x1 <- colSums (BCI) #I just transformed this in one object
x2 <- sort(x1, decreasing = TRUE) #this in another, so I just shortened lines 11-14 into line 19. 

plot (x2)