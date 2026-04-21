# Visualization of Sarcoma-CAF Heterogeneity

This directory contains key visualizations derived from our integrative single-cell pipeline. 

> **Note:** This project is under active development. Visualizations are being updated as the analysis progresses.

## 1. Marker Gene Expression Analysis (Boxplots) 
**Status: ✅ Updated**

- **Description:** Statistical distribution of canonical markers across identified cell clusters.
- **Key Insight:** Boxplots demonstrate a significantly higher expression of *FAP*, *COL1A1*, and *PDPN* in the CAF clusters compared to malignant and other stromal cells (p < 0.001).
- **Update Log:** Currently showcasing primary sarcoma cohorts; clinical validation samples will be added shortly.

## 2. Integrated Cellular Landscape (UMAP)
**Status: ⏳ In Progress (Expected Update: Next Week)**

- **Plan:** Generating a harmonized UMAP plot integrating 4 GEO cohorts (GSE152048, GSE162454, GSE169396, GSE198896).
- **Goal:** To visualize the consistency of CAF sub-populations across different patient data sources after batch effect correction via Harmony.

## 3. Intercellular Communication Networks (Dot Plots)
**Status: 📅 Planned**

- **Plan:** Utilizing `CellChat` to visualize ligand-receptor interactions.
- **Goal:** Identifying the signaling axes between **Sarcoma-CAFs** and immune cells that drive the immunosuppressive microenvironment.

## 4. Spatial Distribution Analysis
**Status: 📅 Planned**

- **Plan:** Overlaying scRNA-seq signatures onto spatial transcriptomic slides.
- **Goal:** To confirm the architectural localization of iCAF and myCAF niches within the sarcoma tissue.

---
*All plots are generated using R/ggplot2. Data is iteratively processed to ensure the highest biological accuracy.*
