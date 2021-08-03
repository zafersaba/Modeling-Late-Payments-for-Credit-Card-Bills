
  # install packages if you do not have them:

  # install.packages("gbm")
  # install.packages("AUC")

  library(gbm)
  library(AUC)
  
  #percentage of training data
  K=0.9
  
  for (target in 1:3) {
    X_train <- read.csv(sprintf("hw07_target%d_training_data.csv", target), header = TRUE)
    Y_train <- read.csv(sprintf("hw07_target%d_training_label.csv", target), header = TRUE)
    X_test <- read.csv(sprintf("hw07_target%d_test_data.csv", target), header = TRUE)
    set.seed(421)
    
    #shuffle the rows
    rows <- sample(nrow(X_train))
    
    #shuffled X_train and x_validation
    shuffled_X_train <- (X_train[rows,])[1:(K*nrow(X_train)),]
    X_validation <-  (X_train[rows,])[(K*nrow(X_train)+1):(nrow(X_train)),]
   
    #shuffled y_train and y_validation
    shuffled_Y_train <- (Y_train[rows,])[1:(K*nrow(Y_train)),]
    Y_validation <-  (Y_train[rows,])[(K*nrow(Y_train)+1):(nrow(Y_train)),]
    
    #shuffled training data
    TARGET <- shuffled_Y_train[,"TARGET"]
    shuffled_train_data <- cbind(shuffled_X_train, TARGET)
    
    
    gbm_model <- gbm(TARGET ~ . ,data = shuffled_train_data[, -1], distribution = "adaboost", n.trees = 400, shrinkage = 0.1, interaction.depth = 3)
    
    gbm_scores_train <- predict(gbm_model, shuffled_X_train, n.trees = 400, type = "response")
    print(auc(roc(predictions = gbm_scores_train, labels = as.factor(shuffled_Y_train[, "TARGET"]))))

    gbm_scores_validation <- predict(gbm_model, X_validation, n.trees = 400, type = "response")
    print(auc(roc(predictions = gbm_scores_validation, labels = as.factor(Y_validation[, "TARGET"]))))
    
    test_scores <- predict(gbm_model, X_test, n.trees = 400, type = "response")
    write.table(cbind(ID = X_test[,"ID"], TARGET = test_scores), file = sprintf("hw07_target%d_test_predictions.csv", target), row.names = FALSE, sep = ",") 
  
  }
  
