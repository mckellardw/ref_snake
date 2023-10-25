# Build reference for minimap2
## Documentation: https://lh3.github.io/minimap2/minimap2.html
rule minimap2:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/minimap2/target.mmi" 
    threads:
        config["CORES"]
    log:
        "{OUTDIR}/{SPECIES}/minimap2/mm2.log" 
    run:
        shell(
            f"""
            {EXEC["MINIMAP2"]} -d {output.REF} {input.DNA} 2> {log}
            """
        )