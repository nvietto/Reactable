

# Load Packages ------------------------------------------------------------

pacman::p_load(tidyverse, reactablefmtr, reactable, htmltools, htmlwidgets, glue, janitor, wesanderson)

# Set directory and load file ------------------------------------------------------------

setwd("/Users/nicholasvietto/Documents/RCreate/Reactable")

imbd <- read.csv("imbd.csv")

# Set colors ----------------------------------------------------
bg_color <- '#0B0B0A'
border_color<-'#2E2E2E'
pal <- wes_palette("GrandBudapest2")

# Data wrangle ----------------

imbd1 <- imbd %>%
dplyr::select(Title, Year, Rating)
 

# Create table --------------------------------------------

imbd_table<- reactable(imbd1,
          pagination = FALSE,
          searchable = TRUE,
          theme = reactableTheme(
            borderColor = border_color,
            backgroundColor= bg_color,
            style=list(
              backgroundColor=bg_color,
              color="whitesmoke",
              paddingLeft=20,
              paddingRight=20,
              paddingTop=20),
            searchInputStyle=list(
              backgroundColor=bg_color,
              borderColor=border_color)),
          columns = list(
            Rating = colDef(
              cell = data_bars(imbd1,
                              fill_color = pal,
                              fill_gradient = TRUE,
                              background = "grey",
                              text_color = "whitesmoke",
                              brighten_text = TRUE,
                              box_shadow = TRUE,
                              round_edges = TRUE,
                              border_style = "solid",
                              border_color = "white",
                              border_width = "1px",
                              bar_height = 25)))) %>%
          reactablefmtr::google_font(font_family="Oswald", font_weight=c(400,600)) 

imbd_finished <- imbd_table %>%
  htmlwidgets::prependContent(
    tags$div(style = 'background-color:#0B0B0A;color:white;padding-left:30px;padding-top:5px;',
             tags$h1("IMDb Top 250 Film Based on User Ratings",style = "margin-bottom:0px;")
            
    )
  )
                          

# Export HTML ------------------------

htmlwidgets::saveWidget(imbd_finished, "/Users/nicholasvietto/Documents/RCreate/Reactable/imbd_finished.html", selfcontained=TRUE)

   
      