# # Set the working directory
# setwd("D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping")
# 
# # Read the .gz file
# data <- read.table(gzfile("Homo_sapiens.gene_info.gz"), sep="\t", header=TRUE, fill=TRUE)
# 
# # Print the first few rows
# head(data)
# 
# 
# 
# # Read the .gz file into a DataFrame
# data <- read.table(gzfile("Homo_sapiens.gene_info.gz"), sep="\t", header=TRUE)
# 
# # Print the first few rows
# head(data)


# Required package
library(readr)

# Define the file path
file_path <- "D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping\\Homo_sapiens.gene_info.gz"

# Read the gzipped .csv file into a DataFrame
data <- read_tsv(gzfile(file_path))

# Print the first few rows
# head(data)



# List of columns to drop
cols_to_drop <- c("#tax_id", "LocusTag", "dbXrefs", "chromosome", "map_location", "description", 
                  "type_of_gene", "Symbol_from_nomenclature_authority", 
                  "Full_name_from_nomenclature_authority", "Nomenclature_status", 
                  "Other_designations", "Modification_date", "Feature_type")

# Drop columns

data1 <- data[, !(names(data) %in% cols_to_drop)]



# Load required packages
library(tidyverse)

# Separate the 'Synonyms' column into multiple rows
data2 <- data1 %>% 
  separate_rows(Synonyms, sep = "\\|")

# View the DataFrame
data2



