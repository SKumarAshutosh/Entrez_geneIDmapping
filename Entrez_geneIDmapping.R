# Set the working directory
setwd("D:\\R_Tutorials\\BioInformatics\\Entrez_geneIDmapping")



# Read the .gz file
data <- read.table(gzfile("Homo_sapiens.gene_info.gz"), sep="\t", header=TRUE, fill=TRUE)




# Define function to read GMT file
read.gmt <- function(file) {
  # Read the GMT file as lines
  lines <- readLines(file)
  
  # Split each line into elements
  data <- strsplit(lines, "\t")
  
  # Convert to list
  data.list <- lapply(data, function(x) x[-(1:2)])
  
  # Name list elements as the gene set names
  names(data.list) <- sapply(data, function(x) x[1])
  
  # Return the list
  return(data.list)
}

# Use function to read GMT file
gene.sets <- read.gmt("h.all.v2023.1.Hs.symbols.gmt")


