#!/usr/bin/env R

# Shashwat Deepali Nagar
# Jordan Lab, Georgia Tech
# Script to convert ESNP identifiers from STRING-DB to Official Gene Symbols and produce a file like this:
#
# Output file format:
# GeneName1	GeneName2	neighborhood	fusion	cooccurence	coexpression	experimental	database	textmining	combined_score
# ARF1GAP	ARF5	0	0	0	0	536	0	774	890
# GGA3	ARF5	0	0	0	0	298	0	788	844
# ASAP1	ARF5	0	0	0	0	240	0	790	833
# GGA1	ARF5	0	0	0	0	683	0	760	920
#
# Input file format:
# protein1	protein2	neighborhood	fusion	cooccurence	coexpression	experimental	database	textmining	combined_score
# ENSP00000000233	ENSP00000158762	0	0	0	0	328	0	785	849
# ENSP00000000233	ENSP00000237596	0	0	0	0	0	0	796	796
# ENSP00000000233	ENSP00000245541	0	0	0	0	298	0	788	844
# ENSP00000000233	ENSP00000263245	0	0	0	0	430	0	714	830
#
# Mapping file format:
# STRING	Gene.name
# ENSP00000397982	HLA-DBR1
# ENSP00000343144	16/05/05
# ENSP00000225928	17BHSDI
# ENSP00000369600	214K23.2
#
# This can be obtained from filtering the mapping file available on http://www.string-db.org
# using:
# awk '{print substr($1,6,15), $2, $3, $4, $5}' string.aliases.txt > stringMapping.txt
# grep "Blast_uniprot_gn" -i stringMapping.txt | awk 'BEGIN{OFS="\t"} {print $1, $2}' > mappingFile123.txt



mapString2genesymbol <- function(){

  initFile <- read.table("./../dataRepo/highConfidenceEverything_0.7.txt", sep = "\t", header = T)

  mappingFile <- read.table("../dataRepo/mappingFile.txt", sep = "\t", header = T)
  finalFile <- merge(initFile, mappingFile, by.x = "protein1", by.y = "STRING")
  finalFile$GeneName1 <- finalFile$Gene.name
  finalFile <- finalFile[c(12, 1:10)]
  finalFile <- merge(finalFile, mappingFile, by.x = "protein2", by.y = "STRING")
  finalFile$GeneName2 <- finalFile$Gene.name
  finalFile <- finalFile[c(2, 13, 4:11)]

  write.table(finalFile, file = "../dataRepo/generatedfiles/HighConfidenceWithGeneNames.txt", sep = "\t", col.name = T, quote = F, row.names = F)
}
