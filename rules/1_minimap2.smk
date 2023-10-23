# Build reference for minimap2
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/minimap2/TODO" 
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC["MINIMAP2"]} --help
            echo TODO
            """
        )