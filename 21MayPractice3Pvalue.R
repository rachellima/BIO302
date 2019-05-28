##Using the file pvalue.html as a guide. 

library ("tidyverse", quietly = TRUE)
install.packages ("broom")
library ("broom")
install.packages("tidyverse")
set.seed(42)
x <- 1:20
y <- rnorm(20)

mod <- lm (y~x)

anova(mod)

summary (mod)

glance (mod)
tidy (mod)


#There is no effect of the predictor(x on the response (y. The p value says something about their relation, but if its random it will show our histogram. 

rerun(.n=1000, tibble (x = 1:20, y= rnorm (20))) %>% 
  map (~ lm(y~x, data = .)) %>% 
  map_df (glance) %>% 
ggplot (aes(x=p.value)) + geom_histogram()  


##Finding a small effect. So now you see there is an effect in the x of our data. this x * 0.068 it´s telling the data that there should be an effect of X on the Y. 

rerun(.n=1000, tibble (x = 1:20, y= rnorm (20, x * 0.06))) %>% 
  map (~ lm(y~x, data = .)) %>% 
  map_df (glance) %>% 
  ggplot (aes(x=p.value)) + geom_histogram()  
#with the 0.068 I am telling the response when the x affects the y. The less dependency, more like the first histogram, less probable that there is a connection. When I added 0.068 I am moving my pvalue towards 0 because there is a higher probability that there is an effect. 


##Effect of different sample sizes

set.seed(42)
x <- 1:5
y <- rnorm(5)

mod <- lm (y~x)

anova(mod)

summary (mod)

glance (mod)
tidy (mod)

##Even with the high effect size, the p value distribution remains linear, due to the small sample amount. 

rerun(.n=1000, tibble (x = 1:5, y= rnorm (5, x * 0.2))) %>% 
  map (~ lm(y~x, data = .)) %>% 
  map_df (glance) %>% 
  ggplot (aes(x=p.value)) + geom_histogram() 

#Under it is possible to see how the effect appears in a bigger sample size. 
rerun(.n=1000, tibble (x = 1:40, y= rnorm (40, x * 0.2))) %>% 
  map (~ lm(y~x, data = .)) %>% 
  map_df (glance) %>% 
  ggplot (aes(x=p.value)) + geom_histogram() 

