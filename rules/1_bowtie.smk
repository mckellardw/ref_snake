# Build reference for bowtie
## Manual: https://bowtie-bio.sourceforge.net/manual.shtml
rule bowtie:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/bowtie/TODO" 
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC["BOWTIE2"]} --help
            echo TODO
            """
        )