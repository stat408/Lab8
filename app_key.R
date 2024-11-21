## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Lab 8: Loops + Shiny"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Lab Overview", tabName = "home", icon = icon("house")),
      menuItem("Question 1", tabName = "q1"),
      menuItem("Question 2", tabName = "q2"),
      menuItem("Question 3", tabName = "q3")
    )
  ),
  dashboardBody(
    tabItems(
      ################################################################################
      # home
      ################################################################################
      tabItem(tabName = "home",
        fluidRow(
          box(title = "Lab Overview",
              "This lab will combine loops / simulation with the use of the shinydashboard package.",
              width = 12
              )
          ),
        fluidRow(                              
                box(
                  title = "Question 1 (5 points)",
                  "1.  Derive and display the probability of landing on green, red, and black.",
                  width = 12
                )
              ),
        fluidRow(                              
          box(
            title = "Question 2 (5 points)",
            "2. Use the RouletteSpin() to simulate the probabilities of landing on green, red, and black.",
            width = 12
          )
        ),
        fluidRow(                              
          box(
            title = "Question 3 (10 points)",
            "3. Cosmic Pizza: assuming all letters are equally probable simulate the probability you can spell cosmic after purchasing 10 pizzas",
            width = 12
          )
        )
        
      ),
      ################################################################################
      # q1
      ################################################################################
      tabItem(tabName = "q1",
              fluidRow(                              
                box(
                  title = "Question 1 (5 points)", background = "purple",
                  "Derive and display the probability of landing on green, red, and black.",
                  br(), 
                  "Create a static figure to display these probabilities",
                  width = 12
                )
              ),
              fluidRow(
                box(title = "Probabilities of rolling each color:",
                    plotOutput("q1"), width = 12)
                )
      ),
      ################################################################################
      # q2
      ################################################################################
      tabItem(tabName = "q2",
              fluidRow(                              
                box(
                  title = "Question 2 (5 points)", background = "black",
                  "Use the RouletteSpin() to simulate the probabilities of landing on green, red, and black.",
                  br(), 
                  "Hint: the RouletteSpin() function is defined in the server code",
                  br(),
                  "Add a numeric input to adjust how many spins you complete",
                  br(),
                  "Display the results with a dynamic figure that updates when you change the numeric input",
                  width = 12
                )
              ),
              fluidRow(
                box(title = "Probabilities of rolling each color:",
                    plotOutput("q2"), width = 12)
              ),
              fluidRow(
                box(title = "Select the number of roulette spins:",
                    numericInput(inputId = 'spins', lab = '# of spins',
                                 min = 10, max = 10000, value = 100)
                    )
                )
              ),
      ################################################################################
      # q3
      ################################################################################
      tabItem(tabName = "q3",
              fluidRow(                              
                box(
                  title = "Question 3 (10 points)", background = "blue",
                  "Cosmic Pizza: assuming all letters are equally probable simulate whether you can spell cosmic after purchasing 10 pizzas",
                  br(), 
                  "Hint: the Buy10Pizzas() function is defined in the server code",
                  br(),
                  "use DT::dataTableOutput() to show the outcome of the 10 pizzas",
                  width = 12
                )
              ),
              fluidRow(
                box(title = "Pizza letters:",
                    DT::dataTableOutput("pizzatable"), width = 12)
              ),
              fluidRow(
                box(title = 'Try again and buy 10 pizzas',
                    actionButton("buy", "Buy 10 more pizzas", class = "btn-success")
              )
              )
      )
      ################################################################################
      
  )
)
)

server <- function(input, output) {
  library(tidyverse)
  RouletteSpin <- function(num.spins){
    # function to simulate roulette spins
    # ARGS: number of spins
    # RETURNS: result of each spin
    outcomes <- tibble(number = c('00','0',
                                  as.character(1:36)),
                       color=c('green','green','red','black','red','black',
                               'red','black','red','black','red','black',
                               'black','red','black','red','black',
                               'red','black','red','red','black',
                               'red','black','red','black','red',
                               'black','red','black','black','red',
                               'black','red','black','red','black','red'))
    return(outcomes[sample(38,num.spins,replace=T),])
  }

  Buy10Pizzas <- function(){
    # function to simulate roulette spins
    # ARGS:
    # RETURNS: letter from Cosmic
    return(sample(c("C","O","S","M","I"), 10, replace = T))
  }
  
  output$q1 <- renderPlot({
    tibble(color = c('red','black','green'),
           prob = c(16/38, 16/38, 2/38)) |>
      ggplot(aes(y = prob, x = color, fill = color)) +
      geom_bar(stat = "identity") +
      theme_bw() +
      theme(legend.position = 'none') 
  })
  
  output$q2 <- renderPlot({
    RouletteSpin(input$spins) |>
      count(color) |>
      mutate(prob = n / sum(n)) |>
      ggplot(aes(y = prob, x = color, fill = color)) +
      geom_bar(stat = "identity") +
      theme_bw() +
      theme(legend.position = 'none') |>
      labs(caption = paste("Based on ", input$spins, " spins"), sep = '') +
      geom_hline(yintercept = 18/38) +
      geom_hline(yintercept = 2/38)
  })
  
  
  output$pizzatable <- DT::renderDataTable({
    input$buy
    pizzas <- tibble(`pizza #` = 1:10,
                     letters = Buy10Pizzas())
    pizzas})
}

shinyApp(ui, server)