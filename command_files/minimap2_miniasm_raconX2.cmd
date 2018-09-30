minimap2 -x ava-ont -t 16 {input.fastq} {input.fastq} | gzip -1 > minimap2.paf.gz
miniasm -f {input.fastq} minimap2.paf.gz > minimap2_miniasm.gfa
grep -Po '(?<=S\t)utg.+\s[ACTG]+' minimap2_miniasm.gfa | awk '{{print ">"$1"\\n"$2}}' | fold > minimap2_miniasm.fasta
minimap2 -x ava-ont -t 16 minimap2_miniasm.fasta {input.fastq} > minimap2_readsToContigs1.paf
racon -t 16 {input.fastq} minimap2_readsToContigs1.paf minimap2_miniasm.fasta > minimap2_miniasm_raconX1.fasta
minimap2 -x ava-ont -t 16 minimap2_miniasm_raconX1.fasta {input.fastq} > minimap2_readsToContigs2.paf
racon -t 16 {input.fastq} minimap2_readsToContigs2.paf minimap2_miniasm_raconX1.fasta > {output}
