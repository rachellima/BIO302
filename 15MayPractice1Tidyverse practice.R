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


iris %>%  group_by(Species) %>% 
  mutate (mean_petal_lengtj = mean (Petal.Length)) %>% 
  ungroup() #remove the group structure. Sometimes you grouped your data for one analysis but you don´t want anymore, so you should ungroup the data frame. It is a tibble with no groups.The group we are removing is the species, in this case. 



iris %>%  arrange (Petal.Length) #arranging by petal length
iris %>%  arrange (desc(Petal.Length))# arranging by petal length from the higher values.

iris %>% group_by(Species) %>%  arrange(Petal.Length)  #it will arrange by species and petal length
  
iris %>% group_by(Species) %>%  arrange(Petal.Length) %>%  slice (1:3) #it will show now the top three for each of the species. In this case it will give the top 3, but it could be the top 4 (1:4). 

iris %>%  group_by(Species) %>%  arrange (desc(Petal.Length)) %>% slice (1:3) #not it is the same but I get the higherst Petal Length per species.

iris %>%  group_by(Species) %>% nest() #took all the data for each species and created it´s on tibble, or groups based in Species. It is a powerful technique. 

iris %>% 
  group_by(Species) %>% 
  nest() %>%  
  mutate(mod = map(data, ~lm(Sepal.Length ~ Sepal.Width, data =. )))
#mod stands for creating a model, a map that uses data and the function lm (linear model) that describes the relationship between Sepal.Length and Sepal.Width).

iris %>% 
  group_by(Species) %>% #we took all diferent species
  nest() %>%  #we grouped our data by species
  mutate(mod = map(data, ~lm(Sepal.Length ~ Sepal.Width, data =. ))) %>% #this map took each of this tibbles with this data, 50 rows of 4 colums. So it fits all the data in one of the species. One model for each species
  mutate(coef = map(mod, broom::tidy)) %>% #It pulls the coefficient out of the model 
  unnest (coef) 
#In the end, for each species we will get the data. 


####reshaping data####

#make tidy data

#gather, spread
iris #there is one column for each variable in this dataset. Sometimes this is fine, sometimes it is not an useful structure. Many times in tidyverse, it expects the tidydata organization. 

iris %>%
  rownames_to_column()
#it creates a column of row names, in this case, numeral. 

iris %>%  
  rownames_to_column() %>% 
  gather(key = variable, value = measurement, -Species, -rowname ) #it will put the column names into one column and the data into another colum. Key is the colum name. That will take all column names and the data into the colum measurement, and I will exclude two colums, Species and Rowname; so I will have the colums Rowname, Species, Variable and Measurement.
#Now I changed how my data looks like: I have 4 columns and 600 rows.


iris %>%  
  rownames_to_column() %>% 
  gather(key = variable, value = measurement, -Species, -rowname ) %>% 
  group_by(Species, variable) %>% 
  summarise(mean = mean (measurement)) #made the data into a thin format and used a mean per variable and per species into a new column

x11() #make it into a new window
iris %>% 
  rownames_to_column() %>% 
  gather (key = variable, value = measurement, -Species, -rowname) %>% 
  ggplot (aes(x=variable, y=measurement, fill=Species)) + geom_violin()
#now I plotted it all. 


####two table function#### 
#I lost it!
#left_join
#full_join
#semi_join
#anti_join

####n table functions### 
#you have to tables and will put tem in top of eachother with bind_rows
#you have to tables and it will put them side by side with bind_cols
#the crossing function wont will be used.

