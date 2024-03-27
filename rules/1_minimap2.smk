# Build reference for minimap2
## Documentation: https://lh3.github.io/minimap2/minimap2.html
rule minimap2:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/{BIOTYPE}.fa.gz",
    output:
        REF="{OUTDIR}/{SPECIES}/{BIOTYPE}/minimap2/target.mmi",
    threads: config["CORES"]
    log:
        log="{OUTDIR}/{SPECIES}/{BIOTYPE}/minimap2/mm2.log",
    run:
        shell(
            f"""
            {EXEC["MINIMAP2"]} \
                -d {output.REF} \
                {input.DNA} \
            2> {log.log}
            """
        )


# rule minimap2_transcriptome:
#     input:
#         DNA = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/cdna.fa.gz"
#     output:
#         REF = "{OUTDIR}/{SPECIES}/{BIOTYPE}/minimap2/target.mmi"
#     threads:
#         config["CORES"]
#     log:
#         log = "{OUTDIR}/{SPECIES}/{BIOTYPE}/minimap2/mm2.log"
#     run:
#         shell(
#             f"""
#             {EXEC["MINIMAP2"]} \
#                 -d {output.REF} \
#                 {input.DNA} \
#             2> {log.log}
#             """
#         )
