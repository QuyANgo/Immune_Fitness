# DE for treatment effect (stim vs. Unst) between 2 phenotypes (patient vs. healthy)

#comp <- "t0_3_28-t0_Unst"

#inr <- "phenotypepatient.treatmentt0_3_28"

TrEff.patient.healthy.Intr <- function(comp, inr, ...) {
  resINT <- results(dds, name = inr)
  
  pdf(paste0("SVigano4_patient_", comp, ".vs.healthy_", comp, "_MAplot.pdf"))
  plotMA(resINT, ylim=c(-2,2))
  dev.off()
  
  filterValues <- rownames(as.data.frame(resINT))
  annot <- getBM(attributes = attributeNames,
                 filters = filterTypes,
                 values = filterValues,
                 mart = Ensembl104)
  head(annot)
  colnames(annot) <- c("Stable_GeneID_version", "gene_name")
  
  anno.res <- as.data.frame(resINT) %>% 
    rownames_to_column("GeneID_version") %>% 
    left_join(annot, by = c("GeneID_version" = "Stable_GeneID_version")) %>% 
    arrange(by_group = padj)
  
  nrow(anno.res)
  head(anno.res)
  tail(anno.res)
  
  write.table(anno.res, 
              file = paste0("SVigano4_patient_", comp, ".vs.healthy_", comp, "_DE.all_anno.txt"), 
              append = F, quote = F, sep = "\t", row.names = F)
  
  sum(anno.res$padj < 0.1, na.rm=TRUE)
  res <- subset(anno.res, anno.res$padj < 0.1) %>% 
    arrange(group_by = log2FoldChange)
  head(res)
  tail(res)
  
  write.table(res, 
              file = paste0("SVigano4_patient_", comp, ".vs.healthy_", comp, "_DE.fdr10_anno.txt"), 
              append = F, quote = F, sep = "\t", row.names = F)
  
}

