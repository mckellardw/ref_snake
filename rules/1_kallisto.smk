# Build reference for kallisto
## https://www.kallistobus.tools/kb_usage/kb_ref/
rule kb:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        IDX="{OUTDIR}/{SPECIES}/transcriptome/kb/transcriptome.idx",
        T2G="{OUTDIR}/{SPECIES}/transcriptome/kb/t2g.txt",
        cDNA_FA="{OUTDIR}/{SPECIES}/transcriptome/kb/cdna.fa",
    params:
        KALLISTO=EXEC["KALLISTO"],
        KB=EXEC["KB"],
    log:
        log="{OUTDIR}/{SPECIES}/transcriptome/kb/kb_ref.log",
    threads: config["CORES"]
    # resources:
    #     mem_mb=config["MEMLIMIT"]/1000000
    conda:
        f"{workflow.basedir}/envs/kb.yml"
    shell:
        """
        mkdir -p $(dirname {output.IDX})
        
        {params.KALLISTO} version > {log.log}

        {params.KB} ref \
            --kallisto {params.KALLISTO} \
            --tmp $(dirname {output.IDX})/tmp \
            -i {output.IDX} \
            -g {output.T2G} \
            -f1 {output.cDNA_FA} \
            {input.DNA} {input.GTF} \
        2>> {log.log}
        
        ls -a $(dirname {output.IDX}) >> {log.log}
        """



# Build reference for RNA velocity inference w/ kallisto
rule kb_velocity:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        IDX="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/transcriptome.idx",
        T2G="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/t2g.txt",
        cDNA_FA="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/cdna.fa",
        INTRON_FA="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/intron.fa",
        cDNA_T2C="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/cdna.t2c",
        INTRON_T2C="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/intron.t2c",
    params:
        KALLISTO=EXEC["KALLISTO"],
        KB=EXEC["KB"],
    log:
        log="{OUTDIR}/{SPECIES}/transcriptome/kb_velo/kb_ref.log",
    threads: config["CORES"]
    conda:
        f"{workflow.basedir}/envs/kb.yml"
    shell:
        """
        mkdir -p $(dirname {output.IDX})
        
        {params.KALLISTO} version > {log.log}

        {params.KB} ref \
            --verbose \
            --kallisto {params.KALLISTO} \
            --tmp $(dirname {output.IDX})/tmp \
            -i {output.IDX} \
            -g {output.T2G} \
            --workflow lamanno \
            -f1 {output.cDNA_FA} \
            -f2 {output.INTRON_FA} \
            -c1 {output.cDNA_T2C} \
            -c2 {output.INTRON_T2C} \
            {input.DNA} {input.GTF} \
        2>> {log.log}

        ls -a $(dirname {output.IDX}) >> {log.log}
        """


# Build reference for RNA velocity inference w/ kallisto
rule kb_nucleus:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        IDX="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/transcriptome.idx",
        T2G="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/t2g.txt",
        cDNA_FA="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/cdna.fa",
        INTRON_FA="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/intron.fa",
        cDNA_T2C="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/cdna.t2c",
        INTRON_T2C="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/intron.t2c",
    params:
        KALLISTO=EXEC["KALLISTO"],
        KB=EXEC["KB"],
    log:
        log="{OUTDIR}/{SPECIES}/transcriptome/kb_nuc/kb_ref.log",
    threads: config["CORES"]
    conda:
        f"{workflow.basedir}/envs/kb.yml"
    shell:
        """
        mkdir -p $(dirname {output.IDX})
        
        {params.KALLISTO} version > {log.log}

        {params.KB} ref \
            --verbose \
            --kallisto {params.KALLISTO} \
            --tmp $(dirname {output.IDX})/tmp \
            -i {output.IDX} \
            -g {output.T2G} \
            --workflow nucleus \
            -f1 {output.cDNA_FA} \
            -f2 {output.INTRON_FA} \
            -c1 {output.cDNA_T2C} \
            -c2 {output.INTRON_T2C} \
            {input.DNA} {input.GTF} \
        2>> {log.log}

        ls -a $(dirname {output.IDX}) >> {log.log}
        """
