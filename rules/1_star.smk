# Build reference for STAR/STARsolo
rule star_genome:
    input:
        FA="{OUTDIR}/{SPECIES}/raw/genome.fa",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        GTF=temp("{OUTDIR}/{SPECIES}/raw/annotations.gtf"),
        REF="{OUTDIR}/{SPECIES}/genome/STAR/Genome",
    threads: config["CORES"]
    run:
        genomeSAindexNbases = 14
        # # biotype-specific params
        # if wildcards.BIOTYPE == "rRNA":
        #     if wildcards.SPECIES == "mus_musculus":
        #         genomeSAindexNbases=6
        #     elif wildcards.SPECIES == "homo_sapiens":
        #         genomeSAindexNbases=5
        # else: # standard genome ref

        shell(
            f"""
            pigz \
                --decompress \
                --force \
                --keep \
                -p{threads} \
                {input.GTF}

            mkdir -p $(dirname {output.REF})

            {EXEC['STAR']} \
                --runMode genomeGenerate \
                --outTmpDir $(dirname {output.REF})/_STARtmp \
                --limitBAMsortRAM {config['MEMLIMIT']} \
                --runThreadN {threads} \
                --readFilesCommand zcat \
                --genomeDir $(dirname {output.REF}) \
                --genomeFastaFiles {input.FA.replace('.gz','')} \
                --sjdbGTFfile {input.GTF.replace('.gz','')} \
                --sjdbGTFfeatureExon exon \
                --genomeSAindexNbases {genomeSAindexNbases}
            """
        )


# rRNA-specific params
rule star_rRNA:
    input:
        FA="{OUTDIR}/{SPECIES}/rRNA/raw/ref.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/rRNA/raw/annotations.gtf.gz",
    output:
        REF="{OUTDIR}/{SPECIES}/rRNA/STAR/Genome",
    threads: config["CORES"]
    run:
        if wildcards.SPECIES == "mus_musculus":
            genomeSAindexNbases = 6
        elif wildcards.SPECIES == "homo_sapiens":
            genomeSAindexNbases = 5

        shell(
            f"""
            pigz \
                --decompress \
                --force \
                --keep \
                -p{threads} \
                {input.FA} {input.GTF}

            mkdir -p $(dirname {output.REF})

            {EXEC['STAR']} \
                --runMode genomeGenerate \
                --outTmpDir $(dirname {output.REF})/_STARtmp \
                --limitBAMsortRAM {config['MEMLIMIT']} \
                --runThreadN {threads} \
                --readFilesCommand zcat \
                --genomeDir $(dirname {output.REF}) \
                --genomeFastaFiles {input.FA.replace('.gz','')} \
                --sjdbGTFfile {input.GTF.replace('.gz','')} \
                --sjdbGTFfeatureExon exon \
                --genomeSAindexNbases {genomeSAindexNbases}
            """
        )
