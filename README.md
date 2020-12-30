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
      - Create dosage files for each ancestry
      - Fit statistical models 
      - Run models 
      - Visualise with Manhattan plots 

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
**Therefore, all filtering for participants occur before merging, since we want to remove them from the begining and exclude them from analysis. 

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

**Therefore, all filtering for SNPs (markers) occur after merging of admixed and ancestral populations, since we want to include as much as possible SNPs to infer ancestry information. 

You should now have filtered binary files with both ancestral and admixed paticipants (.bed, .bim, .fam) and should be ready to infer ancestry with these files. 

## 05-Ancestry inference 
### a. Global Ancestry Inference 

You need prune the data before inferring global ancestry, since we only want the haplotypes in tight LD blocks. Therefore LD pruning will be conducted. 

```
plink --bfile inputfile --indep-pairwise 50 10 0.1 
```
Remove pruned.out file fom data. 

```
plink --bfile inputfile --extract plink.prune.in --make-bed --out outputfile 
```
Run ADMIXTURE software on filtered binary files. 

```
for k in {3..10}; do ../Software/admixture_linux-1.3.0/admixture --cv SAC_PAGE_1000G_geno05_maf003_unrelated_LD_pruned.bed ${k} -j4 | tee log${k}; done
```
Visulaise results with PONG. 
The following inputfiles are required: 

1. pong_filemap
2. pop_order
3. ind2pop

Run pong software: 

```
pong -m pong_filemap -n pop_order -i pop_ids
```
**The global ancestry results obtained from this step is crucial to examine if the correct reference/ancestral populations are used for ancestry inference, since local ancestry dosage files will require these populations to determine allele dosages for ancestries, which are then included as covariates in statistical models. 

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
*_This will generate the allele_info file required for the LAAA model_*

Addtional modifications to generate allele input information for LAAA model.

Cut out first 5 columns: 
```
cut -d " " -f 6- inputfile.haps > outputfile.haps 
```
**It is important to make sure the dimensions corresponds to the dimensions in the .msp.tsv file**

Take out the spaces between the zeros and ones: 
```
sed 's/ //g' inputfile.haps > outputfiles.haps 
```
*File is ready to be used in LAAA models*

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

1. rfmix.Q
2. sis.tsv
3. msp.tsv - using this file for LAAA model, provides ancestry per allele
4. fb.tsv

*Additional modifications for inputfiles for LAAA model to provide ancestry information. You need to make a .msp.tsv for all five ancestries, therefore the ancestry of interest is coded as 1 and all the other ancestries are coded as 0. As well as indicating all the genomic regions per file, since RFMix provides only the collapsed files, which does not contain all the genomic positions* 
 

## 06 - Local ancestry adjusted association models 

This pipeline is adapted from the one described in https://ncbi.nlm.gov/pmc/articles/PMC5851818. Note the statistical model described in the LAAA model counts the number of copies of the reference allele, but in the software implementation, the number of copies of the alternate allele (which is more likely to be of interest) is counted. 
Steps: 

1. Create dosage files for each ancestry 
2. Fit statistical models
3. Run models 
4. Use STEAM to permute data to determine significance theshold 
5. Summarise and visualise results 

#### 01-Create dosage files: 

Inputfiles required in order to run ```create_dose_frame.py``` 

1. Allele information files obtained from phasing (.haps file)
2. RFMix Viterbri (.msp.tsv) output file modified for each ancestry
3. SNP info file - (base pair position; ref allele; alt allele)
4. Sample ID info file - List of sample IDs in a single column 
5. Begin genomic position 
6. End genomic position 

Script used to modify the RFMix Viterbri file to use in the LAAA model ```Make_of_viterbi_files.R```.

Cut out header and first 3 columns of viterbri file. 
```
sed '1d' inputfile | cut -f 4- > outputfile
```
Make SNP info file. 
```
for i in {1..22}; do awk '{print $3, $4, $5}' SAC_1000G_filtered_chr${i}_phased > /home/yolandi01/05-LAAA_model/01-Make_dosage_files/SNP_info_file_chr${i} ; done 
```

Output three important files for each ancestry required for statistical analysis: 

1. ancestry dose file (0 = other ancestry, 1 = ancestry of interest)
2. allele dose file (0 = major allele, 1 = minor allele)
3. ancestry + alelle dose file (0 = Minor allele + ancestry not on the same haplotype; 1 = Minor allele + ancestry are on the same haplotype)

***Need to obtain all three files for each ancestry***


#### 02-Fit statistical models 

The script specifying the model ```models.R``` should be updated to the statistical model of interest. The covariate list should always include the correction for genome-wide ancestry propotions. This file needs to be updated according to your data and confounding factors. 


**We are specifying 4 different models with ```models.R```:** 

1. **Null model:** _glm_(trait ~ age + gender + genome-wide ancestry proportions)
2. **Allele model:** _glm_(trait ~ age + gender + genome-wide ancestry proportions + allele_dose)
3. **Ancestry model:** _glm_(trait ~ age + gender + genome-wide ancestry proportions + ancestry_dose)
4. **LAAA model:** _glm_(trait ~ age + gender + genome-wide ancestry proportions + allele_dose + ancestry_dose + allele_ancestry_dose)


#### 03-Run the models 

Modify the input and output files as needed in ```run_models.R``` script used to run the models. 
You also require a file containing all the phenotype information of your cohort. 

Command used to run ```run_models.R```. 



**Output variables file:**

The following output are obtained after running your statistical models: 



The **anova_p** value in the last column gives us the significant value when the LAAA model is compared to the null model. This will give us an indication if the LAAA model significantly improved when adjusting for both the allele and ancestry dose at the same time, compared to not adjusting for the allele and ancestry dose. 

#### 04-Determine significance threshold with ```STEAM```





