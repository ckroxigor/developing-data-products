
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("UCI Wine dataset analysis"),
  HTML("
<p>This Shiny application has been developed as a practical exercise for the <a href='https://www.coursera.org/learn/data-products/'>'Developing Data Products' Coursera course.</a></p>

<p>
This is a basic visor of the <a href='https://archive.ics.uci.edu/ml/datasets/Wine'>Wine Data Set from the UCI Machine Learning Reposity</a>. As explained in the official webpage: 
<b>
These data are the results of a chemical analysis of wines grown in the same region in Italy but derived from three different cultivars. 
The analysis determined the quantities of 13 constituents found in each of the three types of wines. </b> These constituents are:
</p>
<ol>
<li>Alcohol</li>
<li>Malic acid</li>
<li>Ash</li>
<li>Alcalinity of ash</li>
<li>Magnesium</li>
<li>Total phenols</li>
<li>Flavanoids</li>
<li>Nonflavanoid phenols</li>
<li>Proanthocyanins</li>
<li>Color intensity</li>
<li>Hue</li>
<li>OD280/OD315 of diluted wines</li>
<li>Proline</li>
</ol>
<p>
The interface provided allows to compare three different approaches for grouping the three kinds of cultivars.
</p>"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      radioButtons("algorithm", 
                   "Select an algorithm:",
                   c("K-means", "Linear Discriminant Analysis", "Hierarchical clustering"),
                   "K-means")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      HTML("<h1>Resulting model</h1>"),
      plotOutput("distPlot"),
      HTML("<h2>Confusion matrix obtained using this model:</h2>"),
      tableOutput("confusionMatrix"),
      HTML("<p>The left hand side of the matrix displays the actual type of the wine whereas the columns shows the type assigned using the model. <a href='https://en.wikipedia.org/wiki/Confusion_matrix'>Wikipedia article about Confusion Matrix</a></p>")
    )
  )
))
