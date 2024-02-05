# Download the reference sequence and annotations
rule get_rRNA:
    input:
        cDNA  = "{OUTDIR}/{SPECIES}/genome/raw/ncrna.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/genome/raw/annotations.gtf.gz"
    output:
        cDNA  = "{OUTDIR}/{SPECIES}/rRNA/raw/ncrna.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/rRNA/raw/annotations.gtf.gz"
    threads:
        1
    run:
        # Extract rRNA sequences from cDNA/transcript fasta
        # Build custom gtf from the cDNA/transcript fasta
        shell(
            f"""
            mkdir -p $(dirname {output.cDNA})

            bash scripts/bash/extract_rRNA_fasta.sh \
                {input.cDNA} \
                {output.cDNA}
            
            bash scripts/bash/extract_rRNA_gtf.sh \
                {output.cDNA} \
                {output.GTF}
            """
        )