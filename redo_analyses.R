require(rmarkdown)
require(foreach)
require(doParallel)
FilesRMD <- dir(pattern=".*analisis.*.Rmd",recursive=T)
FilesRMD <- paste(getwd(),FilesRMD,sep="/")
registerDoParallel(3)  # use multicore, set to the number of our cores
foreach (i=FilesRMD) %dopar% {
  setwd(dirname(i))
  render(i)
}
#lapply(FilesRMD,function(x)
#  {setwd(dirname(x))
#  render(x)}
#  )

