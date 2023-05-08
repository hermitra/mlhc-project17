# set the directory where the files are located
directory="GWAS_result"

# iterate over all files in the directory
for file in "$directory"/$1.*.glm.linear; do
    # extract the feature name from the filename
    feature_name=$(echo "$file" | sed "s/.*${1}\.\(.*\)\.glm\.linear/\1/")
    
    # sort the file by the p-value column and filter rows by p-value
    awk -v feature="$feature_name" -v OFS='\t' 'NR==1 {print "feature", $0} $12<0.05 {print feature, $0}' "$file" | sort -k12,12g > "$file.tmp"
    
    # replace the original file with the modified file
    mv "$file.tmp" "$file"
done

# concatenate the modified files to a single output file
cat "$directory"/${1}.*.glm.linear > "$directory"/$1_output.tsv
rm "$directory"/${1}.*.glm.linear

