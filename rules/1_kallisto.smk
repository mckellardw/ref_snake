#TODO - modify to build refs just with kallisto, to avoid the heavy kallisto-bustools dependency

# Build reference for kallisto
rule kb:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = directory("{OUTDIR}/{SPECIES}/kb"),
        INDEX         = "{OUTDIR}/{SPECIES}/kb/transcriptome.idx",
        T2G           = "{OUTDIR}/{SPECIES}/kb/t2g.txt",
        cDNA_FASTA    = "{OUTDIR}/{SPECIES}/kb/cdna.fa"
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC['KB']} ref \
            -i {output.INDEX} \
            -g {output.T2G} \
            -f1 {output.cDNA_FASTA} \
            {input.DNA} {input.GTF}
            """
        )
            # pigz --decompress --force --keep -p{threads} {input.DNA} {input.GTF} 
            # rm {input.DNA.replace(".gz","")} {input.GTF.replace(".gz","")} 




# Buiild reference for RNA velocity inference w/ kallisto
rule kb_velocity:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz"
    output:
        REF = directory("{OUTDIR}/{SPECIES}/kb_velo"),
        INDEX         = "{OUTDIR}/{SPECIES}/kb_velo/transcriptome.idx",
        cDNA_FASTA    = "{OUTDIR}/{SPECIES}/kb_velo/cdna.fa",
        INTRON_FASTA  = "{OUTDIR}/{SPECIES}/kb_velo/intron.fa",
        cDNA_T2C      = "{OUTDIR}/{SPECIES}/kb_velo/cdna.t2c",
        INTRON_T2C    = "{OUTDIR}/{SPECIES}/kb_velo/t2g.txt",
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC['KB']} ref \
            -i {output.INDEX} \
            -g {output.T2G} \
            --workflow lamanno \
            -f1 {output.cDNA_FASTA} \
            -f2 {output.INTRON_FASTA} \
            -c1 ${output.cDNA_T2C} \
            -c2 ${output.INTRON_T2C} \
            {input.DNA} {input.GTF}
            """
        )