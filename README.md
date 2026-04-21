# Sarcoma_CAF-SingleCell-Integrative-Analysis
Sarcoma_CAF-SingleCell-Integrative-Analysis-code
# Integrative Single-Cell Analysis and Functional Validation in Neuroblastoma (NB)

This project establishes a robust **computational-to-experimental pipeline** designed to identify and validate key regulatory genes in the tumor microenvironment (TME). By integrating multiple single-cell RNA sequencing (scRNA-seq) datasets, we aim to uncover novel biomarkers and therapeutic targets in **Neuroblastoma**.

## 🧬 Project Overview
Traditional target screening often lacks high-resolution cellular context. This project utilizes **computer-biology driven integration** (dry lab) to guide precision **functional verification** (wet lab).

- **Objective:** Identify target genes associated with specific malignant states or stromal sub-populations (e.g., CAFs) and validate their biological significance.
- **Scope:** Cross-cohort analysis of 4 independent public datasets (TARGET, TCGA, and GEO series) combined with local clinical samples.

## 🛠 Methodology

### 💻 Dry Lab (Bioinformatics Workflow)
- **Data Integration:** Harmonization of multi-batch scRNA-seq data using `Seurat`, `Scanpy`, and `Harmony`.
- **Advanced Analysis:** - Dimensionality reduction & Clustering (UMAP/t-SNE).
  - Trajectory inference (`Monocle 3`) to map cellular plasticity.
  - Cell-cell communication analysis (`CellChat`/`CellPhoneDB`) to decode stroma-tumor crosstalk.
- **Target Selection:** Machine-learning-based ranking of genes based on differential expression and gene regulatory network (GRN) centrality.

### 🧪 Wet Lab (Functional Validation)
- **Expression Profiling:** Quantitative RT-qPCR and Western Blot to confirm *in silico* predictions.
- **Phenotypic Assays:** Cell proliferation, migration, and apoptosis assays following CRISPR-Cas9 mediated knockdown or lentiviral overexpression.
- **Validation Logic:** Focus on 20% high-impact experiments to verify 80% computational findings.

## 📈 Key Pipeline Steps
1. **Data Acquisition & QC:** Standardized preprocessing and mitochondrial/multiplet filtering.
2. **Integration & Clustering:** Resolving batch effects across 4 independent cohorts.
3. **Marker Identification:** Detecting sub-population specific signatures (e.g., Cancer-Associated Fibroblasts).
4. **Target Prioritization:** Screening candidates via functional enrichment and regulatory network analysis.
5. **Experimental Benchmarking:** *In vitro* validation in NB cell lines and clinical tissue sections.

## 📁 Repository Structure
```text
├── scripts/             # R/Python scripts for Seurat pipeline and Monocle 3
├── data/                # Metadata and descriptions of TARGET/GEO cohorts
├── figures/             # BioRender-style UMAPs, Heatmaps, and Trajectory plots
└── README.md            # Project documentation
