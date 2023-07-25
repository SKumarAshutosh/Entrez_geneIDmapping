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
# Assuming 'data2' is your dataframe with columns 'GeneID', 'Symbol', 'Synonyms'


# library(tidyverse)
# library(readr)
# 
# # Assuming data2 is your data frame with columns 'GeneID', 'Symbol', 'Synonyms'
# data2 <- read_csv('your_data.csv')
# 
# # Create lists for mapping symbols and synonyms to GeneID
# symbol_to_id <- setNames(data2$GeneID, data2$Symbol)
# 
# # Split synonyms
# data2 <- data2 %>%
#   separate_rows(Synonyms, sep = "\\|") 
# 
# synonyms_to_id <- setNames(data2$GeneID, data2$Synonyms)
# 
# map_gene_to_id <- function(gene, symbol_to_id, synonyms_to_id) {
#   if (gene %in% names(symbol_to_id)) {
#     return(symbol_to_id[[gene]])
#   } else if (gene %in% names(synonyms_to_id)) {
#     return(synonyms_to_id[[gene]])
#   } else {
#     return(gene)
#   }
# }
# 
# read_gmt <- function(file_path, symbol_to_id, synonyms_to_id) {
#   lines <- read_lines(file_path)
#   
#   # Parse the lines
#   gene_sets <- map(lines, ~ {
#     split_line <- str_split(.x, "\t")[[1]]
#     gene_set_name <- split_line[1]
#     description <- split_line[2]
#     genes <- split_line[3:length(split_line)]
#     
#     # Remove description from genes if present
#     if (description %in% genes) {
#       genes <- genes[!genes == description]
#       description <- NULL
#     }
#     
#     # Replace genes with corresponding GeneID
#     genes <- map_chr(genes, map_gene_to_id, symbol_to_id = symbol_to_id, synonyms_to_id = synonyms_to_id)
#     
#     tibble(gene_set_name = gene_set_name, description = description, genes = list(genes))
#   })
#   
#   bind_rows(gene_sets)
# }
# 
# print_all_gene_sets <- function(gene_sets) {
#   walk(seq_len(nrow(gene_sets)), ~ {
#     cat(paste0("Gene Set: ", gene_sets$gene_set_name[.x]), "\n")
#     cat(paste0("Description: ", gene_sets$description[.x]), "\n")
#     cat(paste0("Genes: ", paste(gene_sets$genes[[.x]], collapse = ", ")), "\n\n")
#   })
# }
# 
# # Use the function
# gene_sets <- read_gmt("D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping\\h.all.v2023.1.Hs.symbols.gmt", symbol_to_id, synonyms_to_id)
# 
# # Print all gene sets
# print_all_gene_sets(gene_sets)


# 
# library(tidyverse)
# library(stringr)
# 
# # Assuming data2 is your data frame with columns 'GeneID', 'Symbol', 'Synonyms'
# # data2 <- read_csv('your_data.csv')
# 
# # Create lists for mapping symbols and synonyms to GeneID
# symbol_to_id <- data2 %>%
#   select(Symbol, GeneID) %>%
#   deframe()
# 
# # Split synonyms and create a mapping
# data2 <- data2 %>%
#   mutate(Synonyms = str_split(Synonyms, pattern = "\\|")) %>%
#   unnest(Synonyms)
# 
# synonyms_to_id <- data2 %>%
#   select(Synonyms, GeneID) %>%
#   deframe()
# 
# # Function to read the gmt file and replace the gene names with IDs
# read_gmt <- function(file_path, symbol_to_id, synonyms_to_id) {
#   lines <- readLines(file_path)
#   
#   gene_sets <- map(lines, function(line) {
#     parts <- str_split(line, "\t")[[1]]
#     
#     gene_set_name <- parts[1]
#     description <- parts[2]
#     genes <- parts[3:length(parts)]
#     
#     # If description is present in genes, remove it
#     if (description %in% genes) {
#       genes <- setdiff(genes, description)
#       description <- NULL
#     }
#     
#     # Replace the gene names with their IDs
#     genes <- map_chr(genes, function(gene) {
#       if (gene %in% names(symbol_to_id)) {
#         as.character(symbol_to_id[[gene]])
#       } else if (gene %in% names(synonyms_to_id)) {
#         as.character(synonyms_to_id[[gene]])
#       } else {
#         NA_character_
#       }
#     })
#     
#     list(gene_set_name = gene_set_name, description = description, genes = genes)
#   })
#   
#   gene_sets
# }
# 
# # Function to print all gene sets
# print_all_gene_s = function(gene_sets) {
#   for (gene_set in gene_sets) {
#     cat(paste("Gene Set: ", gene_set$gene_set_name, "\n"))
#     cat(paste("Description: ", gene_set$description, "\n"))
#     cat(paste("Genes: ", paste(gene_gene_set$genes, collapse = ", "), "\n\n"))
#   }
# }
# 
# # Use the function
# gene_sets <- read_gmt("D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping\\h.all.v2023.1.Hs.symbols.gmt", symbol_to_id, symbol_to_id)
# 
# # Print all gene sets
# print_all_gene_sets(gene_sets)
# 
# # Print all gene sets to a file
# sink("mapping.gmt")
# print_all_gene_sets(gene_sets)
# sink()




library(tidyverse)
library(stringr)



# Create lists for mapping symbols and synonyms to GeneID
symbol_to_id <- data2 %>%
  select(Symbol, GeneID) %>%
  deframe()

# Split synonyms and create a mapping
data2 <- data2 %>%
  mutate(Synonyms = str_split(Synonyms, pattern = "\\|")) %>%
  unnest(Synonyms)

synonyms_to_id <- data2 %>%
  select(Synonyms, GeneID) %>%
  deframe()

# Function to read the gmt file and replace the gene names with IDs
read_gmt <- function(file_path, symbol_to_id, synonyms_to_id) {
  lines <- readLines(file_path)
  
  gene_sets <- map(lines, function(line) {
    parts <- str_split(line, "\t")[[1]]
    
    gene_set_name <- parts[1]
    description <- parts[2]
    genes <- parts[3:length(parts)]
    
    # If description is present in genes, remove it
    if (description %in% genes) {
      genes <- setdiff(genes, description)
      description <- NULL
    }
    
    # Replace the gene names with their IDs
    genes <- map_chr(genes, function(gene) {
      if (gene %in% names(symbol_to_id)) {
        as.character(symbol_to_id[[gene]])
      } else if (gene %in% names(synonyms_to_id)) {
        as.character(synonyms_to_id[[gene]])
      } else {
        NA_character_
      }
    })
    
    list(gene_set_name = gene_set_name, description = description, genes = genes)
  })
  
  gene_sets
}

# Function to print all gene sets
print_all_gene_sets <- function(gene_sets) {
  for (gene_set in gene_sets) {
    cat(paste("Gene Set: ", gene_set$gene_set_name, "\n"))
    cat(paste("Description: ", gene_set$description, "\n"))
    cat(paste("Genes: ", paste(gene_set$genes, collapse = ", "), "\n\n"))
  }
}

# Function to write the gene sets to a .gmt file
write_gmt <- function(gene_sets, file_name) {
  file_conn <- file(file_name, "w")
  for (gene_set in gene_sets) {
    lines <- c(paste("Gene Set: ", gene_set$gene_set_name), 
               paste("Description: ", gene_set$description), 
               paste("Genes: ", paste(gene_set$genes, collapse = ", ")))
    writeLines(lines, file_conn)
    writeLines("", file_conn) # add a newline after each gene set
  }
  close(file_conn)
}

# Use the function
gene_sets <- read_gmt("D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping\\h.all.v2023.1.Hs.symbols.gmt", symbol_to_id, synonyms_to_id)

# Print all gene sets
print_all_gene_sets(gene_sets)

# Write the gene sets to a .gmt file
write_gmt(gene_sets, "D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping\\mapping.gmt")






