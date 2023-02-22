# Import RSelenium ------
install.packages("RSelenium")
library(RSelenium)
library(tidyverse)

# Browsing test --------
driver <- rsDriver(
  browser = "chrome"
)

# Test of open browser with command --------
shell("start chrome https://docs.google.com/forms/d/1o0bN_a3E_Ri0AHGSNhWu8W2ecHtZD2nJ_E47V0XvuZ4/edit#responses")
