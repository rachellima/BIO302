library ("tidyverse")
#15May2ndPartClass Loading TidyVerse. Some conflicts appear, if you have more packages loaded there would appear more conflicts

#install the vegan package.

####pipes %>%ctrl-shift-m####
#Why do we use pipes? 
data (BCI, package="vegan") #I don´t have the package, so it will not retrieve the BCI dataset. 

x11() #this makes it open a new plot window

plot (
  sort(
    colSums(BCI), 
    decreasing = TRUE)) #ploting the colums decreasingly. Putting spaces so it is easy to read. 

x1 <- colSums (BCI) #I just transformed this in one object
x2 <- sort(x1, decreasing = TRUE) #this in another, so I just shortened lines 11-14 into line 19. 

plot (x2)

BCI %>%  colSums()      #Function to shorten what we just did up there. It will look exactly the same as 11-14 or 19, but in a more practical way

#if your cursor is inside the () you press TAB and all your arguments will appear. If you don´t use anything, it will use the first argument. 

BCI %>%
  colSums() %>%
  sort(decresaing = TRUE ) %>% #you just use sort () and it will be the other way
  plot ()


####One table functions ####

#Takes one dataframe
#select, filter, mutate, group_by, summarise, slice, count, arrange, nest
#we will use the iris data set

iris <- as_tibble(iris) #converted the iris into an object 
#what is a tibble? It will organize the iris data. It will print just the first 10 rolls.


#select function 
iris %>% select(Sepal.Length, Species) #No quote marks required. You are selecting the columns to be shown with this command. 
select(iris, Sepal.Length, Species) #it is the same thing as the line 41, but pipes can make your code cleaner. 

iris %>% select(-Sepal.Width) #it will stop using this column 

iris %>% select (Sepal.Length:Petal.Length) #It will take information from Column 'sepal.length' to column 'petal.length'. If those are start column to end column, it will take everything in between.


#rename function

iris %>% rename (sepal.length = Sepal.Length, spp = Species) #the first thing in () is the new name, after the = is the old name. The only rule is that they have to be legal names. 


# Filter things out 

iris %>% filter(Sepal.Length > 5, Petal.Length < 2) %>% #now it filtered out <5 and >2, and now we have only 20 rows. 
select(Species) #shows a table with the species that present the reason behind my filter

iris %>% filter(Sepal.Length >5, Petal.Length <2) %>%  select (Species, Sepal.Length, Petal.Length) #now I filtered considering the numbers, and selected the species AND the columns showing the values I wanted.

iris [iris$Sepal.Length > 5 & iris$Petal.Length < 2, "Species"] #same thing from lines 58, 59 without pipes. 


#Mutate - it will change. We can make a new column or change an existing column. 

iris %>% mutate (petal.area = Petal.Length * Petal.Width) #I created a new column using two existing columns. 

iris %>% mutate (Species = toupper(Species)) #Now I made all names in capital case. 

#Remember: none of those changes are permanent. To make a change permanent I would have to iris <- iris %>% mutate (blablabla)



iris %>%  group_by(Species) %>% 
  summarise (mean_petal_length = mean (Petal.Length), sd_petal_length = sd (Petal.Length))
#You can add whatever you want in this summary.I am telling it to group by species with the mean of petal length column and the standart deviation from petal length. 

iris %>%  group_by(Species) %>% 
  summarise (mean (Petal.Length), sd (Petal.Length)) #it is completely the same but this one you didn´t really name, so the tables will just appear with the formula as the title for the columns. 

iris %>%  group_by (Species) %>% 
  mutate (mean_petal_length = mean (Petal.Length)) #it will create a mean for each species, not overall mean. So I can compare the Petal Length of one measurement with the overall mean for the species. 


