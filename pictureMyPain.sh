cat data.csv | awk -F"," '$3>0{print $1}' > deadProjIDs
cat data.csv | awk -F"," '$3>0 && $6=="-"' | awk -F"-" '{print $2}' | awk -F"," '{print $(NF-1)}' > deadLastRejects
cat data.csv | awk -F"," '$3==0 && $6=="-"{print $1}' > failedProjIDs
cat data.csv | awk -F"," '$3==0 && $6=="-"' | awk -F"-" '{print $2}' | awk -F"," '{print $(NF-1)}' > failedLastRejects
paste -d ',' failedProjIDs failedLastRejects > failed.txt
paste -d ',' deadProjIDs deadLastRejects > dead.txt

gnuplot plot.plt
rm -rf failedProjIDs failedLastRejects deadLastRejects deadProjIDs failed.txt dead.txt    # cleans up all temporary files
