library(RPostgreSQL)
library(vegan)
library(parallel)
fracking_db <- dbConnect(PostgreSQL(), dbname='fracking')
nb_core<-1
load(file="tabBioEnvPlan.RData")
for(i in 1:nrow(tabBioEnvPlan))
{
  if(paste(paste(tabBioEnvPlan$biolGroup[i],tabBioEnvPlan$tranformationBiol[i],"bioEnvRes",sep="_"),"RData",sep=".") %in% dir())
  {
    next
  }
  ls1<-ls()
  load(file=paste(paste(tabBioEnvPlan$biolGroup[i],tabBioEnvPlan$tranformationBiol[i],"bioEnvData",sep="_"),"RData",sep="."))
  bioenvRes<-bioenv(comm=distBiol,env=envir,trace=T,parallel=nb_core)
  save(bioenvRes,file=paste(paste(tabBioEnvPlan$biolGroup[i],tabBioEnvPlan$tranformationBiol[i],"bioEnvRes",sep="_"),"RData",sep="."))
  rm(list=ls()[!ls()%in%ls1&!ls()=="ls1"])
  gc()
}

