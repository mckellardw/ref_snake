# Build reference for STAR/STARsolo
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/STAR/Genome",
        REFDIR = directory("{OUTDIR}/{SPECIES}/STAR"),
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            pigz --decompress --force --keep -p{threads} {input.DNA} {input.GTF} 

            mkdir -p {output.REFDIR}

            {EXEC['STAR']} \
            --runMode genomeGenerate \
            --outTmpDir {output.REFDIR}/_STARtmp \
           --limitBAMsortRAM {config["MEMLIMIT"]} \
            --runThreadN {threads} \
            --readFilesCommand zcat \
            --genomeDir {OUTDIR}/{wildcards.SPECIES}/STAR \
            --genomeFastaFiles {input.DNA.replace(".gz","")} \
            --sjdbGTFfile {input.GTF.replace(".gz","")} \
            --sjdbGTFfeatureExon exon
            
            """
        )
            # rm {input.DNA.replace(".gz","")} {input.GTF.replace(".gz","")} 
            #  --outTmpDir {OUTDIR}/{wildcards.SPECIES}/_STARtmp \