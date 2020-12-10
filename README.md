# Ancestry inference pipeline 
Local Ancestry Adjusted Association model

These scripts and notes are intended to infer ancestry and perform ancestry-specific associations in a five-way admixed South African population from genotypic data. 

Example data is genotyped on the Illumina MEGA array (~1.7M markers). 420 TB cases and 419 healthy controls. 

## Steps for analysis 

1. Initial quality control (PLINK)
2. Relatedness estimation (KING)
3. Merging of datasets (PLINK)
4. Post merge quality control (PLINK)
5. Ancestry inference, which consists of two steps: 
  a. Global ancestry inference 
      - LD prune 
      - Run ADMIXTURE 
      - Visualize with PONG 
  b. Local ancestry inference 
      - Phase data with SHAPEIT2 - .haps.haps file provide allele information required for LAAA model 
      - Run RFMix - .msp.tsv file provide ancestry information required for LAAA model
      - Collapse into BED files 
      - Visualize karyogams 
 6. Local Ancestry Association Adjusted models (LAAA model) 

### Software required for analysis 

- PLINK 
- KING 
- SHAPEIT2 
- ADMIXTURE
- PONG 
- RFMix
- STEAM


## 01-Initial quality control 
Remove any individual missingness of individuals, any SNPs that were in HWE and remove chromosome 23 before merging with ancestral population. 
Check for any phenotypic information of population under investigation, in order to remove any indivual who are either < 18 of age or have any missing phenotypic      information, such as age or sex or disease status. 

```
plink --bfile filename --mind 0.1 --hwe 0.05 -chr1-22 --make-bed --out outputfile
```
*Therefore, all filtering for participants occur before merging, since we want to remove them from the begining and exclude them from analysis. 

## 02-Relatedness estimation 
We need to check and remove related indivduals before merging with ancestral populations. The software KING and kinship coefficient is sufficient to identify close relationships between participants who have extensive population strcuture. 
Usually up to 2nd Degree relatedness, indicated by a kinship coefficient of 0.0884-0.177.  

```
king -b inputfile.bed --kinship --degree2 --prefix outputfile
```
Make a file with related individuals and remove. 

```
plink --bfile inputfile --remove related_individuals_file --make-bed --out outputfile
```

## 03-Merge datasets 
Merge the ancestral binary files (.bed, .bim, .fam) with the admixed binary files (.bed, .bim, .fam) in order to conduct ancestry inference. The choice of ancestral populations are a crucial step for ancestry inference, therefore make sure populations are included that most likely contributed to the admixed population under study. 

```
plink --bfile inputfile.bed inputfile.bim inputfile.fam --bmerge reference.bed reference.bim reference.fam --make-bed --out
```
Usual errors with merge are: 

  1. Flipstrand - usually the case if not, remove the variants
  2. Remove variants to to having 3+ alleles 
  
## 04-Filtering after merging 
Remove any SNPs (markers) with a 5% missingness and filter out any minor allele frequencies (MAF). This will all depend on your sample size, since filteirng out MAF improves power to detect significant associations by removing unneccessary SNPs that will only be "noise". 

```
plink --bfile inputfile --geno 0.5 --maf 0.03 --make-bed --out outputfile 
```

*Therefore, all filtering for SNPs (markers) occur after merging of admixed and ancestral populations, since we want to include as much as possible SNPs to infer ancestry information. 

You should now have filtered binary files with both ancestral and admixed paticipants (.bed, .bim, .fam) and should be ready to infer ancestry with these files. 

## 05-Ancestry inference 
### a. Global Ancestry Inference 






### b. Local Ancestry Inference 
A recombination map are used to phase data, therefore inferring where each allele came from which parent. We are using the African American genetic map build 37. This map was based on data from the HapMap consortium and includes genetic data from individuals with 80% West African ancestry and 20% European ancestry. 
*Important aspect to keep in mind is that phasing of data is quiet time consuming. 

#### Prepare inputfiles for RFMix 

1. Split data into individual chromosomes before starting phasing.  
```
for i in {1..22}; do plink --bfile inputfile --chr ${i} --make-bed --out outputfile.chr${i}; done 
```
2. Phase each chromosome separately with ```SHAPEIT2```. 
```
shapeit --input-bed inputfile.bed inputfile.bim inputfile.fam --input-map recombinationmap ouput-max outputfile.haps 
```
3. Split phased files into reference and admixed populations using ```split_phased.py```
```
python split_phased.py --haps inputfile.haps --sample inputfile.sample --fam inputfile.fam --out outputfile 
```
*_This will generate the allele_info file required for the LAAA model_


4. Convert phased binary files back to vcf format 
```
shapeit -convert --input-haps inputfile.haps --output-vcf outputfile.vcf 
```
5. Prepare reference and query vcf files required for RFMix. 
```
vcftools --vcf inputfile.vcf --keep query_individuals.txt --recode --out outputfile_query.vcf
vcftools --vcf inputfile.vcf --keep reference_individuals.txt --recode --out outputfile_query.vcf 
```

#### Run RFMix. 
We used default paramters with 15 generations since admixture occurred for our specific cohort.  
```
rfmix -f inputfile_query.vcf -r inputfile_reference.vcf -m sample_map_SAC -g geneticmap -n 4 -G 15 -e 3 -o outputfile --chromosome 
```

#### Outputfiles RFMix

1. 








