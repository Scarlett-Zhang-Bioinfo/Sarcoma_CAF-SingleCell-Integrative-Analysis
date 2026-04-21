# Seurat Analysis Pipeline for GSE152048 (Sarcoma CAF scRNA-seq data)
# Steps: Read 10X data → Merge samples → QC filtering → Normalization → HVG → Scaling

# 1. Install packages (optional, comment if already installed)
# install.packages("RCurl")
# install.packages("BiocManager")
# BiocManager::install("SingleCellExperiment")
# BiocManager::install("tidyverse")
# BiocManager::install('multtest')
# install.packages('Seurat')
# install.packages('hdf5r')

# 2. Load libraries
library(SingleCellExperiment)
library(Seurat)
library(tidyverse)
library(Matrix)
library(scales)
library(cowplot)
library(RCurl)
library(stringr)
library(dplyr)
library(ggplot2)

# 3. Set working directory (modify as needed)
# setwd("your_working_directory_path")

# 4. Read all 10X samples and create Seurat objects
root_dir <- "D:/Desktop/肉瘤的肿瘤相关成纤维CAF细胞/scRNA/GSE/GSE152048"   # CHANGE THIS TO YOUR ACTUAL PATH

# Find all folders matching pattern "GSE152048_BC*.matrix"
sample_dirs <- list.dirs(root_dir, recursive = FALSE, full.names = TRUE)
sample_dirs <- sample_dirs[grepl("GSE152048_BC.*\\.matrix$", basename(sample_dirs))]

seurat_list <- list()   # store individual Seurat objects

for (dir in sample_dirs) {
  # Extract sample name: "GSE152048_BC2.matrix" -> "BC2"
  sample_name <- gsub("GSE152048_(BC[0-9]+)\\.matrix", "\\1", basename(dir))
  
  # Path to the actual 10X data subfolder (same name as sample_name)
  data_dir <- file.path(dir, sample_name)
  
  if (!dir.exists(data_dir)) {
    warning(paste("Directory does not exist, skipping:", data_dir))
    next
  }
  
  # Optional: verify required files exist
  required_files <- c("barcodes.tsv.gz", "features.tsv.gz", "matrix.mtx.gz")
  files_present <- all(required_files %in% list.files(data_dir))
  if (!files_present) {
    warning(paste("Incomplete 10X files, skipping:", data_dir))
    next
  }
  
  cat("Reading sample:", sample_name, "\n")
  
  # Read 10X data
  counts <- Read10X(data.dir = data_dir)
  
  # Create Seurat object
  seurat_obj <- CreateSeuratObject(counts = counts, project = sample_name)
  
  # Add metadata
  seurat_obj$sample <- sample_name
  seurat_obj$dataset <- "GSE152048"
  # Optional: add condition (primary/recurrent) based on sample name – adjust according to the paper
  # seurat_obj$condition <- ifelse(sample_name %in% c("BC2", "BC3"), "Primary", "Recurrent")
  
  seurat_list[[sample_name]] <- seurat_obj
  
  # Save individual object as .rds (optional)
  # saveRDS(seurat_obj, file = paste0("GSE152048_", sample_name, "_seurat.rds"))
  
  cat("Finished reading", sample_name, "\n\n")
}

cat("All samples loaded:", names(seurat_list), "\n")

# 5. Merge all samples into one Seurat object
combined_seurat <- merge(seurat_list[[1]], 
                         seurat_list[-1], 
                         add.cell.ids = names(seurat_list))

cat("Merged object:", ncol(combined_seurat), "cells,", nrow(combined_seurat), "genes\n")

# Save merged object
saveRDS(combined_seurat, file = "GSE152048_combined_seurat.rds")
cat("Saved: GSE152048_combined_seurat.rds\n")

# 6. Quality control (QC) and filtering
# Calculate mitochondrial percentage (human: "^MT-"; for mouse change to "^mt-")
combined_seurat[["percent.mt"]] <- PercentageFeatureSet(combined_seurat, pattern = "^MT-")

# Visualize QC metrics (violin plots)
VlnPlot(combined_seurat, features = c("nFeature_RNA", "percent.mt"), 
        ncol = 2, pt.size = 0, group.by = "sample")

# Boxplots using ggplot2
meta_data <- combined_seurat[[]]
meta_data$sample <- combined_seurat$sample

p1 <- ggplot(meta_data, aes(x = sample, y = nFeature_RNA, fill = sample)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "nFeature_RNA", title = "nFeature_RNA per sample") +
  NoLegend()

p2 <- ggplot(meta_data, aes(x = sample, y = percent.mt, fill = sample)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Percent MT", title = "Mitochondrial percent per sample") +
  NoLegend()

cowplot::plot_grid(p1, p2, ncol = 2)

# Filter cells: nFeature_RNA >= 300 & percent.mt <= 10 (standard from reference)
filtered_seurat <- subset(combined_seurat,
                          subset = nFeature_RNA >= 300 & percent.mt <= 10)

cat(sprintf("Cell filtering: before = %d cells, after = %d cells, removed = %.1f%%\n",
            ncol(combined_seurat), ncol(filtered_seurat),
            (1 - ncol(filtered_seurat)/ncol(combined_seurat)) * 100))

# Filter genes: keep genes expressed in at least 3 cells
filtered_seurat <- JoinLayers(filtered_seurat)   # required for Seurat v5; if v4, may skip
genes_to_keep <- rowSums(GetAssayData(filtered_seurat, layer = "counts") > 0) >= 3
filtered_seurat <- filtered_seurat[genes_to_keep, ]

cat(sprintf("Gene filtering: remaining %d genes\n", nrow(filtered_seurat)))

# Save filtered object
saveRDS(filtered_seurat, file = "GSE152048_filtered_user_standard.rds")
cat("Saved: GSE152048_filtered_user_standard.rds\n")

# 7. Normalization, HVG selection, and scaling
# Load filtered object if needed (uncomment if starting fresh)
# filtered_seurat <- readRDS("GSE152048_filtered_user_standard.rds")

seurat_preprocessed <- filtered_seurat %>%
  NormalizeData(normalization.method = "LogNormalize", scale.factor = 10000) %>%
  FindVariableFeatures(nfeatures = 3000) %>%
  ScaleData(features = rownames(.))

cat("Normalization complete. Number of variable features:", length(VariableFeatures(seurat_preprocessed)), "\n")
cat("Scaling complete. Features used:", length(rownames(seurat_preprocessed)), "\n")

# Save final preprocessed object
saveRDS(seurat_preprocessed, file = "GSE152048_normalized_HVG3000_scaled_allgenes.rds")
cat("Saved: GSE152048_normalized_HVG3000_scaled_allgenes.rds\n")

# Print summary
print(seurat_preprocessed)
