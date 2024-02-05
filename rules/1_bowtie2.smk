# Build reference for bowtie2
rule bowtie2:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/{BIOTYPE}/bowtie2/TODO" 
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC["BOWTIE2"]} --help
            echo TODO
            """
        )