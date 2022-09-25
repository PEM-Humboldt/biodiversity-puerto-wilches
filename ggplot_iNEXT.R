th <- theme(
  axis.title = element_text(face = "bold", size = 18),
  #axis.line = element_line(colour = "black", size = 1),
  axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
  axis.text = element_text(size = 16),
  axis.ticks = element_line(colour = "black", size = .75),
  axis.ticks.length = unit(.20, "cm"),
  panel.background = element_rect(fill = "white", colour = "black", size = 1),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  #legend.title = element_text(face = "bold", size = 10),
  legend.title = element_blank(),
  legend.key = element_blank(),
  legend.text = element_text(size = 14),
  legend.position = "right",
  legend.background = element_blank(),
  line = element_line(size = 1),
  plot.background = element_blank()
)

th2 <- theme(
  axis.title = element_text(face = "bold", size = 18),
  #axis.line = element_line(colour = "black", size = 1),
  axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
  axis.text = element_text(size = 16),
  axis.ticks = element_line(colour = "black", size = .75),
  axis.ticks.length = unit(.20, "cm"),
  panel.background = element_rect(fill = "white", colour = "black", size = 1),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  #legend.title = element_text(face = "bold", size = 10),
  legend.title = element_blank(),
  legend.key = element_blank(),
  legend.text = element_text(size = 14),
  legend.position = "right",
  legend.background = element_blank(),
  line = element_line(size = 1),
  plot.background = element_blank()
)

th3 <- theme(
  axis.title = element_text(face = "bold", size =18),
  #axis.line = element_line(colour = "black", size = 1),
  #axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
  axis.text = element_text(size = 16),
  axis.ticks = element_line(colour = "black", size = .75),
  axis.ticks.length = unit(.20, "cm"),
  panel.background = element_rect(fill = "white", colour = "black", size = 1),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  #legend.title = element_text(face = "bold", size = 10),
  legend.title = element_blank(),
  legend.key = element_blank(),
  legend.text = element_text(size = 14),
  legend.position = "right",
  legend.background = element_blank(),
  line = element_line(size = 1),
  plot.background = element_blank()
)

iNEXT_ggplot_optimizado <- function(iNEXT_object,type,col,orderAssemblage,labX="Número de individuos",labY="Diversidad",themeDef=th,title="")
{
  x <- names(iNEXT_object$iNextEst)
  df<-fortify(iNEXT_object,type=type)
#  for (i in 1:length(x)) {
#    df$site <- replace(df$site , df$site == x[i], labels_iNEXT[i])
#  }
  df<-df[order(match(df$Assemblage,orderAssemblage)),]
  df.point <- df[which(df$Method=="Observed"),]
  #df.point$Assemblage<-factor(df.point$Assemblage,orderAssemblage)
  #df.point<-df.point[order(df.point$Assemblage),]
  df.line <- df[which(df$Method!="Observed"),]
  #df.line$Assemblage<-factor(df.line$Assemblage,orderAssemblage)
  df.line$method <- factor(df.line$Method,level=c("Rarefaction","Extrapolation"))
  #df.line<-df.line[order(df.line$Assemblage),]
  return(
    ggplot(df, aes(x=x, y=y, colour=Assemblage)) +
                  #geom_point(aes(shape=Assemblage), size=5, data=df.point) +
                  geom_line(aes(linetype=method), lwd=1.5, data=df.line) +
                  geom_ribbon(aes(ymin=y.lwr, ymax=y.upr,
                                  fill=Assemblage, colour=NULL), alpha=0.2) +
                  labs(x = labX, y = labY) +
                  scale_fill_manual(values = col) + 
                  scale_colour_manual(values = col) +
                  scale_shape_manual(values=c(0:6, 8)) + 
                  ggtitle(title)+
                  themeDef
         )
  
}
