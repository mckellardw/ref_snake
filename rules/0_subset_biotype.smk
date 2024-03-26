# Download the reference sequence and annotations
## Extract rRNA sequences from cDNA/transcript fasta
## Build custom gtf from the cDNA/transcript fasta
rule get_rRNA:
    input:
        FA  = OUTDIR+"/{SPECIES}/raw/ncrna.fa.gz",
        GTF = OUTDIR+"/{SPECIES}/raw/annotations.gtf.gz",
    output:
        REF = OUTDIR+"/{SPECIES}/raw/rRNA.fa.gz",
        FA  = OUTDIR+"/{SPECIES}/rRNA/raw/ref.fa.gz",
        GTF = OUTDIR+"/{SPECIES}/rRNA/raw/annotations.gtf.gz",
    threads:
        1
    run:
        shell(
            f"""
            mkdir -p $(dirname {output.FA})

            bash scripts/bash/extract_rRNA_fasta.sh \
                {input.FA} \
                {output.FA}
            
            bash scripts/bash/extract_rRNA_gtf.sh \
                {output.FA} \
                {output.GTF}

            cp {output.FA} {output.REF}
            """
        )
