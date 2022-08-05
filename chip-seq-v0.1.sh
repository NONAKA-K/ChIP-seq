#code of converting fastq to bam
#v0.1 20220805
#Nonaka Kazuki
#Nagoya University Graduate school of science

ref=/home/takumi/out/GCA_000146045.2_R64_genomic.fna
for file in `ls *_1.fastq.gz`
do
    R1=$file
    R2=${file%_1.fastq.gz}_2.fastq.gz
    RP1=${file%_1.fastq.gz}_1fastp.fastq.gz
    RP2=${file%_1.fastq.gz}_2fastp.fastq.gz
    report=${file%_1.fastq.gz}.html
    out=${file%_1.fastq.gz}.bam
    fastp -i $R1 -I $R2 -o $RP1 -O $RP2 -h $report
    bwa mem -t8 $ref $RP1 $RP2 | samtools sort -@ 4 > $out 
    samtools index $out
done

