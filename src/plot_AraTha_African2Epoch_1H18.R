library(ggplot2)
library(cowplot)

## define variables
infile="../data/AraTha_African2Epoch_1H18.txt"
outfile="../display_items/AraTha_African2Epoch_1H18.pdf"
species="Arabidopsis thaliana"
pop0_name="Africa"
method1_name="SMC++"
method2_name="stairway plot"
method3_name="MSMC (n = 2)"
method4_name="MSMC (n = 8)"
method1_id="smcpp"
method2_id="sp"
method3_id="msmc_2"
method4_id="msmc_8"
truth_color="gray30"
replicate_colors<-c("#66c2a4","#41b6c4","#225ea8")

## plot
cPal_legend<-c(truth_color, replicate_colors)

tab0 <- read.table(file=infile, h=T ,sep="\t")

tab0$x[tab0$x==0.0]<-1

xMin = 10
xMax = max(tab0$x)
yMin = min(tab0$y)
yMax = max(tab0$y)

tab0A = subset(tab0,method == method1_id)
tab0B = subset(tab0,method == method2_id)
tab0C = subset(tab0,method == method3_id)
tab0D = subset(tab0,method == method4_id)
tab0Z = subset(tab0,method == "coal")

speciesPop <- bquote(italic(.(species)) ~ (.(pop0_name)))

p0A<-ggplot(tab0A, aes(x=x, y=y, group=interaction(rep), colour=rep)) +
  coord_cartesian(xlim=c(xMin,xMax),ylim=c(yMin,yMax)) +
  geom_step(data=tab0Z,aes(x=x, y=y),size=2.5,alpha=1.0, col=truth_color) +
  geom_step(size=1.2, alpha=0.9, show.legend = FALSE) +
  scale_x_continuous(trans='log10') +
  scale_y_continuous(trans='log10') +
  annotation_logticks(sides="b") +
  annotation_logticks(sides="l") +
  scale_color_manual(values=replicate_colors) +
  guides(colour=guide_legend(keywidth=0.3,keyheight=0.21,default.unit="inch")) +
  theme_classic(base_size = 18) +
  labs(x="", y="", title="", subtitle=method1_name, colour="", fill="")+
  theme(axis.text.x = element_text(angle = 45,hjust = 0.5,vjust = 0.5)) 


p0B<-ggplot(tab0B, aes(x=x, y=y, group=interaction(rep), colour=rep)) +
  coord_cartesian(xlim=c(xMin,xMax),ylim=c(yMin,yMax)) +
  geom_step(data=tab0Z,aes(x=x, y=y),size=2.5,alpha=1.0, col=truth_color) +
  geom_step(size=1.2, alpha=0.9, show.legend = FALSE) +
  scale_x_continuous(trans='log10') +
  scale_y_continuous(trans='log10') +
  annotation_logticks(sides="b") +
  annotation_logticks(sides="l") +
  scale_color_manual(values=replicate_colors) +
  guides(colour=guide_legend(keywidth=0.3,keyheight=0.21,default.unit="inch")) +
  theme_classic(base_size = 18) +
  labs(x="", y="", title="", subtitle=method2_name) +
  theme(axis.text.x = element_text(angle = 45,hjust = 0.5,vjust = 0.5)) +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

p0C<-ggplot(tab0C, aes(x=x, y=y, group=interaction(rep), colour=rep)) +
  coord_cartesian(xlim=c(xMin,xMax),ylim=c(yMin,yMax)) +
  geom_step(data=tab0Z,aes(x=x, y=y),size=2.5,alpha=1.0, col=truth_color) +
  geom_step(size=1.2, alpha=0.9, show.legend = FALSE) +
  scale_x_continuous(trans='log10') +
  scale_y_continuous(trans='log10') +
  annotation_logticks(sides="b") +
  annotation_logticks(sides="l") +
  scale_color_manual(values=replicate_colors) +
  guides(colour=guide_legend(keywidth=0.3,keyheight=0.21,default.unit="inch")) +
  theme_classic(base_size = 18) +
  labs(x="", y="", title="", subtitle=method3_name) +
  theme(axis.text.x = element_text(angle = 45,hjust = 0.5,vjust = 0.5))+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

p0D<-ggplot(tab0D, aes(x=x, y=y, group=interaction(rep), colour=rep)) +
  coord_cartesian(xlim=c(xMin,xMax),ylim=c(yMin,yMax)) +
  geom_step(data=tab0Z,aes(x=x, y=y),size=2.5,alpha=1.0, col=truth_color) +
  geom_step(size=1.2, alpha=0.9, show.legend = FALSE) +
  scale_x_continuous(trans='log10') +
  scale_y_continuous(trans='log10') +
  annotation_logticks(sides="b") +
  annotation_logticks(sides="l") +
  scale_color_manual(values=replicate_colors) +
  guides(colour=guide_legend(keywidth=0.3,keyheight=0.21,default.unit="inch")) +
  theme_classic(base_size = 18) +
  labs(x="", y="", title="", subtitle=method4_name) +
  theme(axis.text.x = element_text(angle = 45,hjust = 0.5,vjust = 0.5))+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

###PLOTSAVE
pg<-plot_grid(p0A, p0B, p0C, p0D, ncol=4, rel_widths = c(1.25,1,1,1))
pg_custom<-ggdraw(add_sub(pg, expression(paste("Years ago")), vpadding=grid::unit(0,"lines"),y=6, x=0.5, vjust=5, size=20)) +
draw_label("Population size", x=0, y=0.55, vjust= 1.5, angle=90, size=20) +
draw_label(speciesPop, x=0.22, y=1.2, vjust= 5, size=22)
save_plot(outfile, pg_custom, base_height = 6 , base_width = 14)

