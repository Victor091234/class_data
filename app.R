#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)


list_choices <-  unique(msleep$vore)[!is.na(unique(msleep$vore))]
names(list_choices) <- paste(unique(msleep$vore)[!is.na(unique(msleep$vore))],"vore",sep="")


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("This is my new Shinny app"),
   
  includeMarkdown("references.md"),
  h3("Plots"),
  
  
  selectInput("select", label = h3("Plot by type of alimentation"), 
              choices = list_choices,
              selected = 1),
  
  plotOutput(outputId = "plot")
      )
      
      # Show a plot of the generated distribution

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(msleep %>% filter(vore == input$select), aes(bodywt, sleep_total, colour = vore)) +
      scale_x_log10() +
      col_scale +
      geom_point()
    # cat(file=stderr(), "input$select:", input$select == "", "\n")
    if(input$select != ""){
      ggplot(msleep %>% filter(vore == input$select), aes(bodywt, sleep_total, colour = vore)) +
        scale_x_log10() +
        col_scale +
        geom_point()
    }
  })
}



# Run the application 
shinyApp(ui = ui, server = server)

