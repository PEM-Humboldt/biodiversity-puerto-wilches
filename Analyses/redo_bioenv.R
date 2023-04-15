require(rmarkdown)
require(foreach)
require(doParallel)
(FilesRMD <- dir(pattern=".*bioEnv.*.Rmd",recursive=T))
for(i in paste(getwd(),c("Hidrobiologicos/macrofitas_bioEnv_RDA.Rmd","Hidrobiologicos/zooplancton_bioEnv_RDA.Rmd","Peces/peces_bioEnv_RDA.Rmd"),sep="/")){
  setwd(dirname(i))
  render(i)
}
