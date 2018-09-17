---
  title: "Titanic"
author: "Niket"
output: rmarkdown::github_document
---
  
***
  
  Titanic Dataset

***
  
  ```{r}
titanic <- read.csv('titanic3.csv', stringsAsFactors = FALSE, header = TRUE, na.strings = c("NA",""," ","."))
```

Why ‘stringsAsFactors = FALSE’? Character variables passed to data.frame are converted to factor columns unless protected by I or argument stringsAsFactors is false.

- We have to predict the fate of the passengers aboard the RMS Titanic, which famously sank in the Atlantic ocean during its maiden voyage from the UK to New York City after colliding with an iceberg.

- The disaster is famous for saving “women and children first”.

- With an inadequate number of lifeboats available only a fraction of the passengers survived,

```{r}
str(titanic) # str
```  


```{r}
table(titanic$survived) # table of survived people, 0 = Died, 1 = Survived
```


```{r}
prop.table(table(titanic$survived))
# Most people died in train set, so it should be same in the test set too
```

***
  
  ```{r}
titanic$survived <- factor(titanic$survived)
titanic$sex <- factor(titanic$sex)
titanic$pclass <- factor(titanic$pclass)
titanic$embarked <- factor(titanic$embarked)
```


```{r}
sapply(titanic, function(x){sum(is.na(x))})
```

Dropping columns which are not that relevant
```{r}
titanic$home.dest <- NULL
titanic$body <- NULL
titanic$boat <- NULL
titanic$cabin <- NULL
```

Looking at missing value in pclass
```{r}
which(is.na(titanic$pclass) == TRUE)
```

```{r}
titanic[1310,]
```

A blank row, let's drop it

```{r}
titanic <- titanic[-1310,]
```

***

Create LM models for predicting missing values in AGE and FARE
```{r}
age.mod <- lm(age ~ pclass + sex + sibsp + parch + fare, data = titanic)
fare.mod<- lm(fare ~ pclass + sex + sibsp + parch + age, data = titanic)
```

Replace missing values in AGE and FARE with prediction
```{r}
titanic$age[is.na(titanic$age)] <- predict(age.mod, titanic)[is.na(titanic$age)]
titanic$fare[is.na(titanic$fare)] <- predict(fare.mod, titanic)[is.na(titanic$fare)]
```

***

Replace missing values in embarked with most popular
```{r}
prop.table(table(titanic$embarked))
```

```{r}
table(titanic$pclass, titanic$embarked)
```

```{r}
titanic$embarked[is.na(titanic$embarked)] <- "S"
titanic$embarked <- factor(titanic$embarked)
```

***

Let's look at the titles of passengers
```{r}
titanic$title <- gsub('(.*, )|(\\..*)', '', titanic$name)
```

```{r}
table(titanic$sex, titanic$title)
```

Look for the female doctor
```{r}
titanic[titanic$sex == "female" & titanic$title == "Dr",]
```

Create “gender.name” variable
```{r}
library(stringr)
titanic$gender.name <- 0
```

```{r}
titanic$gender.name[!is.na(str_extract(titanic$name, "Capt"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Col"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Don"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Dona"))] <- "Mrs"
titanic$gender.name[!is.na(str_extract(titanic$name, "Dr"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Jonkheer"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Lady"))] <- "Mrs"
titanic$gender.name[!is.na(str_extract(titanic$name, "Major"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Master"))] <- "Mast"
titanic$gender.name[!is.na(str_extract(titanic$name, "Miss"))] <- "Miss"
titanic$gender.name[!is.na(str_extract(titanic$name, "Mlle"))] <- "Miss"
titanic$gender.name[!is.na(str_extract(titanic$name, "Mme"))] <- "Mrs"
titanic$gender.name[!is.na(str_extract(titanic$name, "Mr"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Mrs"))] <- "Mrs"
titanic$gender.name[!is.na(str_extract(titanic$name, "Ms"))] <- "Miss"
titanic$gender.name[!is.na(str_extract(titanic$name, "Rev"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "Sir"))] <- "Mr"
titanic$gender.name[!is.na(str_extract(titanic$name, "the Countess"))] <- "Mrs"
```

Change female doctor to Mrs
```{r}
titanic$gender.name[182] <- "Mrs"
```

```{r}
table(titanic$sex, titanic$gender.name)
```

```{r}
titanic$gender.name <- factor(titanic$gender.name)
```

***
  
  Are those who pay less than the average for a ticket less likely to survive? Mean fare for each pclass
```{r}
class1 <- subset(titanic, pclass == 1)
class2 <- subset(titanic, pclass == 2)
class3 <- subset(titanic, pclass == 3)
fare1 <- mean(class1$fare, na.rm = TRUE)
fare2 <- mean(class2$fare, na.rm = TRUE)
fare3 <- mean(class3$fare, na.rm = TRUE)
```

Create fare_avg column
```{r}
titanic$fare_avg[titanic$pclass == 1] <- fare1
titanic$fare_avg[titanic$pclass == 2] <- fare2
titanic$fare_avg[titanic$pclass == 3] <- fare3
```

Create fare-distance metric for titanic fare-distance = fare - mean(fare of pclass)
```{r}
titanic <- transform(titanic, fare.distance = fare - fare_avg)
titanic <- titanic[, !names(titanic) %in% c("fare_avg")]
```

Add family column
```{r}
titanic$family <- NA
titanic$family[which(titanic$sibsp != 0 | titanic$parch != 0)] <- 1
titanic$family[which(titanic$sibsp == 0 & titanic$parch == 0)] <- 0
```

```{r}
table(titanic$family)
```

```{r}
titanic$family <- as.factor(titanic$family)
```

Create a family size variable including the passenger themselves
```{r}
titanic$familia <- titanic$sibsp + titanic$parch + 1
```

***
  
  ```{r}
library(ggplot2)
```

```{r}
ggplot(titanic, aes(x = familia, fill = factor(survived))) +
  geom_bar(position = "fill", aes(alpha = .1)) +
  scale_x_continuous(breaks=c(1:11)) +
  labs(x = 'Family Size', y = 'Proportion Surviving')
```

***
  
  Scale the non factors
```{r}
titanic$age_scale <- (titanic$age - min(titanic$age))/(max(titanic$age - min(titanic$age)))
titanic$fare_scale <- (titanic$fare - min(titanic$fare))/(max(titanic$fare - min(titanic$fare)))
```

***
  ***
  
  Prediction

```{r}
set.seed(1234)
oneortwo <- sample(1:2 , length(titanic$survived), replace = TRUE, prob=c(0.68, 0.32)) # generating random values and storing them
```

```{r}
# create train data frame
train <- titanic[oneortwo == 1, ]

# create test data frame
test <- titanic[oneortwo == 2, ]
```

***
  
  Logistic Regression

Create probit with SEX, PCLASS, FARE, and AGE

```{r}
logit <- glm(survived ~ gender.name + pclass + age + fare + fare.distance, data = train,
             family = binomial(link = "logit"))
```

```{r}
logit_age <- glm(survived ~ gender.name + pclass + age + fare_scale + familia, data = train[!(is.na(train$age)), ],
                 family = binomial(link = "logit"))
```

```{r}
summary(logit)
```

```{r}
model <- 'glm(survived ~ gender.name + pclass + age + fare, data = train, family = binomial(link = "logit"))'
# save model as string
```

```{r}
my_model <- glm(survived ~ pclass + sex + age_scale + sibsp + parch + fare_scale + embarked + gender.name + fare.distance + family + familia, data = train, family = binomial(link = "logit"))
```

Make our prediction on the TRAIN data set
```{r}
survived_pred <- predict(logit, train, type = "response")

survived_pred[survived_pred >= 0.5] <- 1
survived_pred[survived_pred < 0.5] <- 0

survived_pred3 <- predict(my_model, train, type = "response")

survived_pred3[survived_pred3 >= 0.5] <- 1
survived_pred3[survived_pred3 < 0.5] <- 0

survived_pred2 <- predict(logit, test, type = "response")

survived_pred2[survived_pred2 >= 0.5] <- 1
survived_pred2[survived_pred2 < 0.5] <- 0

survived_pred3_2 <- predict(my_model, test, type = "response")

survived_pred3_2[survived_pred3_2 >= 0.5] <- 1
survived_pred3_2[survived_pred3_2 < 0.5] <- 0
```

```{r}
results <- data.frame(survived_pred2, test$survived)
results3 <- data.frame(survived_pred3_2, test$survived)
```

```{r}
require(caret)
```

```{r}
confusionMatrix(table(results))
```

```{r}
confusionMatrix(table(results3))
```

***
  
  Random Forest
```{r}
library(party)
library(randomForest)
library(rpart)
```

```{r}
set.seed(123)
fit1 <- cforest(survived ~ pclass + sex + age_scale + sibsp + parch + fare_scale + embarked + gender.name + fare.distance + family + familia, data = train, controls = cforest_unbiased(ntree = 200, mtry = 3)) # Conditional inference trees are able to handle factors with more levels than Random Forests can.

set.seed(123)
fit2 <- randomForest(survived ~ pclass + sex + age_scale + sibsp + parch + fare_scale + embarked + gender.name + fare.distance + family + familia, data=train, importance=TRUE, ntree= 70)

set.seed(123)
fit3 <- rpart(survived ~ pclass + sex + age_scale + sibsp + parch + fare_scale + embarked + gender.name + fare.distance + family + familia, data = train, method = "class")
```

```{r}
varImpPlot(fit2)
```

```{r}
# Show model error
plot(fit2, ylim = c(0,0.36))
legend('topright', colnames(fit2$err.rate), col=1:3, fill=1:3)
```


```{r}
# For better insights from above plot we get these packages.
library(rattle)
library(rpart.plot)
library(RColorBrewer)
```


```{r}
fancyRpartPlot(fit3) # This gives better plot
```

```{r}
prediction4 <- predict(fit2, test[-2], OOB = TRUE, type = "response")
results4 <- data.frame(prediction4, test$survived)
confusionMatrix(table(results4))
```

***
  ***