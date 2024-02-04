# Build reference for minimap2
## Documentation: https://lh3.github.io/minimap2/minimap2.html
rule bwa_mem2:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz"
    output:
        FA = "{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.gz",
        # FILES = [
        #     f"{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.gz{FILE}" for 
        #         FILE in ['','.amb', '.ann', '.bwt.2bit.64', '.pac', '.0123']      
        # ]
        AMB = "{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.amb",
        ANN = "{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.ann",
        BWT = "{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.bwt.2bit.64",
        PAC = "{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.pac",
        NUM = "{OUTDIR}/{SPECIES}/bwa_mem2/genome.fa.0123"
    threads:
        config["CORES"]
    log:
        log = "{OUTDIR}/{SPECIES}/bwa_mem2/index.log" 
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