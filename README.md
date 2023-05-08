# mlhc-project17
This is the repository for our MLHC class project on genetics-based prediction of transcriptional subtypes in Alzheimer’s disease
## Overview of the project
Our study employs a pre-trained model from SHEPHERD, a deep learning algorithm developed by the Zitnik Lab at Harvard Medical School, to facilitate the elucidation of the causal relationship between transcriptional hallmark gene candidates of Alzheimer's Disease (AD) and their associated phenotypes, through leveraging an external rare disease knowledge graph. Two rounds of prediction are conducted, with the second round incorporating GWAS-analysis information obtained with plink2.

The outputs from SHEPHERD are then subject to analysis by APRILE, GOA and ChatGPT's natural language processing capabilities, in conjunction with literature reviews, to extract biological insights and assess the potential of repurposing drugs currently used for rare neurological disorders, to treat AD. Our study provides a comprehensive approach to exploring potential drug repurposing for AD, utilizing state-of-the-art deep learning techniques and external data sources. All relevant code can be found on our GitHub respository. For reproducible results, follow the guideline below.

### Toolset requriements
- SHEPHERD
- plink2
- APRILE
- GOA

#### SHEPHERD Installation
A detailed steps to SHEPHERD installation and set-up can be found here: https://github.com/mims-harvard/SHEPHERD

### Data Preprocessing
#### SHEPHERD Data Preprocessing
The SHEPHERD pre-trained model takes in a jsonlines file, where each json represents a single patient and includes the patient's ID, positive phenotype coded by the Human Phenotype Ontology (HPO), and candidate genes in Ensembl IDs. Given your list of gene names, you can find steps of conversion to Ensembl IDs in *preprocess.ipynb* under the **shepherd** directory. Relevant files for necessary conversion are included as well. 

#### GWAS Data Preprocessing
Genotype data for our study was obtained from the UKB Exome 200K Project (source: \url{https://www.medrxiv.org/content/10.1101/2020.11.02.20222232v1}). To convert the exome data suitable for GWAS analysis, follow steps in the *plink_pipeline.sh* under the **ukb** directory.

