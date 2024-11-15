expand( # Raw data and metadata for each species
    "{OUTDIR}/{SPECIES}/raw/{FILE}", 
    OUTDIR=config["OUTDIR"],
    FILE = [
        "metadata.json",
        "genome.fa.gz",
        "genome.fa.fai",
        "transcriptome.fa.gz",
        "annotations.gtf.gz",
        "annotations.bed",
        "cds.fa.gz",
        "ncrna.fa.gz",
        "pep.fa.gz",
        "chrom_sizes.tsv",
        "gene_info.tsv",
        "transcript_info.tsv",
        # "rRNA.fa.gz"
    ],
    SPECIES=SPECIES
),



rule prep_custom_ref:
    input:
        CUSTOM_SPECIES_LIST="resources/custom_species.txt",
        SAMPLE_SHEET=get_custom_species_sheet(),
    output:
        DNA="{OUTDIR}/{CUSTOM_SPECIES}/raw/genome.fa.gz",
        cDNA="{OUTDIR}/{CUSTOM_SPECIES}/raw/transcriptome.fa.gz",
        GTF="{OUTDIR}/{CUSTOM_SPECIES}/raw/annotations.gtf.gz",
        # CDS="{OUTDIR}/{CUSTOM_SPECIES}/raw/cds.fa.gz",
        # ncRNA="{OUTDIR}/{CUSTOM_SPECIES}/raw/ncrna.fa.gz",
        # PEP="{OUTDIR}/{CUSTOM_SPECIES}/raw/pep.fa.gz",
    log:
        log="{OUTDIR}/{SPECIES}/raw/metadata.log",
    threads: 1
    run:
        # concatenate genome(s)

        # concatenate transcriptome(s)

        # concatenate gtf(s)
        