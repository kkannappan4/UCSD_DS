# Read packages:

# Data Manipulation
require(dplyr) 
require(tidyr) 
require(lubridate) 
require(stringr)

# Data Visualization
require(ggplot2)

# Read CSV
r_csv2 <- function(X.file_path) {
  read.csv(file = X.file_path,header = TRUE,sep = ",",stringsAsFactors = FALSE)
}

# Not In
`%nin%` = Negate(`%in%`)

# Set WD
setwd("/Users/kkannapp/Documents/DSE/DSE241/homework_4")

### Category 1 ###
cat_1 <- r_csv2("./Quarterly_report.csv")

ggplot(cat_1,aes(x=quarter,y=value,color=region,group=region)) + 
  scale_y_continuous(labels=dollar_format(prefix="$")) + 
  geom_text(aes(label=scales::dollar(value)),vjust=-0.3,size=4,show.legend = FALSE) + geom_point() +
  geom_line() + scale_color_brewer(palette = "Set2") + xlab("\nQuarter") + ylab("Sales\n") + 
  theme_bw() + theme(text = element_text(size=24),legend.position = "right",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),plot.title = element_text(size = 30, face = "bold")) +
  guides(color=guide_legend(title="Region: ")) + scale_x_discrete(labels= c("Q1","Q2","Q3","Q4")) + ggtitle("Quarterly Sales by Region\n")

### Category 2 ###
cat_2 <- r_csv2("./budget_clean.csv")

cat_2[,2:ncol(cat_2)] <- lapply(cat_2[,2:ncol(cat_2)],function(x){as.numeric(gsub(",", "", x))})
cat_2_dat <- cat_2 %>% select(cost_bucket,fy_2019,fy_2020) %>% mutate(growth = round((fy_2020-fy_2019)/fy_2019,2))

require(gridExtra)
sum_dat <- cat_2 %>% filter(cost_bucket %in%c("Total Spending","Federal Deficit"))
sum_dat <- sum_dat %>% select(-fy_2021) %>% pivot_longer(-cost_bucket,names_to = "year",values_to = "cost")
sum_dat$year <- as.numeric(gsub("fy_","",sum_dat$year))

sum_graph <- ggplot(sum_dat,aes(x=year,y=round(cost),color=cost_bucket,group=cost_bucket)) + 
  scale_y_continuous(labels=dollar_format(prefix="$",suffix="B")) + 
  geom_text(aes(label=paste0(scales::dollar(round(cost)),"B")),vjust=-0.3,size=2.5,show.legend = FALSE) + geom_point() +
  geom_line() + scale_color_brewer(palette = "Set1") + xlab("\nYear") + ylab("Government Spending\n") + 
  theme_bw() + theme(text = element_text(size=14),legend.position = "top",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),plot.title = element_text(size = 16, face = "bold")) +
  guides(color=guide_legend(title="U.S. Budget: ")) + ggtitle("U.S. Government Spending over Time")

year_dat <- cat_2_dat %>% filter(cost_bucket%nin%c('Balance','Total Spending','Federal Deficit','Gross Public Debt'))

year_graph <- ggplot(year_dat,aes(x=reorder(str_wrap(cost_bucket,10),-fy_2020),y=round(fy_2020),fill=growth)) + 
  scale_y_continuous(labels=dollar_format(prefix="$",suffix="B")) +
  geom_bar(stat='identity') + geom_text(aes(label=paste0(scales::dollar(round(fy_2020)),"B")),vjust=-0.25,size=2.5,show.legend = FALSE) + 
  scale_fill_distiller(type="seq",palette = "PuBuGn",direction = 1,labels=percent,limits=c(-0.05, 0.14)) +
  xlab("\nCost Sector") + ylab("Government Spending\n") + 
  theme_bw() + theme(text = element_text(size=14),legend.position = "right",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),plot.title = element_text(size = 16, face = "bold")) +
  labs(fill="Growth (YoY)") + ggtitle("Cost Sector Growth in 2020\n")

grid.arrange(sum_graph, year_graph, ncol=1, nrow =2,top="Analyzing U.S. Budget Spending: How $4.3 Trillion is Spent in 2020\n")
