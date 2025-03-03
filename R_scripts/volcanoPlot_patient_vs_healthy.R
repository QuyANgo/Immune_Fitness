# function for volcano plot - response of patient vs healthy

#test = "t0_3_28"
#ctr = "t0_Unst"

volcano.patient.vs.healthy <- function(test, ctr){
  dat <- read.table(paste0("./SVigano4_patient_", test,
                           "-", ctr, 
                           ".vs.healthy_", test, 
                           "-", ctr, 
                           "_DE.all_anno.txt"), # entire DE list
                    header = T, sep = "\t", row.names = 1)
  
  pdf(paste0("SVigano4_patient_", test, 
             "-", ctr, 
             ".vs.healthy_", test, 
             "-", ctr, 
             "_VolcanoPlot.pdf"))
  plot(EnhancedVolcano(dat,
                       lab = dat$gene_name,
                       x = "log2FoldChange",
                       y = "padj",
                       title = paste0("Stimulant Responses of Patient vs Healthy  "), 
                       subtitle = paste0("log2FC of ", test, " / ", ctr),
                       titleLabSize = 16,
                       subtitleLabSize = 16,
                       pCutoff = 0.1, # less stringent
                       FCcutoff = 1, # less stringent
                       pointSize = 0.5,
                       labSize = 2,
                       drawConnectors = TRUE,
                       widthConnectors = 0.3,
                       maxoverlapsConnectors = 20
                       )
      )
  dev.off()
  
  nrow(dat)
}
