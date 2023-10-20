# Build reference for STAR/STARsolo
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf"
    output:
        REF = "{OUTDIR}/{SPECIES}/STAR/Genome" 
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC['star']} \
            --runThreadN {threads} \
            --runMode genomeGenerate \
            --genomeDir {OUTDIR}/{SPECIES}/STAR \
            --genomeFastaFiles {input.DNA} \
            --sjdbGTFfile {input.GTF} \
            --sjdbGTFfeatureExon exon
            """
        )