require(grid)
require(grImport2)
require(grConvert)
require(ggplot2)
require(dplyr)
require(gridSVG)
require(teamcolors)
setwd('/Users/kkannapp/Documents/DSE/DSE241/final_project/shiny/')

# Read CSV
r_csv2 <- function(X.file_path) {
  read.csv(file = X.file_path,header = TRUE,sep = ",",stringsAsFactors = FALSE)
}
nfl_teamcolors <- teamcolors %>% filter(league == "nfl")
nfl_teamcolors <- nfl_teamcolors[c(1:16,18,17,19:27,29,28,30:nrow(nfl_teamcolors)),]

convertPicture("field.svg", "field-cairo.svg")
Rlogo <- readPicture("field-cairo.svg")
RlogoSVGgrob <- gTree(children=gList(pictureGrob(Rlogo, ext="gridSVG")))
rush_data <- r_csv2("./rushers_lines.csv")

teams <- rush_data %>% select(PossessionTeam) %>% distinct() %>% arrange(PossessionTeam)
teams <- cbind(teams,nfl_teamcolors)

sf_data <- rush_data %>% filter(PossessionTeam=='LAC' & Position=='RB' & Season==2019) %>% filter(between(X1,0,120) & between(Y1,0,53.3)) ##%>% 
  ##filter(DisplayName=='Raheem Mostert')

p <- ggplot(sf_data,aes(x=X,y=Y,color=DisplayName)) + annotation_custom(RlogoSVGgrob,xmin=-17, xmax=127, ymin=-5, ymax=64) + geom_point(size=2,show.legend = FALSE) + 
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

p
##gridExtra::grid.arrange(egg::set_panel_size(p=p, width=unit(650, "points"), height=unit(316.5, "points")))


team_stats <- rush_data %>% filter(Position%in%c('RB','HB')) %>% group_by(PossessionTeam,Season,Down) %>% summarise(avg_rush = mean(Yards),total_rush = n()) %>%
  left_join(.,teams,by="PossessionTeam")
total_rush <- rush_data %>% filter(Position%in%c('RB','HB')) %>% group_by(PossessionTeam,Season) %>% summarise(avg_rush = mean(Yards),total_rush = n()) %>%
  left_join(.,teams,by="PossessionTeam")

ggplot(team_stats,aes(x=reorder(PossessionTeam,-total_rush),y=total_rush,fill=primary)) + geom_bar(stat = "identity") + scale_fill_identity() +
  theme(
  panel.background = element_rect(fill = "transparent"), # bg of the panel
plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
panel.grid.major = element_blank(), # get rid of major grid
panel.grid.minor = element_blank(), # get rid of minor grid
legend.background = element_rect(fill = "transparent"), # get rid of legend bg
legend.box.background = element_rect(fill = "transparent")) + xlab("Team") + ylab("Rushes")

