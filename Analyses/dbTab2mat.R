# The dbTab2mat does something comparable to a "dynamic table" of a famous spreadsheet application
# it takes a table with a column for sampling unit name (col_samplingUnits) a column for species names and a column for abundances (or presence absence: checklist=T) and makes a matrix of sampling units x species

dbTab2mat <-
function(dbTab,col_samplingUnits="SU",col_species="sp",col_content="abundance",empty=NA,checklist=F)
{
  COLS<-unique(as.character(dbTab[,col_species]))
  ROWS<-unique(as.character(dbTab[,col_samplingUnits]))
  arr.which<-matrix(NA,ncol=2,nrow=nrow(dbTab),dimnames=list(1:nrow(dbTab),c("row","col")))
  arr.which[,1]<-match(as.character(dbTab[,col_samplingUnits]),ROWS)
  arr.which[,2]<-match(as.character(dbTab[,col_species]),COLS)
  modeContent<-ifelse(checklist,"logical",mode(dbTab[,col_content]))
  if(is.na(empty)){empty<-switch(modeContent,character="",numeric=0,logical=F)}
  res<-matrix(empty,ncol=length(COLS),nrow=length(ROWS),dimnames=list(ROWS,COLS))
	if(checklist){ res[arr.which]<-T}else{res[arr.which]<-dbTab[,col_content]}
  return(res)
}
