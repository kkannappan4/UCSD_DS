# Expand Java Parameters
options(java.parameters = "-Xmx8g")

# Package List

# Data Extraction
require(RPostgreSQL) 
require(RJDBC)
require(XLConnect)

# Data Manipulation
require(dplyr) 
require(tidyr) 
require(lubridate) 
require(stringr)

# Send email based on completion
require(mailR)

# Function to deal with '
easy_in <- function(x){
  str_replace_all(x,"'","''")
}

# Function to prepare for quick upload
df_sql <- function(x){
  x %>% mutate_all(as.character)
  x[is.na(x)] <- "None"
  x %>% mutate_all(easy_in) %>% mutate(rownumber = 1:nrow(x)) %>% mutate(front=ifelse(rownumber%in%seq(1,nrow(x),by=4000),"",";")) %>% mutate(back=ifelse(((rownumber/4000)%%1==0)==TRUE,paste0(";"),paste0("")))
}



## Paths + PW
pgsql <- JDBC("org.postgresql.Driver","/Users/kkannapp/Documents/postgresql-9.4.1211.jre6.jar", "`")
pass_1 <- "PW"

white_house <- read.csv("/Users/kkannapp/Documents/DSE/2018-kkannapp/DSE203/hw2/WhiteHouse-WAVES-Released-1210.csv",sep=",",stringsAsFactors = FALSE)

white_house_upload <- white_house %>% select(lastname=NAMELAST,firstname=NAMEFIRST,uin=UIN,apptmade=APPT_MADE_DATE,apptstart=APPT_START_DATE,apptend=APPT_END_DATE,meetingloc=MEETING_LOC)
white_house_upload <- white_house_upload %>% filter(lastname != '') %>% mutate(fin_apptmade = ifelse(str_detect(apptmade,"[A|P]M")==TRUE,mdy_hms(apptmade),ifelse(str_detect(apptmade," ")==TRUE,mdy_hm(apptmade),mdy_hm(paste0(apptmade," 00:00"))))) %>% mutate(fin_apptstart = ifelse(str_detect(apptstart,"[A|P]M")==TRUE,mdy_hms(apptstart),ifelse(str_detect(apptstart," ")==TRUE,mdy_hm(apptstart),mdy_hm(paste0(apptstart," 00:00"))))) %>% mutate(fin_apptend = ifelse(str_detect(apptend,"[A|P]M")==TRUE,mdy_hms(apptend),ifelse(str_detect(apptend," ")==TRUE,mdy_hm(apptend),mdy_hm(paste0(apptend," 00:00")))))
white_house_upload$fin_apptmade <- as_datetime(white_house_upload$fin_apptmade)
white_house_upload$fin_apptmade <- as.character.POSIXt(white_house_upload$fin_apptmade)
white_house_upload$fin_apptstart <- as_datetime(white_house_upload$fin_apptstart)
white_house_upload$fin_apptstart <- as.character.POSIXt(white_house_upload$fin_apptstart)
white_house_upload$fin_apptend <- as_datetime(white_house_upload$fin_apptend)
white_house_upload$fin_apptend <- as.character.POSIXt(white_house_upload$fin_apptend)
white_house_upload$lastname <-str_replace_all(white_house_upload$lastname, "[^[:alnum:]]", " ")
#white_house_upload$last_name[white_house_upload$last_name==""] <- "None"
white_house_upload$firstname <-str_replace_all(white_house_upload$firstname, "[^[:alnum:]]", " ")
#white_house_upload$first_name[white_house_upload$first_name==""] <- "None"
#white_house_upload$uin[white_house_upload$uin==""] <- "None"
#white_house_upload$meetingloc[white_house_upload$meetingloc==""] <- "None"
rm(white_house)

# Sampling only 400K rows:
set.seed(7)
white_house_upload <- white_house_upload %>% sample_n(300000) %>% df_sql()
white_house_upload$lastname[white_house_upload$lastname==''] <- "None"
white_house_upload$firstname[white_house_upload$firstname==""] <- "None"
white_house_upload$uin[white_house_upload$uin==""] <- "None"
white_house_upload$meetingloc[white_house_upload$meetingloc==""] <- "None"
white_house_upload <- white_house_upload %>% mutate(sql_insert = paste0(front,"INSERT INTO public.visitors VALUES(",
                                                                                                              rownumber,",",
                                                                                     ifelse(lastname=="NULL",paste0(lastname,","),paste0("'",lastname,"'",",")),
                                                                                     ifelse(firstname=="NULL",paste0(firstname,","),paste0("'",firstname,"'",",")),
                                                                                     ifelse(uin=="NULL",paste0(uin,","),paste0("'",uin,"'",",")),
                                                                                     ifelse(fin_apptmade=="NULL",paste0(fin_apptmade,","),paste0("'",fin_apptmade,"'",",")),
                                                                                     ifelse(fin_apptstart=="NULL",paste0(fin_apptstart,","),paste0("'",fin_apptstart,"'",",")),
                                                                                     ifelse(fin_apptend=="NULL",paste0(fin_apptend,","),paste0("'",fin_apptend,"'",",")),
                                                                                     ifelse(meetingloc=="NULL",paste0(meetingloc),paste0("'",meetingloc,"'")),
                                                                                                              ")",back))

guardianqa <- dbConnect(pgsql,"jdbc:postgresql://lva1-gendevdb01:5432/postgres?ssl=true",sslfactory="org.postgresql.ssl.NonValidatingFactory", password=pass_1)

if(dbExistsTable(guardianqa,"visitors")){
  dbRemoveTable(guardianqa,"visitors")
  dbSendUpdate(guardianqa,
               "CREATE TABLE visitors
               (
               visitor_id integer primary key NOT NULL,
               lastname    text,
               firstname   text,
               uin         text,
               apptmade    text,
               apptstart   text,
               apptend     text,
               meeting_loc text
               );")
dbSendUpdate(guardianqa,paste("",paste(white_house_upload$sql_insert,collapse=""),";",sep=""))
dbDisconnect(guardianqa)
} else {
  dbSendUpdate(guardianqa,
               "CREATE TABLE visitors
               (
               visitor_id integer primary key NOT NULL,
               lastname    text,
               firstname   text,
               uin         text,
               apptmade    text,
               apptstart   text,
               apptend     text,
               meeting_loc text
               );")
dbSendUpdate(guardianqa,paste("",paste(white_house_upload$sql_insert,collapse=""),";",sep=""))
dbDisconnect(guardianqa)
}

# Write CSV
wr_csv2 <- function(Y.table,X.file_path) {
  write.csv(Y.table,file = X.file_path,na='',row.names = FALSE,fileEncoding = "UTF-8")
}
write.csv(white_house_upload,"/Users/kkannapp/Documents/DSE/2018-kkannapp/DSE203/hw2/white_house_sample.csv")
