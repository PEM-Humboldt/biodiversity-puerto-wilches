# Funcion para hacer los graficos de 
# -rango abundancia
# -rango incidencia
# -rango cobertura
# -rango densidad


#parameters:
# mat: abundance/incidence/cover/density matrix
# extraLines: factor in order to show extra rank abundance lines in the order of the main 
# nbSp number of species in the main graph
# 

rankAbundance <- function(
    mat,
    type = c("abundance","incidence","cover","density"),
    nbSp = min(15,ncol(mat)),
    extraLines = NA,
    Ycalc = if(type == "incidence") {identity} else {log10},
    extraPch = 21,
    extraCol = rainbow(nlevels(extraLines)),
    borderLineCol = extraCol,
    legendOut = F,
    legendPlace = "topright",
    legend1 = "Total",
    legendTitle = NULL,
    legendInset = if(legendOut){c(-.3,0)} else {c(0,0)},
    addProfiles = T,
    profilesOut = T,
    profilesOutFig = c(.8,.99,0.25,0.5),
    profilesInFigRatioX=.20,
    profilesInFigRatioY=.25,
    titleProfile="Perfiles",
    labY = "Total abundance",
    calc = if(type %in% c("abundance","incidence")){colSums} else{colMeans},
    MARG = c(10.1,6.5,1,ifelse(legendOut|profilesOut,9,1)),
    byTICK = 50,
    byLABELS = byTICK*2,
    maxLABELS = 500000,
    pchMain = 15,
    colMain = "black",
    ltyMain = 2,
    ltyExtra = 3,
    posAxisX = 0,
    adjAxisX = 1.1,
    posNameSp=-.25
    )
{
  # Checking type
  type <- match.arg(type)
  # Checking compatibility between extraLines, colors and pch
  stopifnot(all(is.na(extraLines))||length(extraPch)==1||length(extraPch)==nlevels(extraLines))
  if(length(extraPch)==1){extraPch <- rep(extraPch,nlevels(extraLines))}
  stopifnot(all(is.na(extraLines))||length(extraCol)==1||length(extraCol)==nlevels(extraLines))
  if(length(extraCol)==1){extraCol <- rep(extraCol,nlevels(extraLines))}
  stopifnot(all(is.na(extraLines))||length(borderLineCol)==1||length(borderLineCol)==nlevels(extraLines))
  if(length(borderLineCol)==1){borderLineCol <- rep(borderLineCol,nlevels(extraLines))}
  # Calculation of main line values
  dataMain <- sort(calc(mat),decreasing = T)[1:nbSp]
  # Calculation of extra lines values
  if(!all(is.na(extraLines)))
  {
    b_dataExtra <- by(mat[,names(dataMain)],extraLines,calc)
    dataExtra <- Reduce(rbind,b_dataExtra[sapply(b_dataExtra,length)>0])
    rownames(dataExtra) <- names(b_dataExtra)[sapply(b_dataExtra,length)>0]
  }else{dataExtra<-matrix(1,nrow=1,ncol=nbSp)}
  # Applying margins
  keepPar <- par(no.readonly = T)
  par(mar=MARG)
  # plot in case of log scale in Y

    # main line and plot coordinates
    plot(1:nbSp,Ycalc(dataMain),ylab=labY, xlab=NA,ylim=c(0,max(Ycalc(rbind(dataMain,dataExtra)))*1.1),pch=pchMain,bty="n",xaxt="n",yaxt="n", las=2,type="b",lty=ltyMain)
    # line of the taxon axis
    axis(side=1, at=1:nbSp, labels=FALSE, lwd.tick=-1, outer=T, pos=posAxisX)
    # names of the taxa
    text(x=(1:nbSp)+.2,y=posNameSp,names(dataMain),xpd=NA,srt=45,adj=adjAxisX)
    # preparing the y axis
    ATX <- c(1,seq(byTICK,maxLABELS,byTICK))
    ATX <- ATX[1:(min(which(ATX>max(rbind(dataMain,dataExtra))))+1)]
    ATX <- unique(ATX[c(1,which(ATX%%byTICK==0),length(ATX))])
    show <- c(T,ATX[2:(length(ATX)-1)]%%byLABELS==0,T)
    axis(side=2,at=Ycalc(ATX),labels=ifelse(show,ATX,NA),las=2)
    # Extra lines
    if (!all(is.na(extraLines)))
    {
      for(i in 1:nlevels(extraLines))
      {
        lev <- levels(extraLines)[i]
        if(! lev %in% rownames(dataExtra)){next}
        points(1:nbSp,Ycalc(dataExtra[lev,]),pch=extraPch[i], col = borderLineCol[i], bg = extraCol[i], type= "b" ,lty = ltyExtra)
      }
    }

  # Legend
  if(!all(is.na(extraLines)))
  {
    if (legendOut) 
      {par(xpd=T)}
    legend(legendPlace,pch=c(pchMain,extraPch[levels(extraLines)%in%unique(extraLines)]),col = c(colMain, borderLineCol[levels(extraLines)%in%unique(extraLines)]), pt.bg = c(colMain,extraCol[levels(extraLines)%in%unique(extraLines)]), legend=c(legend1,levels(extraLines)[levels(extraLines) %in% unique(extraLines)]),inset = legendInset, title = legendTitle, bty='n')
  }
  # Inset profiles
  if(addProfiles==T)
  {
    if(profilesOut)
    {
      par(xpd=T)
      FIG <- profilesOutFig
    }else{
      FIG <- c(grconvertX(0.05+c(0,profilesInFigRatioX),from="npc",to="ndc"),grconvertY(0.05+c(0,profilesInFigRatioY),from="npc",to="ndc"))
    }
    par(fig=FIG,new=T,mar=c(0.05,0,.7,0),oma=c(0,0,0,0))
    tot_calc_profiles<-sort(calc(mat),decreasing=T)
    if(!all(is.na(extraLines)))
    {
      cat_calc_profiles<-by(mat,extraLines,function(x)sort(calc(x)[calc(x)>0],decreasing = T))
      plot(x=1:ncol(mat),y=Ycalc(tot_calc_profiles),type='l',ylim=range(Ycalc(Reduce(c,c(tot_calc_profiles,cat_calc_profiles)))),bty='n',lwd=1.2,xaxt='n',yaxt='n',main=titleProfile)
      axis(1,at = seq(0,ncol(mat)),labels=F,lwd.ticks = -1,pos=min(Ycalc(Reduce(c,c(tot_calc_profiles,cat_calc_profiles)))))
      axis(2,at=c(min(Ycalc(Reduce(c,c(tot_calc_profiles,cat_calc_profiles)))),Ycalc(ATX)),labels=F,tck=-0.05)
      for(i in 1:nlevels(extraLines))
      {
        lev<-levels(extraLines)[i]
        if (!lev %in% unique(extraLines)) {next}
        points(x=1:length(cat_calc_profiles[[i]]),y=Ycalc(cat_calc_profiles[[i]]),col=extraCol[i],type='l')
      }
    }else{
      plot(x=1:ncol(mat),y=Ycalc(tot_calc_profiles),type='l',bty='n',lwd=1.2,xaxt='n',yaxt='n',main=titleProfile)
      axis(1,at = seq(0,ncol(mat)),labels=F,lwd.ticks = -1,pos=min(Ycalc(tot_calc_profiles[tot_calc_profiles>0])))
      axis(2,at=c(min(Ycalc(tot_calc_profiles[tot_calc_profiles>0])),Ycalc(ATX)),labels=F,tck=-0.05)
    }
#  if(delimPerfil){
#    segments(0,nbSp,max(c(Ycalc(posAxisX),0.00000001),na.rm = T),max(c(Ycalc(posAxisX),0.0000001),na.rm = T),col="grey",2)
#    segments(nbSp,nbSp,0,max(Ycalc(rbind(dataMain,dataExtra)))*1.1)  
#  }
  }
  par(keepPar)
  if(!all(is.na(extraLines)))
  {return(rbind(Total=dataMain,dataExtra))}else{
    return(dataMain)
  }
}


