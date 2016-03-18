library(rvest)


get_schedule_info = function(year){
        doc <- read_html(sprintf("http://www.basketball-reference.com/leagues/NBA_%d_games.html", year))
        schedule <- apply(cbind(c(1, 4:7)), 1, 
                          function(nth) doc %>% html_nodes(sprintf("td:nth-child(%d)", nth)) %>% html_text) %>% data.frame
        names(schedule) <- c("Date", "Away_Team", "Away_Score", "Home_Team", "Home_Score")
        return(schedule)
}

get_schedule_info(2014)


