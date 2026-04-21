# Sarcoma_CAF-SingleCell-Integrative-Analysis
Sarcoma_CAF-SingleCell-Integrative-Analysis-code
# Integrative Analysis of Cancer-Associated Fibroblast (CAF) Heterogeneity in Sarcoma

This project focuses on the **computational-to-experimental characterization** of the stromal microenvironment in Sarcomas. By integrating multi-cohort single-cell RNA sequencing (scRNA-seq) data, we aim to dissect the functional diversity of **Sarcoma-Associated Fibroblasts (SAFs)** and their role in tumor progression.

## 🧬 Project Focus
Sarcomas are mesenchymal-derived tumors where the stroma plays a dominant role. This project investigates how CAF subpopulations drive:
- **Extracellular Matrix (ECM) Remodeling:** Identifying myofibroblastic-CAF signatures.
- **Immune Exclusion:** Mapping how CAFs create a "physical barrier" against T-cell infiltration.
- **Therapeutic Resistance:** Cross-validating CAF-derived signals across 4 independent sarcoma cohorts.

## 💻 Dry Lab (Pipeline)
- **Harmonization:** Integrating TARGET-OS, TCGA-SARC, and GEO datasets (100k+ cells).
- **Communication:** Decoding ligand-receptor interactions between CAFs and malignant mesenchymal cells.
- **Spatial Mapping:** Correlating CAF enrichment with poor prognostic zones in spatial transcriptomic slides.

## 🧪 Wet Lab (Targeted Validation)
- **Validation Logic:** "80% Dry Lab Discovery, 20% Precision Wet Lab Verification."
- **Techniques:** qPCR/WB for CAF markers; Co-culture models to observe CAF-induced tumor invasion.
├── figures/             # BioRender-style UMAPs, Heatmaps, and Trajectory plots
└── README.md            # Project documentation
