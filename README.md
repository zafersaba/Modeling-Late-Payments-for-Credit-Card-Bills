# Modeling Late Payments for Credit Card Bills

The aim of this project is to predict whether a customer will delay his/her credit card bill payment more than 1 day (named as target1), more than 31 days (named as target2), or more than 61 days (named as target3) using the information given about each customer.

After trying many different algorithms, I decided to use Gradient Boosting Machine (GBM) since it had the best results for the validation set. 

After deciding the algorithm, I had to decide on the following things:

**K:** Percentage of training data in the dataset

**distribution:** This is the distribution of class labels. In this case they are 0 or 1. So, I tried bernouilli, huberized and adaboost. Adaboost performed the best

**n.trees:** This is the number of trees to fit. I tried many different options and decided to use 400 since values higher than this was increasing the computational complexity and values under this did not perform well.

**shrinkage:** This is the step size. 0.01 performed best among my trials.

**interaction depth:** This is the maximum depth of each tree. When I tried values higher than 3, it was overfitting and values under 3 was underfitting.

When deciding on these factors, I used the “one factor at a time” approach because I did not have enough computational power to implement a Factorial design, which would  give a more accurate result. 
