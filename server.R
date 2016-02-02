
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rpart)
library(cluster)
library(MASS)

#load datas
data <- read.csv("./data/wine.csv")
data$Class <- as.factor(data$Class)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    if (input$algorithm == "K-means") {
      fit <- kmeans(as.matrix(data[,-1]), 3)
      return(
        clusplot(data, fit$cluster, color=TRUE, shade=F, labels=1, lines=0)
      )
    }
    else if (input$algorithm == "Linear Discriminant Analysis") {
      return(
        plot(lda(Class~.,data), main="Linear Discriminant Analysis", xlab="First principal axis", ylab="Second principal axis", col=as.numeric(data$Class))
      )
    }
    else if (input$algorithm == "Hierarchical clustering") {
      d <- dist(data[,-1], method = "euclidean")
      fit <- hclust(d, method="ward")
      return(
        plot(fit)
      )
    }
  })
  
  output$confusionMatrix <- renderTable({
    if (input$algorithm == "K-means") {
      fit <- kmeans(as.matrix(data[,-1]), 3)
      return(
        table(data.frame(cbind(data$Class,fit$cluster)))
      )
    }
    else if (input$algorithm == "Linear Discriminant Analysis") {
      fit <- lda(Class~.,data)
      return(
        table(data.frame(cbind(data$Class,predict(fit, data[,-1])$class)))
      )
    }
    else if (input$algorithm == "Hierarchical clustering") {
      d <- dist(data[,-1], method = "euclidean")
      fit <- hclust(d, method="ward")
      groups <- cutree(fit, k=3)
      return(
        table(data.frame(cbind(data$Class,groups)))
      )
    }
  })

})
