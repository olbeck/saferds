## code to prepare `DATASET` dataset goes here

set.seed(290)

TMean <- 50.19565
FMean <- 172.8936
SMean <- 164.8298

TSd <- 10.81895
FSd <- 50.10825
SSd <- 41.49768

Tdata <- round(rnorm(7*8, TMean, TSd))
Fdata <- round(rnorm(7*8, FMean, FSd))
Sdata <- round(rnorm(7*8, SMean, SSd))

SimDat <- c( Tdata, Fdata, Sdata)
Day <- c(rep("Thurs", 7*8), rep("Fri", 7*8),rep("Sat", 7*8))
FY <-  rep(c(rep("FY14", 8), rep("FY15", 8), rep("FY16", 8), rep("FY17", 8), rep("FY18", 8), rep("FY19", 8), rep("FY20", 8)),3)
Week <- c(rep(1:8, 21))

all_data_sim <- data.frame("Day" = Day,
                    "FY" = FY,
                    "Week" = Week,
                    "Rides" = SimDat)
all_data_sim$Week <- as.factor(all_data_sim$Week)

all_data_sim$Rides[all_data_sim$FY == "FY20"]= all_data_sim$Rides[all_data_sim$FY == "FY20"]+150

usethis::use_data("all_data_sim", overwrite = TRUE)
