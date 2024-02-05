# Build reference for STAR/STARsolo
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/genome/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/genome/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/genome/STAR/Genome"
        # REFDIR = directory("{OUTDIR}/{SPECIES}/{BIOTYPE}/STAR"),
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            pigz \
                --decompress \
                --force \
                --keep \
                -p{threads} \
                {input.DNA} {input.GTF}

            mkdir -p $(dirname {output.REF})

            {EXEC['STAR']} \
                --runMode genomeGenerate \
                --outTmpDir $(dirname {output.REF})/_STARtmp \
                --limitBAMsortRAM {config["MEMLIMIT"]} \
                --runThreadN {threads} \
                --readFilesCommand zcat \
                --genomeDir $(dirname {output.REF}) \
                --genomeFastaFiles {input.DNA.replace(".gz","")} \
                --sjdbGTFfile {input.GTF.replace(".gz","")} \
                --sjdbGTFfeatureExon exon            
            """
        )
            # rm {input.DNA.replace(".gz","")} {input.GTF.replace(".gz","")} 
            #  --outTmpDir {OUTDIR}/{wildcards.SPECIES}/_STARtmp \

rule star_rRNA:
    input:
        DNA  = "{OUTDIR}/{SPECIES}/rRNA/raw/ncrna.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/rRNA/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/rRNA/STAR/Genome"
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            pigz \
                --decompress \
                --force \
                --keep \
                -p{threads} \
                {input.DNA} {input.GTF}

            mkdir -p $(dirname {output.REF})

            {EXEC['STAR']} \
                --runMode genomeGenerate \
                --outTmpDir $(dirname {output.REF})/_STARtmp \
                --limitBAMsortRAM {config["MEMLIMIT"]} \
                --runThreadN {threads} \
                --readFilesCommand zcat \
                --genomeDir $(dirname {output.REF}) \
                --genomeFastaFiles {input.DNA.replace(".gz","")} \
                --sjdbGTFfile {input.GTF.replace(".gz","")} \
                --sjdbGTFfeatureExon exon            
            """
        )