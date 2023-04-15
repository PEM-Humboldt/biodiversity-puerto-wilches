library(RPostgreSQL)
library(vegan)
fracking_db <- dbConnect(PostgreSQL(), dbname='fracking')
tabBioEnvPlan<-as.data.frame(rbind(
  c("pece","ochiai","db","pece_occurrence_matrix","pece_envir",NA),
  c("minv","hellinger","normal","minv_matrix","minv_envir_water","minv_envir_sedim"),
  c("zopl","hellinger","normal","zopl_matrix","zopl_envir_water","zopl_envir_sedim"),
  c("fipl","hellinger","normal","fipl_matrix","fipl_envir_water","fipl_envir_sedim"),
  c("peri","hellinger","normal","peri_matrix","peri_envir_water","peri_envir_sedim"),
  c("mafi","hellinger","normal","mafi_matrix","mafi_envir_water","mafi_envir_sedim")
))
colnames(tabBioEnvPlan)<- c("biolGroup","tranformationBiol","RDA_type","nameBiolMatrix","envir1","envir2")
save(tabBioEnvPlan,file="tabBioEnvPlan.RData")
source("../dbTab2mat.R")
for(i in 1:nrow(tabBioEnvPlan))
{
  ls1<-ls()
  rawBiolMat<-dbReadTable(conn=fracking_db,name = c("public",tabBioEnvPlan[i,"nameBiolMatrix"]))
  colContent <- ifelse("density"%in%colnames(rawBiolMat),"density",NA)
  biolMat <- dbTab2mat(rawBiolMat,col_samplingUnits = "anh_tempo",col_species = "taxon",col_content = colContent,checklist = is.na(colContent))
  envir1 <- dbReadTable(fracking_db,name=tabBioEnvPlan[i,"envir1"])
  rn <- envir1$anh_tempo
  envir1<-envir1[,-which(colnames(envir1)=="anh_tempo")]
  if(!is.na(tabBioEnvPlan[i,"envir2"]))
  {
    envir2<-dbReadTable(fracking_db,name=tabBioEnvPlan[i,"envir2"])
    stopifnot(all(envir1$anh_tempo==envir2$anh_tempo))
    envir2<-envir2[,-which(colnames(envir2)=="anh_tempo")]
    colnames(envir1)<-paste("wat",colnames(envir1),sep=".")
    colnames(envir2)<-paste("sed",colnames(envir2),sep=".")
    envir<-cbind(envir1,envir2)
  }else{
    envir<-envir1
  }
  rownames(envir)<-rn
  toKeep<-intersect(rownames(biolMat),rownames(envir))
  biolMat<-biolMat[toKeep,]
  envir <- envir[toKeep,]
  envir<-envir[sapply(envir,mode)=="numeric" & !grepl("cd_gp_event",colnames(envir))]
  nbNa<-sapply(envir,function(x)sum(is.na(x)))
  envir <- envir[sapply(envir,function(x)sum(is.na(x)))<6]
  envir <- na.omit(envir)
  envir<-envir[,sapply(envir,function(x)length(unique(x)))>1]
  toKeep<-intersect(rownames(biolMat),rownames(envir))
  biolMat<-biolMat[toKeep,]
  envir <- envir[toKeep,]
  if(tabBioEnvPlan$tranformationBiol[i]=="hellinger")
  {
    transf <- decostand(biolMat,method = "hellinger")
    distBiol <- vegdist(transf,method="euclidean")
  }
  if(tabBioEnvPlan$tranformationBiol[i]=="ochiai")
  {
    transf=NULL
    distBiol<-designdist(biolMat,method="1-J/sqrt(A*B)",terms="binary",name="Ochiai")
  }
  save(list=c("envir","biolMat","distBiol","transf"),file=paste(paste(tabBioEnvPlan$biolGroup[i],tabBioEnvPlan$tranformationBiol[i],"bioEnvData",sep="_"),"RData",sep="."))
  rm(list=ls()[!ls()%in%ls1&!ls()=="ls1"])
}

