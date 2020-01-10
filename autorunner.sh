for file in *.fastq;
do
  	    sam=${file//.fastq/.sam}
        bam=${file//.fastq/.bam}
        dups_out=${bam//.bam/.rmdup.bam}
        sorted=${dups_out//.rmdup.bam/.rmdup.sorted.bam}
        stats=${file//.fastq/_mappingstats.txt}

        bowtie2 -x $2 -U $file -S $sam
        samtools view -Sb $sam > $bam
        samtools rmdup $bam $dups_out
        samtools sort $dups_out ${sorted//.bam}
        samtools index $sorted
        samtools flagstat $sorted > $stats
done
