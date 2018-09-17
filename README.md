Titanic
================
Niket

------------------------------------------------------------------------

Titanic Dataset

------------------------------------------------------------------------
-   We have to predict the fate of the passengers aboard the RMS Titanic, which famously sank in the Atlantic ocean during its maiden voyage from the UK to New York City after colliding with an iceberg.

-   The disaster is famous for saving “women and children first”.

-   With an inadequate number of lifeboats available only a fraction of the passengers survived,

``` r
table(titanic$survived) # table of survived people, 0 = Died, 1 = Survived
```

    ## 
    ##   0   1 
    ## 809 500

``` r
prop.table(table(titanic$survived))
```

    ## 
    ##        0        1 
    ## 0.618029 0.381971


------------------------------------------------------------------------

Create LM models for predicting missing values in AGE and FARE

``` r
age.mod <- lm(age ~ pclass + sex + sibsp + parch + fare, data = titanic)
fare.mod<- lm(fare ~ pclass + sex + sibsp + parch + age, data = titanic)
```

Replace missing values in AGE and FARE with prediction

``` r
titanic$age[is.na(titanic$age)] <- predict(age.mod, titanic)[is.na(titanic$age)]
titanic$fare[is.na(titanic$fare)] <- predict(fare.mod, titanic)[is.na(titanic$fare)]
```

------------------------------------------------------------------------

``` r
library(ggplot2)
```

``` r
ggplot(titanic, aes(x = familia, fill = factor(survived))) +
  geom_bar(position = "fill", aes(alpha = .1)) +
  scale_x_continuous(breaks=c(1:11)) +
  labs(x = 'Family Size', y = 'Proportion Surviving')
```

![](Titanic_files/figure-markdown_github/unnamed-chunk-32-1.png)

------------------------------------------------------------------------

Prediction

------------------------------------------------------------------------

Logistic Regression


    ## Confusion Matrix and Statistics
    ## 
    ##               test.survived
    ## survived_pred2   0   1
    ##              0 221  51
    ##              1  31 105
    ##                                           
    ##                Accuracy : 0.799           
    ##                  95% CI : (0.7568, 0.8368)
    ##     No Information Rate : 0.6176          
    ##     P-Value [Acc > NIR] : 2.323e-15       
    ##                                           
    ##                   Kappa : 0.5638          
    ##  Mcnemar's Test P-Value : 0.03589         
    ##                                           
    ##             Sensitivity : 0.8770          
    ##             Specificity : 0.6731          
    ##          Pos Pred Value : 0.8125          
    ##          Neg Pred Value : 0.7721          
    ##              Prevalence : 0.6176          
    ##          Detection Rate : 0.5417          
    ##    Detection Prevalence : 0.6667          
    ##       Balanced Accuracy : 0.7750          
    ##                                           
    ##        'Positive' Class : 0               
    ## 


    ## Confusion Matrix and Statistics
    ## 
    ##                 test.survived
    ## survived_pred3_2   0   1
    ##                0 217  42
    ##                1  35 114
    ##                                           
    ##                Accuracy : 0.8113          
    ##                  95% CI : (0.7699, 0.8481)
    ##     No Information Rate : 0.6176          
    ##     P-Value [Acc > NIR] : <2e-16          
    ##                                           
    ##                   Kappa : 0.597           
    ##  Mcnemar's Test P-Value : 0.4941          
    ##                                           
    ##             Sensitivity : 0.8611          
    ##             Specificity : 0.7308          
    ##          Pos Pred Value : 0.8378          
    ##          Neg Pred Value : 0.7651          
    ##              Prevalence : 0.6176          
    ##          Detection Rate : 0.5319          
    ##    Detection Prevalence : 0.6348          
    ##       Balanced Accuracy : 0.7959          
    ##                                           
    ##        'Positive' Class : 0               
    ## 

------------------------------------------------------------------------

Random Forest

![](Titanic_files/figure-markdown_github/unnamed-chunk-49-1.png)

![](Titanic_files/figure-markdown_github/unnamed-chunk-51-1.png)

    ## Confusion Matrix and Statistics
    ## 
    ##            test.survived
    ## prediction4   0   1
    ##           0 218  54
    ##           1  34 102
    ##                                           
    ##                Accuracy : 0.7843          
    ##                  95% CI : (0.7412, 0.8233)
    ##     No Information Rate : 0.6176          
    ##     P-Value [Acc > NIR] : 4.092e-13       
    ##                                           
    ##                   Kappa : 0.5319          
    ##  Mcnemar's Test P-Value : 0.04283         
    ##                                           
    ##             Sensitivity : 0.8651          
    ##             Specificity : 0.6538          
    ##          Pos Pred Value : 0.8015          
    ##          Neg Pred Value : 0.7500          
    ##              Prevalence : 0.6176          
    ##          Detection Rate : 0.5343          
    ##    Detection Prevalence : 0.6667          
    ##       Balanced Accuracy : 0.7595          
    ##                                           
    ##        'Positive' Class : 0               
    ## 

------------------------------------------------------------------------

------------------------------------------------------------------------
