library(dplyr)
library(tidyr)

# Assuming 'data2' is your dataframe with columns 'GeneID', 'Symbol', 'Synonyms'

# Create the mappings from symbols and synonyms to GeneID
symbol_to_id <- data2 %>% select(GeneID, Symbol) %>% deframe()
data2 <- data2 %>% mutate(Synonyms = strsplit(as.character(Synonyms), "|", fixed = TRUE)) %>% unnest(Synonyms)
synonyms_to_id <- data2 %>% select(GeneID, Synonyms) %>% deframe()

# Define the function to read a GMT file and replace gene symbols with IDs
read_gmt <- function(file_path, symbol_to_id, synonyms_to_id) {
  # Read the file line by line
  lines <- readLines(file_path)
  
  # Initialize the list to store the gene sets
  gene_sets <- list()
  
  # Process each line
  for(line in lines) {
    # Split the line into components
    split_line <- strsplit(line, "\t")[[1]]
    
    # Extract the gene set name, description, and genes
    gene_set_name <- split_line[1]
    description <- split_line[2]
    genes <- split_line[3:length(split_line)]
    
    # If there is no description, adjust accordingly
    if(description %in% genes) {
      genes <- genes[genes != description]
      description <- NA
    }
    
    # Replace genes with corresponding GeneID
    genes <- sapply(genes, function(gene) {
      if(gene %in% names(symbol_to_id)) return(symbol_to_id[gene])
      else if(gene %in% names(synonyms_to_id)) return(synonyms_to_id[gene])
      else return(NA)  # Return NA for unmatched genes
    })
    
    # Filter out NA values (unmatched genes)
    genes <- genes[!is.na(genes)]
    
    # Add the gene set to the list
    gene_sets[[gene_set_name]] <- list(description = description, genes = genes)
  }
  
  return(gene_sets)
}

# Define the function to print all gene sets
print_all_gene_sets <- function(gene_sets) {
  for(gene_set in names(gene_sets)) {
    cat("Gene Set:", gene_set, "\n")
    cat("Description:", gene_sets[[gene_set]]$description, "\n")
    cat("Genes:", paste(gene_sets[[gene_set]]$genes, collapse = ", "), "\n\n")
  }
}

# Use the function
file_path <- "D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping\\h.all.v2023.1.Hs.symbols.gmt"
gene_sets <- read_gmt(file_path, symbol_to_id, synonyms_to_id)

# Print all gene sets
print_all_gene_sets(gene_sets)

