# function for volcano plot - healthy

#test = "t0_3_28"
#ctr = "t0_Unst"

volcano.healthy <- function(test, ctr, ...){
  dat <- read.table(paste0("./SVigano4_healthy_", test, ".vs.healthy_", ctr, "_DE.fdr5_anno.txt"), # fdr0.05 DE list
                    header = T, sep = "\t", row.names = 1)
  
  pdf(paste0("SVigano4_healthy_", test, ".vs.healthy_", ctr, "_VolcanoPlot.pdf"))
  plot(EnhancedVolcano(dat,
                       lab = dat$gene_name,
                       x = "log2FoldChange",
                       y = "padj",
                       title = paste0("healthy  ", test, " vs ", ctr),
                       titleLabSize = 16,
                       subtitle = "",
                       pCutoff = 0.01, # stringent
                       FCcutoff = 2, # stringent
                       pointSize = 0.5,
                       labSize = 2,
                       drawConnectors = TRUE,
                       widthConnectors = 0.3,
                       maxoverlapsConnectors = 20
                       )
      )
  dev.off()
}
