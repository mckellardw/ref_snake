# Build reference for STAR/STARsolo
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/STAR/Genome" 
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            pigz -d --force -p{threads} {input.DNA} {input.GTF} 

            {EXEC['STAR']} \
            --runThreadN {threads} \
            --readFilesCommand zcat \
            --runMode genomeGenerate \
            --genomeDir {OUTDIR}/{SPECIES}/STAR \
            --genomeFastaFiles {input.DNA.replace(".gz","")} \
            --sjdbGTFfile {input.GTF.replace(".gz","")} \
            --sjdbGTFfeatureExon exon
            
            pigz --force -p{threads} {input.DNA.replace(".gz","")} {input.GTF.replace(".gz","")} 
            """
        )