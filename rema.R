library(devtools)
#devtools::install_github("afsc-assessments/rema", dependencies = TRUE, build_vignettes = FALSE)
#install.packages('TMB', type = 'source')
library(dplyr)
library(reshape2)
library(ggplot2)
library(rema)

data<-read.csv("data/EBSCrab_AB_Sizegroup.csv")
input_dat<-filter(data,SIZE_GROUP =="MALE_GE102")[,colnames(data)%in%c("SURVEY_YEAR","BIOMASS_MT","BIOMASS_MT_CV")]
colnames(input_dat)<-c("year","biomass","cv")
input_dat$strata<-"Bering Sea"
input <- prepare_rema_input(model_name = 'tmb_rema_snow', biomass_dat = input_dat)
m<-fit_rema(input)
output<-tidy_rema(rema_model=m)
plots1<-plot_rema(tidy_rema=output,biomass_ylab="Biomass (t)")
plots1$biomass_by_strata+theme_bw()

names(output)
output$total_predicted_biomass

# unique(data$SIZE_GROUP)
# input_dat<-filter(data,SIZE_GROUP =="MALE_GE95")[,colnames(data)%in%c("SURVEY_YEAR","BIOMASS_MT","BIOMASS_MT_CV")]
# colnames(input_dat)<-c("year","biomass","cv")
# input_dat$strata<-"Bering Sea"
# input <- prepare_rema_input(model_name = 'tmb_rema_snow', biomass_dat = input_dat)
# m<-fit_rema(input)
# output<-tidy_rema(rema_model=m)
# plots<-plot_rema(tidy_rema=output,biomass_ylab="Biomass (t)")
# plots$biomass_by_strata+theme_bw()




