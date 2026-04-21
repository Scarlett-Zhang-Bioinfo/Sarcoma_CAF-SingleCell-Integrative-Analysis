# Data Sources & Availability

This directory provides an overview of the datasets utilized in the **Sarcoma-CAF** project, including integrated public repositories and local clinical cohorts.

## 1. Public Datasets (GEO)
We performed a cross-cohort integration of **4 independent single-cell RNA sequencing datasets** from the NCBI Gene Expression Omnibus (GEO). This allows for a robust meta-analysis of Sarcoma-Associated Fibroblast (SAF) heterogeneity.

| Accession ID | Tumor Type | Technology | Description |
| :--- | :--- | :--- | :--- |
| **GSE152048** | Osteosarcoma | 10x Genomics | Mapping the cellular landscape of primary osteosarcoma. |
| **GSE162454** | Sarcoma | 10x Genomics | Focus on tumor microenvironment and immune infiltration. |
| **GSE169396** | Osteosarcoma | 10x Genomics | Characterizing malignant cell states and stromal niche. |
| **GSE198896** | Osteosarcoma | 10x Genomics | Integrated analysis of primary and metastatic lesions. |

## 2. Clinical Cohort (Local)
To validate the *in silico* findings derived from the GEO cohorts, we integrated local clinical samples from our collaborating medical centers.
- **Sample Type:** Freshly resected Sarcoma tissues and matched para-cancerous tissues.
- **Source:** Academic medical centers affiliated with Shanghai University of Medicine & Health Sciences (SUMHS).
- **Data Privacy:** Raw sequencing data and processed matrices are stored on a secure local server in compliance with institutional data security regulations.

## 3. Data Processing & Integration Pipeline
To mitigate batch effects across the four GEO series and clinical samples, we employed a standardized computational workflow:
1. **Preprocessing:** Strict quality control (QC) filtering based on UMI counts, feature counts, and mitochondrial gene percentage (<15%).
2. **Doublet Detection:** Removal of potential doublets using `DoubletFinder` or `scrublet`.
3. **Integration:** Systematic alignment using **Harmony** or **Seurat V5 integration (CCA/RPCA)** to resolve cohort-specific variations while preserving biological heterogeneity.
4. **Annotation:** Manual cell-type annotation guided by canonical markers (e.g., *COL1A1*, *ACTA2*, *FAP* for CAFs).

## 4. Ethical Statement
All local clinical sample collection protocols were approved by the Institutional Review Board (IRB). Informed consent was obtained from all patients according to the Declaration of Helsinki.

---
*For questions regarding the data processing pipeline or metadata, please contact the project maintainer.*

