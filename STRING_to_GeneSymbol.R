#!/usr/bin/env Rscript

# Shashwat Deepali Nagar

# Script to convert ESNP identifiers from STRING-DB to Official Gene Symbols and produce a file like this:

# Check README for details about input file.

# Usage: ./STRING_to_GeneSymbol.R <Input File> <Mapping File> <Output File>


# Reading in command-line arguments
args <- commandArgs(TRUE)
inputFile <- args[1]
mappingFileLoc <- args[2]
outputFileLoc <- args[3]

# Check if arguments are provided
if(length(args) < 3) {
  stop("Please provide appropriate input!")
}

mapString2genesymbol <- function(inputFile, mappingFileLoc, outputFileLoc){

  initFile <- read.table(inputFile, sep = "\t", header = T)

  mappingFile <- read.table(mappingFileLoc, sep = "\t", header = T)
  finalFile <- merge(initFile, mappingFile, by.x = "protein1", by.y = "STRING")
  finalFile$GeneName1 <- finalFile$Gene.name
  finalFile <- finalFile[c(12, 1:10)]
  finalFile <- merge(finalFile, mappingFile, by.x = "protein2", by.y = "STRING")
  finalFile$GeneName2 <- finalFile$Gene.name
  finalFile <- finalFile[c(2, 13, 4:11)]

  write.table(finalFile, file = outputFileLoc, sep = "\t", col.name = T, quote = F, row.names = F)
}

mapString2genesymbol(inputFile, mappingFileLoc, outputFileLoc)
