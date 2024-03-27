# Build reference for minimap2
## Documentation: https://lh3.github.io/minimap2/minimap2.html
rule bwa_mem2:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/{BIOTYPE}.fa.gz",
    output:
        FA="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz",
        AMB="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz.amb",
        ANN="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz.ann",
        BWT="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz.bwt.2bit.64",
        PAC="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz.pac",
        NUM="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz.0123",
    threads: config["CORES"]
    log:
        log="{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/index.log",
    run:
        shell(
            f"""
            mkdir -p $(dirname {output.FA})
            cp {input.DNA} {output.FA}

            {EXEC["BWA_MEM2"]} index \
                {output.FA} \
            2> {log.log}
            """
        )
        # -p {output.FA.strip('.gz')} \
        # -p $(dirname {output.REF}) \



# rule bwa_mem2_rRNA:
#     input:
#         DNA = "{OUTDIR}/{SPECIES}/rRNA/raw/ncrna.fa.gz"
#     output:
#         FA  = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.gz",
#         AMB = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/ncrna.fa.gz.amb",
#         ANN = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/ncrna.fa.gz.ann",
#         BWT = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/ncrna.fa.gz.bwt.2bit.64",
#         PAC = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/ncrna.fa.gz.pac",
#         NUM = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/ncrna.fa.gz.0123"
#     threads:
#         config["CORES"]
#     log:
#         log = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/index.log"
#     run:
#         shell(
#             f"""
#             cp {input.DNA} $(dirname {output.FA})
#             {EXEC["BWA_MEM2"]} index \
#                 {output.FA} \
#             2> {log.log}
#             """
#         )
# -p {output.FA.strip('.gz')} \
