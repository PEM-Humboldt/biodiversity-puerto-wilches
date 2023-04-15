require(rmarkdown)
require(foreach)
require(doParallel)
(FilesRMD <- dir(pattern=".*bioEnv.*.Rmd",recursive=T))
for(i in paste(getwd(),c("Hidrobiologicos/macroinvertebrados_bioEnv_RDA.Rmd","Hidrobiologicos/zooplancton_bioEnv_RDA_hellinger.Rmd"),sep="/")){
  setwd(dirname(i))
  render(i)
}
