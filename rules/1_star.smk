# Build reference for STAR/STARsolo
rule star_genome:
    input:
        FA="{OUTDIR}/{SPECIES}/raw/genome.fa",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        GTF=temp("{OUTDIR}/{SPECIES}/raw/annotations.gtf"),
        REF="{OUTDIR}/{SPECIES}/genome/STAR/Genome",
    params:
        genomeSAindexNbases=lambda w: get_genomeSAindexNbases(w),
    threads: config["CORES"]
    run:
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
                --genomeSAindexNbases {params.genomeSAindexNbases}
            """
        )


# Build reference for STAR/STARsolo
rule star_genome_primary:
    input:
        FA="{OUTDIR}/{SPECIES}/raw/genome_primary.fa",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations_primary.gtf",
    output:
        # GTF=temp("{OUTDIR}/{SPECIES}/raw/annotations_primary.gtf"),
        REF="{OUTDIR}/{SPECIES}/genome_primary/STAR/Genome",
    params:
        genomeSAindexNbases=lambda w: get_genomeSAindexNbases(w),
    threads: config["CORES"]
    run:
        shell(
            f"""
            mkdir -p $(dirname {output.REF})

            {EXEC['STAR']} \
                --runMode genomeGenerate \
                --outTmpDir $(dirname {output.REF})/_STARtmp \
                --limitBAMsortRAM {config['MEMLIMIT']} \
                --runThreadN {threads} \
                --readFilesCommand zcat \
                --genomeDir $(dirname {output.REF}) \
                --genomeFastaFiles {input.FA} \
                --sjdbGTFfile {input.GTF} \
                --sjdbGTFfeatureExon exon \
                --genomeSAindexNbases {params.genomeSAindexNbases}
            """
        )


# rRNA-specific params
rule star_rRNA:
    input:
        FA="{OUTDIR}/{SPECIES}/rRNA/raw/ref.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/rRNA/raw/annotations.gtf.gz",
    output:
        REF="{OUTDIR}/{SPECIES}/rRNA/STAR/Genome",
    params:
        genomeSAindexNbases=lambda w: get_genomeSAindexNbases(w),
    threads: config["CORES"]
    run:
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
                --genomeSAindexNbases {params.genomeSAindexNbases}
            """
        )
