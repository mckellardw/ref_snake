# Build reference for bowtie2
rule bowtie2:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/{BIOTYPE}.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        REF="{OUTDIR}/{SPECIES}/{BIOTYPE}/bowtie2/TODO",
    threads: config["CORES"]
    run:
        shell(
            f"""
            {EXEC["BOWTIE2"]} --help
            echo TODO
            """
        )
