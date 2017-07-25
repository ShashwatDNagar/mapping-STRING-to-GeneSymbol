# Mapping STRING Identifiers to Gene Symbols

Script to convert ESNP identifiers from STRING-DB to Official Gene Symbols and produce a file like this:

### Output file format:
```
GeneName1 GeneName2	neighborhood	fusion	cooccurence	coexpression	experimental	database	textmining	combined_score
ARF1GAP	ARF5	0	0	0	0	536	0	774	890
GGA3	ARF5	0	0	0	0	298	0	788	844
ASAP1	ARF5	0	0	0	0	240	0	790	833
GGA1	ARF5	0	0	0	0	683	0	760	920
```

### Input file format:
```
protein1	protein2	neighborhood	fusion	cooccurence	coexpression	experimental	database	textmining	combined_score
ENSP00000000233	ENSP00000158762	0	0	0	0	328	0	785	849
ENSP00000000233	ENSP00000237596	0	0	0	0	0	0	796	796
ENSP00000000233	ENSP00000245541	0	0	0	0	298	0	788	844
ENSP00000000233	ENSP00000263245	0	0	0	0	430	0	714	830
```

### Mapping file format:
```
STRING	Gene.name
ENSP00000397982	HLA-DBR1
ENSP00000343144	16/05/05
ENSP00000225928	17BHSDI
ENSP00000369600	214K23.2
```

The input mapping file can be obtained from filtering the mapping file available on [STRING-db](http://www.string-db.org)
using the following steps:
1. `awk '{print substr($1,6,15), $2, $3, $4, $5}' <Input Mapping File from String> > stringMapping.txt`

2. `grep "Blast_uniprot_gn" -i stringMapping.txt | awk 'BEGIN{OFS="\t"} {print $1, $2}' > mappingFile123.txt`
`
