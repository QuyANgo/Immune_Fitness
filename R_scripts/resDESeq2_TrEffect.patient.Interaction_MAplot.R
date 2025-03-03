# DE patient & Interactions

#test <- "t0_3_28"
#ctr <- "t0_Unst"

#eff <- "treatment_t0_3_28_vs_t0_Unst"
#inr <- "phenotypepatient.treatmentt0_3_28"

TrEff.patient.Intr <- function(eff, inr, test, ctr, ...) {
  resPT <- results(dds, contrast = list(c(eff, inr)))
  
  pdf(paste0("SVigano4_patient_", test, ".vs.patient_", ctr, "_MAplot.pdf"))
  plotMA(resPT, ylim=c(-2,2))
  dev.off()
  
  filterValues <- rownames(as.data.frame(resPT))
  annot <- getBM(attributes = attributeNames,
                 filters = filterTypes,
                 values = filterValues,
                 mart = Ensembl104)
  head(annot)
  colnames(annot) <- c("Stable_GeneID_version", "gene_name")
  
  anno.res <- as.data.frame(resPT) %>% 
    rownames_to_column("GeneID_version") %>% 
    left_join(annot, by = c("GeneID_version" = "Stable_GeneID_version")) %>% 
    arrange(by_group = padj)
  
  nrow(anno.res)
  head(anno.res)
  tail(anno.res)
  
  write.table(anno.res, 
              file = paste0("SVigano4_patient_", test, ".vs.patient_", ctr, "_DE.all_anno.txt"), 
              append = F, quote = F, sep = "\t", row.names = F)
  
  sum(anno.res$padj < 0.05, na.rm=TRUE)
  res <- subset(anno.res, anno.res$padj < 0.05) %>% 
    arrange(group_by = log2FoldChange)
  head(res)
  tail(res)

  write.table(res, 
              file = paste0("SVigano4_patient_", test, ".vs.patient_", ctr, "_DE.fdr5_anno.txt"), 
              append = F, quote = F, sep = "\t", row.names = F)
  
}

