# Prepare directory structured similarly to cellranger- used by wf-single-cell
rule pseudo_cellranger:
    input:
        DNA="{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        DNA_IDX="{OUTDIR}/{SPECIES}/raw/genome.fa.fai",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        REFDIR=directory("{OUTDIR}/{SPECIES}/genome/pseudo_cellranger"),
        DNA="{OUTDIR}/{SPECIES}/genome/pseudo_cellranger/fasta/genome.fa",
        DNA_IDX="{OUTDIR}/{SPECIES}/genome/pseudo_cellranger/fasta/genome.fa.fai",
        GTF="{OUTDIR}/{SPECIES}/genome/pseudo_cellranger/genes/genes.gtf",
    # wildcard_constraints:
    #     SPECIES = SPECIES_REGEX
    threads: 1
    shell:
        """
        mkdir -p {output.REFDIR}/fasta {output.REFDIR}/genes

        zcat {input.DNA} > {output.DNA}
        zcat {input.GTF} > {output.GTF}

        cp {input.DNA_IDX} {output.DNA_IDX}
        """

