library(rvest)

get_standing_info = function(year){
        doc <- read_html(sprintf("http://espn.go.com/nba/standings/_/season/%d/group/league", year))
        col_names = doc %>% html_nodes("th") %>% html_text
        col_names[1] <- "TEAM"
        rows = doc %>% html_nodes("tr") 
        get_column = function(nth){
                ifelse(rep(nth == 1, length(rows)), doc %>% html_nodes(".team-names") %>% html_text, 
                       doc %>% html_nodes(sprintf("td:nth-child(%d)", nth)) %>% html_text)
        }
        standing <- data.frame(apply(cbind(1:length(col_names)), 1, get_column))
        names(standing) <- col_names
        return(standing)
}

get_standing_info(2016)
