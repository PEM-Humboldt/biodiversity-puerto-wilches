effectiveTaxNbProfile <- function(
    iNEXT_tot,
    iNEXT_categ = NULL,
    colTotal="black",
    colCateg=rainbow(length(categLevels)),
    categLevels = names(colCateg),
    colErrorBar = "darkgrey",
    YLAB="Número efectivo de especies (Hill)",
    titleLegend="Cobertura"
    )
{
  est_tot <- iNEXT_tot$AsyEst
  mat_barplot <- matrix(est_tot$Estimator,ncol=3,dimnames=list(c("Total"),c("Q0 (richness)","Q1 (Shannon)","Q2 (Simpson)")))
  mat_lower <- matrix(est_tot$`95% Lower`,ncol=3)
  mat_upper <- matrix(est_tot$`95% Upper`,ncol=3)
  if(!is.null(iNEXT_categ))
  {
    est_categ <- iNEXT_categ$AsyEst
    est_categ$Assemblage<-factor(est_categ$Assemblage,levels=categLevels)
    mat_barplot <- rbind(mat_barplot,Reduce(rbind,by(est_categ,est_categ$Assemblage,function(x)matrix(x$Estimator,ncol=3,dimnames=list(unique(x$Assemblage),c("Q0 (richness)","Q1 (Shannon)","Q2 (Simpson)"))))))
    mat_lower <- rbind(mat_lower,Reduce(rbind,by(est_categ,est_categ$Assemblage,function(x)matrix(x$LCL,ncol=3,dimnames=list(unique(x$Assemblage),c("Q0 (richness)","Q1 (Shannon)","Q2 (Simpson)"))))))
    mat_upper <- rbind(mat_upper,Reduce(rbind,by(est_categ,est_categ$Assemblage,function(x)matrix(x$UCL,ncol=3,dimnames=list(unique(x$Assemblage),c("Q0 (richness)","Q1 (Shannon)","Q2 (Simpson)"))))))
  }
  A<-barplot(mat_barplot,beside = T,ylim=c(0,max(mat_upper)),col=c(colTotal,colCateg[categLevels%in%rownames(mat_barplot)]),legend=T,args.legend=list(bty="n",title=titleLegend),ylab=YLAB,las=1)
  segments(A,mat_lower,A,mat_upper,col=colErrorBar,lwd=2)
  segments(A-0.1,mat_lower,A+0.1,mat_lower,col=colErrorBar,lwd=2)
  segments(A-0.1,mat_upper,A+0.1,mat_upper,col=colErrorBar,lwd=2)
}
