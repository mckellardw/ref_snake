
rule get_chrom_sizes:
    input:
        FAI="{OUTDIR}/{SPECIES}/raw/genome.fa.fai",
    output:
        CHRSIZES="{OUTDIR}/{SPECIES}/raw/chrom_sizes.tsv",
    run:
        shell(
            f"""
            cut -f1,2 {input.FAI} \
            | sort -V \
            > {output.CHRSIZES}
            """
        )


# Filter out chromosomes with periods in their names, to
# remove unlocalized/unplaced scaffolds from the reference
rule get_primary_chrom_info:
    input:
        CHRSIZES="{OUTDIR}/{SPECIES}/raw/chrom_sizes.tsv",
    output:
        CHRSIZES="{OUTDIR}/{SPECIES}/raw/chrom_primary_sizes.tsv",
        TXT="{OUTDIR}/{SPECIES}/raw/chrom_primary.txt",
    params:
        KEEP_REGEX="\.",
    threads: 1
    run:
        shell(
            f"""
            cut -f1,2  {input.CHRSIZES} | grep -v '{params.KEEP_REGEX}' > {output.CHRSIZES}
            cut -f1  {input.CHRSIZES} | grep -v '{params.KEEP_REGEX}' > {output.TXT}
            """
        )



# Get primary contigs
rule get_primary_contigs:
    input:
        FA="{OUTDIR}/{SPECIES}/raw/genome.fa",
        TXT="{OUTDIR}/{SPECIES}/raw/chrom_primary.txt",
    output:
        FA="{OUTDIR}/{SPECIES}/raw/genome_primary.fa",
    threads: 1
    run:
        shell(
            f"""            
            while read contig; do
                samtools faidx {input.FA} $contig >> {output.FA}
            done < {input.TXT}
            """
        )
        # awk -f scripts/awk/fa_filterContigs.awk {input.TXT} {input.FA} > {output.FA}

rule primary_annotations:
    input:
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
        TXT="{OUTDIR}/{SPECIES}/raw/chrom_primary.txt",
    output:
        GTF="{OUTDIR}/{SPECIES}/raw/annotations_primary.gtf.gz",
    params:
        KEEP_REGEX="\.",
    threads: 1
    shell:
        """
        zcat {input.GTF} \
        | grep -F -f <(awk '{{print $1}}' {input.TXT}) \
        | gzip \
        > {output.GTF}
        """


# bed-formatted annotations
rule call_paftools:
    input:
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        BED="{OUTDIR}/{SPECIES}/raw/annotations.bed",
    log:
        log="{OUTDIR}/{SPECIES}/logs/gff2bed.log",
    run:
        shell(
            f"""
            {EXEC['K8']} scripts/js/paftools.js gff2bed \
                -j {input.GTF} \
                > {output.BED} \
                2> {log.log}
            """
        )


rule reformat_gtf_to_tsv:
    input:
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
    output:
        TSV="{OUTDIR}/{SPECIES}/raw/{FEATURE}_info.tsv",
    log:
        log="{OUTDIR}/{SPECIES}/logs/{FEATURE}_info.log",
    threads: 1
    shell:
        """
        bash scripts/bash/gtf2tsv_info.sh {input.GTF} {wildcards.FEATURE} \
        > {output.TSV}
        """
