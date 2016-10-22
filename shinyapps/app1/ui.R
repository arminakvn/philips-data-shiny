library(shiny)

# Define UI for application that draws a histogram
# fluidPage(

#   # Application title
#   titlePanel("Shiny app template "),
#   sidebarPanel(
#  # dateRangeInput("daterange1", "Date range:",
#  #                 start = "2016-08-24 0:00:00",
#  #                 end   = "2016-08-24 23:59:00")
#   sliderInput("slider_datetime", "Date & Time:", 
#             min=as.POSIXlt("2016-08-24 6:00:00", "GMT"),
#             max=as.POSIXlt("2016-08-25 7:00:00", "GMT"),
#             value=c(as.POSIXlt("2016-08-24 10:00:00", "GMT"),as.POSIXlt("2016-08-24 12:00:00", "GMT")),
#             timezone = "GMT")
#  ),
#   # Sidebar with a slider input for the number of bins
#   # sidebarLayout(
#     # sidebarPanel(
#     #   sliderInput("bins",
#     #               "Number of bins:",
#     #               min = 1,
#     #               max = 50,
#     #               value = 30)
#     # ),

#     # # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("distPlot")
#     # )
#   # )
# )
#     )
shinyUI(fluidPage(theme = shinytheme("cerulean"),
  
  verticalLayout(
    # titlePanel("Vertical layout example"),
    wellPanel(
      sliderInput("slider_datetime", "Date & Time:", 
            min=as.POSIXlt("2016-08-24 6:00:00", "GMT"),
            max=as.POSIXlt("2016-08-25 7:00:00", "GMT"),
            value=c(as.POSIXlt("2016-08-24 10:00:00", "GMT"),as.POSIXlt("2016-08-24 12:00:00", "GMT")),
            timezone = "GMT")
    )
  ),
  plotOutput("distPlot")
))