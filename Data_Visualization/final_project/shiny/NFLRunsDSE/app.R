#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(gridExtra)
require(grImport2)
require(grConvert)
require(gridSVG)
require(teamcolors)
require(stringr)
require(grid)

# Read CSV
r_csv2 <- function(X.file_path) {
    read.csv(file = X.file_path,header = TRUE,sep = ",",stringsAsFactors = FALSE)
}

### NFL DATA ###
nfl_runs <- r_csv2("./rushers_lines.csv") # Read in Rushes CSV from Python Output
nfl_runs <- nfl_runs %>% filter(Position%in%c('RB','HB')) %>%
    mutate(speed_mph = round((S*60^2)/1760,1),acc_mph = round((A*60^2)/1760,1))# only care about RB/HB, translate speed and acc to MPH
teams <- nfl_runs %>% select(PossessionTeam) %>% unique() %>% arrange(PossessionTeam) %>% pull() # Get team list, alpha sort
nfl_teamcolors <- teamcolors %>% filter(league == "nfl") # Get team colors package
nfl_teamcolors <- nfl_teamcolors[c(1:16,18,17,19:27,29,28,30:nrow(nfl_teamcolors)),] # Re-Order to match team list
# Combine teams and team colors
teams <- cbind(teams,nfl_teamcolors)

# VIEWS/FILTERS:
cuts <- c("Season","Down") # Add direction later
formations <- nfl_runs %>% select(OffenseFormation) %>% unique() %>% arrange(OffenseFormation) %>% pull()
defenders_in_box <- c(1:11)
metrics <- c("Acceleration","Speed","Yards")
calc <- c("Average","Max","Total")

ui <- dashboardPage(skin = "green",
    dashboardHeader(title = "Analyzing the NFL Running Back",titleWidth = 300),
    dashboardSidebar(),
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "Team Summary",
                    fluidRow(
                        box(
                            title = "Select a Cut",
                            selectInput("cut","Select Cut:",choices = cuts,selected = "Season")
                            ),
                        box(
                            title = "Add a Filter",
                            selectInput("formation","Formation",choices = c("All",formations),selected = "All"),
                            sliderInput("defenders","Def. in Box",1,11,7)
                        )
                    ),
                    fluidRow(
                        box(title = "Analyzing Different Teams",plotOutput(outputId = "SummaryPlot", height = 250))
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    h2("Widgets tab content")
            )
        )
    )
)

server <- function(input, output) {
    
    data <- reactive({
        nfl_runs %>% select(PossessionTeam,speed_mph,acc_mph,OffenseFormation,Down,DefendersInTheBox,Yards) %>% 
            filter(DefendersInTheBox==input$defenders)
    })
    
    
    output$SummaryPlot <- renderPlot({
        if(input$metric=='Yards'){
            if (input$calc == "Average"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = mean(Yards)) %>%
                    left_join(.,teams,by="PossessionTeam")
            }
            else if(input$calc=="Total"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = sum(Yards)) %>%
                    left_join(.,teams,by="PossessionTeam")
                
            }
            else if(input$calc=="Max"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = max(Yards)) %>%
                    left_join(.,teams,by="PossessionTeam")
                
            }
            else{
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = n()) %>%
                    left_join(.,teams,by="PossessionTeam")
            }
            
            ggplot(data, aes_string(x = reorder("PossessionTeam",metric), y = metric, fill=primary)) + geom_bar(stat="identity") + scale_fill_identity() + xlab("Team") + 
                ylab(paste0(input$calc,ifelse(str_length(input$calc)>0," Yards","Rushes"))) +
                theme(
                    panel.background = element_rect(fill = "transparent"), # bg of the panel
                    plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
                    panel.grid.major = element_blank(), # get rid of major grid
                    panel.grid.minor = element_blank(), # get rid of minor grid
                    legend.background = element_rect(fill = "transparent"), # get rid of legend bg
                    legend.box.background = element_rect(fill = "transparent")) + xlab("Team") + ylab("Rushes")
            
            
        }
        
        else if(input$metic=='Acceleration'){
            if (input$calc == "Average"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = mean(acc_mph)) %>%
                    left_join(.,teams,by="PossessionTeam")
            }
            else if(input$calc=="Total"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = n()) %>%
                    left_join(.,teams,by="PossessionTeam")
                
            }
            else if(input$calc=="Max"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = max(acc_mph)) %>%
                    left_join(.,teams,by="PossessionTeam")
                
            }
            else{
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = n()) %>%
                    left_join(.,teams,by="PossessionTeam")
            }
            
            ggplot(data, aes_string(x = reorder("PossessionTeam",-metric), y = metric, fill=primary)) + geom_bar(stat="identity") + scale_fill_identity() + xlab("Team") + 
                ylab(paste0(input$calc,ifelse(str_length(input$calc)>0," Acceleration","Rushes"))) +
                theme(
                    panel.background = element_rect(fill = "transparent"), # bg of the panel
                    plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
                    panel.grid.major = element_blank(), # get rid of major grid
                    panel.grid.minor = element_blank(), # get rid of minor grid
                    legend.background = element_rect(fill = "transparent"), # get rid of legend bg
                    legend.box.background = element_rect(fill = "transparent")) + xlab("Team") + ylab("Rushes")
            
            
        }
        else if(input$metic=='Speed'){
            if (input$calc == "Average"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = mean(speed_mph)) %>%
                    left_join(.,teams,by="PossessionTeam")
            }
            else if(input$calc=="Total"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = n()) %>%
                    left_join(.,teams,by="PossessionTeam")
                
            }
            else if(input$calc=="Max"){
                
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = max(Yards)) %>%
                    left_join(.,teams,by="PossessionTeam")
                
            }
            else{
                data <- data %>% group_by(PossessionTeam,input$cut) %>% summarise(metric = n()) %>%
                    left_join(.,teams,by="PossessionTeam")
            }
            
            ggplot(data, aes_string(x = reorder("PossessionTeam",-metric), y = metric, fill=primary)) + geom_bar(stat="identity") + scale_fill_identity() + xlab("Team") + 
                ylab(paste0(input$calc,ifelse(str_length(input$calc)>0," Yards","Rushes"))) +
                theme(
                    panel.background = element_rect(fill = "transparent"), # bg of the panel
                    plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
                    panel.grid.major = element_blank(), # get rid of major grid
                    panel.grid.minor = element_blank(), # get rid of minor grid
                    legend.background = element_rect(fill = "transparent"), # get rid of legend bg
                    legend.box.background = element_rect(fill = "transparent")) + xlab("Team") + ylab("Rushes")
            
            
        }
        
    })
    
    # FIELD GRAPHICS:
    Rlogo <- readPicture("field-cairo.svg")
    RlogoSVGgrob <- gTree(children=gList(pictureGrob(Rlogo, ext="gridSVG")))
    # Second Graph
    output$plot2 <- renderPlot({ggplot(data,aes(x=X,y=Y,color=DisplayName)) + annotation_custom(RlogoSVGgrob,xmin=-17, xmax=127, ymin=-5, ymax=64) + geom_point(size=2,show.legend = FALSE) + 
            geom_segment(aes(x = X, y = Y, xend = X1, yend = Y1, colour = DisplayName,size=(S*60^2)/1760),arrow = arrow(length = unit(0.02, "npc"))) + scale_size_continuous("Speed",range=c(0,2)) + theme(
                panel.background = element_rect(fill = "transparent"), # bg of the panel
                plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
                panel.grid.major = element_blank(), # get rid of major grid
                panel.grid.minor = element_blank(), # get rid of minor grid
                legend.background = element_rect(fill = "transparent"), # get rid of legend bg
                legend.box.background = element_rect(fill = "transparent"), # get rid of legend panel bg, 
                axis.line=element_blank(),axis.text.x=element_blank(),
                axis.text.y=element_blank(),
                axis.ticks=element_blank(), legend.position = "top"
            ) + xlab("") + ylab("")
        
    })
}

shinyApp(ui, server)