library(shiny)
  # install.packages("ggthemes")
    # install.packages("lubridate")
    # install.packages("gstat")
    # install.packages("sp")
    # install.packages("maptools")
    # install.packages("ggmap")
    library(ggthemes)
    library(lubridate)
    library(gstat)
    library(sp)
    library(maptools)
    library(ggmap)
# =========== init / plot ============
  theme_set(theme_solarized(light=F)+ theme(panel.background=element_rect(size=0), strip.background=element_rect(fill="transparent", size = 0), strip.text=element_text(colour="#586e75")))
  scale_colour_discrete <- function(...) scale_color_solarized()
  scale_fill_discrete <- function(...) scale_color_solarized()

  start = ymd_hms("2016-08-24 0:00:00", tz = "America/Los_Angeles")
  end = ymd_hms("2016-08-24 23:59:00", tz = "America/Los_Angeles")
  setint <- function(sub, start, end) {sub <- sub[sub$time >=start & sub$time <=end,]; return(sub)} 

  prep <- function(sub,start,end) {
    sub <- setint(sub,start,end)
    sub$lat <- cut(sub$Latitude, lats)
    sub$lng <- cut(sub$Longitude, lons)
    return(sub)
  }


  lons <- c(-118.289444,
            -118.2891023,
            -118.2885641,
            -118.2881616,
            -118.2876,
            -118.2871086,
            -118.2869588,
            -118.2864767)
  lats <- c(34.0927221,
            34.09242256,
            34.09192646,
            34.09141631,
            34.09103253,
            34.090733,
            34.09046154,
            34.09006372,
            34.08961442,
            34.08903407,
            34.08871114,
            34.09288122)

  ro <- c(
    '(34.0907,34.091]'  = 'Santa Monica',
    '(34.091,34.0914]'  = '',
    '(34.0887,34.089]'  = 'Lockwood',
    '(34.0896,34.0901]' = 'Willow Brooks',
    '(34.0919,34.0924]' = '',
    '(34.0924,34.0927]' = '',
    '(34.0914,34.0919]' = '',
    '(34.0927,34.0929]' = '',
    '(34.0905,34.0907]' = '',
    '(34.0901,34.0905]' = '')

  co <- c(
    '(-118.2882,-118.2876]' = 'N Westmoreland',
    '(-118.2871,-118.287]'  = '',
    '(-118.2894,-118.2891]' = 'N Madison',
    '(-118.2876,-118.2871]' = '',
    '(-118.287,-118.2865]'  = 'N Virgil',
    '(-118.2891,-118.2886]' = '',
    '(-118.2886,-118.2882]' = '')

    # /home/philips-data-shiny/shinyapps/app1/
    load("dat0825.rdata")
    dat <- dat[!(substr(dat$DeviceId, 1, 3)  %in% c("+n+","79c","fWP", "Uoo", "bNZ", "guS", "Kac", "Ixi", "J7R", "UL4", "VZf", "GKU")),] 
    start = ymd_hms("2016-08-24 6:00:00", tz = "America/Los_Angeles")
    end = ymd_hms("2016-08-24 7:00:00", tz = "America/Los_Angeles")

    sub <- prep(dat[dat$component %in% c("Lmindba", "Leqdba", "Lmaxdba"),], start, end); scl <-  scale_color_manual(values=c("#bd0026", "#ffffb2", "#fd8d3c"))



    
# Define server logic required to draw a histogram
function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot

    #dat <- dat[substr(dat$DeviceId, 1, 3)=="r8+" & dat$db>0,]
sliderValues <- reactive({
  data.frame(
    Name = c("Time Range"),
    Value = as.character(c(input$slider_datetime)),
    stringsAsFactors=FALSE
    )
  }) 
selectValues <- reactive({
  if(input$types == "Lmindba...") {
    data.frame(
    Name = c("Type Value"),
    Value = c("Lmindba", "Leqdba", "Lmaxdba")
    # stringsAsFactors=FALSE
    )
  } else {
    data.frame(
    Name = c("Type Value"),
    Value = c("Base", "Voice", "High"),
    stringsAsFactors=FALSE
    )
  }
  # print(input$types)
  
  })


  
 output$distPlot <- renderPlot({
     #mainPanel(
     print(sliderValues()[1,"Value"])
     print(selectValues()[,"Value"])
#       # with(sub, reorder(sub$DeviceId,sub$time))
      sub <- prep(dat[dat$component %in% selectValues()[,"Value"],],ymd_hms(sliderValues()[1, "Value"],tz = "America/Los_Angeles"),ymd_hms(sliderValues()[2, "Value"],tz = "America/Los_Angeles")); scl <-  scale_color_manual(values=c("#bd0026", "#ffffb2", "#fd8d3c"))
      q <- ggplot(data= sub, aes(x=time,y=db, color=component)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))+ facet_grid(lat~lng, as.table = F, labeller=labeller(lat=ro,lng=co)) + scl + geom_point(size=0.5,alpha=0.3)

      #hist(sub$Latitude)
      print(q)
      # )

    
   },height=700)

}