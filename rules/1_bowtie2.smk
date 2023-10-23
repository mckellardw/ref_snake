# Build reference for bowtie2
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/bowtie2/TODO" 
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC["BOWTIE2"]} --help
            echo TODO
            """
        )