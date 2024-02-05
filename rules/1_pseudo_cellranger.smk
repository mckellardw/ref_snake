# Prepare directory structured similarly to cellranger- used by wf-single-cell
rule pseudo_cellranger:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/annotations.gtf.gz"
    output:
        REFDIR  = directory("{OUTDIR}/{SPECIES}/{BIOTYPE}/pseudo_cellranger"),
        DNA     = "{OUTDIR}/{SPECIES}/{BIOTYPE}/pseudo_cellranger/fasta/genome.fa",
        DNA_IDX = "{OUTDIR}/{SPECIES}/{BIOTYPE}/pseudo_cellranger/fasta/genome.fa.fai",
        GTF     = "{OUTDIR}/{SPECIES}/{BIOTYPE}/pseudo_cellranger/genes/genes.gtf"
    threads:
        1
    run:
        shell(
            f"""
            mkdir -p {output.REFDIR}
            mkdir -p {output.REFDIR}/fasta
            mkdir -p {output.REFDIR}/genes

            zcat {input.DNA} > {output.DNA}
            zcat {input.GTF} > {output.GTF}

            {EXEC['SAMTOOLS']} faidx {output.DNA}
            """
        )