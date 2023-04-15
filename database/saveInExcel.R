save_in_excel<-function(file,lVar)
{
  if(!is.list(lVar)){
    listVar<-mget(lVar,envir = .GlobalEnv)
  }else{listVar<-lVar}
  wb <- createWorkbook()
  for(i in 1:length(listVar))
  {
    addWorksheet(wb, sheetName = names(listVar)[i])
    hasRownames <- !all(grepl("^[0-9]*$",rownames(listVar[[i]])))
    writeDataTable(wb, sheet =names(listVar)[i], listVar[[i]],rowNames = hasRownames)
    nCols<-ifelse(hasRownames,ncol(listVar[[i]]), ncol(listVar[[i]]))
    setColWidths(wb, sheet =names(listVar)[i],cols = 1:nCols, widths = 'auto')
  }
  saveWorkbook(wb, file, overwrite = TRUE,)
}

