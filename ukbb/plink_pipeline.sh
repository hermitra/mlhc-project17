## Start interactive session and load plink2
srun --pty bash -i
ml load plink2

## Convert exome pfile to bfile
plink2 --pgen ukb_exome200k.pgen --pvar ukb_exome200k.annot.pvar.gz --psam ukb_exome200k.psam --make-bed --out ~/data/ukbb/ukb_exome200k

## Extract all SNPs associated with Tx Hallmark genes using variant_id
/net/bmc-lab5/data/kellis/group/tanigawa/software/plink2/20230329/plink2 --bfile ukb_exome200k --extract ~/files/tx_id.txt --make-bed --out tx_exome

## Match phenotype eid with genotype iid
{head -n 1 ukb48826.txt && awk 'FNR==NR{a[$2];next}($1 in a)' tx_exome.fam ukb48826.txt; } > tx_ukb48826.txt

## Extract subset SNPs associated with each Tx Subgroup
for file_path in ~/code/tx_ids/*; do plink2 --bfile ../ukb_exome200k --extract $file_path --make-bed --out $(echo "$file_path" | sed 's|.*/\(.*\)\..*|\1|') ; done

## filter for sample IDs that have phenotype data in `ukb_clean.tsv`
## ukb_clean.tsv is obtained from tx_ukb48826.txt where we only kept rows without NaN values
awk 'FNR==NR{a[$1]=$1;next}($2 in a)' <(cut -f1 ukb_clean.tsv) tx_exome.fam > keep.fam

## extract genotype data for each Tx subgroup and keep only individuals with phenotype data
cat tx_groups_exomes/groups.txt | while read f; do plink2 --bfile ukb_exome200k --extract ~/code/tx_ids/${f}_tx_id.txt --keep keep.fam --make-bed --out ${f}_subset; done

## Perform GWAS analysis
cat tx_groups_exomes/groups.txt | while read f; do plink2 --bfile ${f}_subset --pheno ukb_clean.tsv --glm allow-no-covars --out GWAS_result/${f}; done

## Filter for associations with p-val < 0.05 and concatenate to one file per group, with additional column ‘feature’
cat tx_groups_exomes/groups.txt | while read f; do sh concat.sh $f; done