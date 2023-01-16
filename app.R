# Set up --------------------------------------------------------------------
# Loadings
# Shiny
library(shiny)
library(shinymanager)
# Calender
library(fullcalendar)
# Google
library(googlesheets4)
# Data Table
library(tidyverse)
library(DT) # Interactive data table

# Credentials
credentials <- read_sheet("1uNKILtVDa8h4uLNk914mn2ecZCSQotBE3gz_auRO2u4","Credentials")

set_labels(
  "language" = "en",
  "Please authenticate" = "You have to log in",
  "Username :" = "What is your name :",
  "Password :" = "Enter your Password :"
)

# Import data
df_ag <- read_sheet("1uNKILtVDa8h4uLNk914mn2ecZCSQotBE3gz_auRO2u4","Aggregate")
df_works <- read_sheet("1uNKILtVDa8h4uLNk914mn2ecZCSQotBE3gz_auRO2u4","Works")
df_works.undone <- df_works[!isTRUE(df_works$done)] %>%
  .[!isTRUE(.$expired)] %>%
  select(!c(ts,done,expired))

# Convert the data for calendar shows
data <- df_ag %>%
  mutate(
    title = paste(remains, " (", surplus_hours, "h)", sep = ""),
    start = date,
    end = date,
    color = color
  ) %>%
  select(title,start,end,color)

# UI -------------------------------------------------------------------------

ui <- navbarPage(
  title = "Surplus",
  
  header = verbatimTextOutput("header"),

  # Calendar
  tabPanel(
    title = "Calendar",
    fullcalendarOutput("calendar")
  ),
  
  # Input
  tabPanel(
    title = "Table",
    DT::dataTableOutput("table")
  )
)

ui <- secure_app(ui)

# Server ------------------------------------------------------------------

server <- function(input,output){
  
  # Credentials
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials),
    keep_token = TRUE
  )
  
  # Header
  output$header <- renderText(
    res_auth$user
  )
  
  output$calendar <- renderFullcalendar({
    fullcalendar(data)
  })
  
  output$table <- DT::renderDataTable(
    df_works
  )
}

# Run app -------------------------------------------------------------------

shinyApp(ui, server)