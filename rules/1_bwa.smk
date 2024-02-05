# Build reference for minimap2
## Documentation: https://lh3.github.io/minimap2/minimap2.html
rule bwa_mem2:
    input:
        DNA = "{OUTDIR}/{SPECIES}/genome/raw/genome.fa.gz"
    output:
        FA  = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/genome.fa.gz",
        AMB = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/genome.fa.amb",
        ANN = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/genome.fa.ann",
        BWT = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/genome.fa.bwt.2bit.64",
        PAC = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/genome.fa.pac",
        NUM = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/genome.fa.0123"
    threads:
        config["CORES"]
    log:
        log = "{OUTDIR}/{SPECIES}/genome/bwa_mem2/index.log" 
    run:
        shell(
            f"""
            cp {input.DNA} $(dirname {output.FA})

            {EXEC["BWA_MEM2"]} index \
                -p {output.FA.strip('.gz')} \
                {output.FA} \
            2> {log.log}
            """
        )        
                # -p $(dirname {output.REF}) \


rule bwa_mem2_rRNA:
    input:
        DNA = "{OUTDIR}/{SPECIES}/rRNA/raw/ncrna.fa.gz"
    output:
        FA  = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.gz",
        AMB = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.amb",
        ANN = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.ann",
        BWT = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.bwt.2bit.64",
        PAC = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.pac",
        NUM = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/genome.fa.0123"
    threads:
        config["CORES"]
    log:
        log = "{OUTDIR}/{SPECIES}/rRNA/bwa_mem2/index.log" 
    run:
        shell(
            f"""
            cp {input.DNA} $(dirname {output.FA})

            {EXEC["BWA_MEM2"]} index \
                -p {output.FA.strip('.gz')} \
                {output.FA} \
            2> {log.log}
            """
        )     