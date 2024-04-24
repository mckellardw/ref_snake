# ref_snake
import pandas as pd

########################################################################################################
# Config file
########################################################################################################
configfile:"config/config.yml"

########################################################################################################
# Directories and locations
########################################################################################################
TMPDIR = config["TMPDIR"]
OUTDIR = config["OUTDIR"]

########################################################################################################
# Executables & params
########################################################################################################
EXEC    = config["EXEC"]
SPECIES = config["SPECIES"].split()

########################################################################################################
# Rules
########################################################################################################
## Pre-run set up
include: "rules/0_gget_species.smk"
include: "rules/0_download_raw.smk"
include: "rules/0_subset_biotype.smk"

## Rules for each aligner
include: "rules/1_pseudo_cellranger.smk"
include: "rules/1_star.smk"
include: "rules/1_kallisto.smk"
# include: "rules/1_bowtie.smk"
include: "rules/1_bwa.smk"
include: "rules/1_minimap2.smk"

########################################################################################################
# Wildcard constraints
########################################################################################################
wildcard_constraints:
    SPECIES = r"[a-z_]+",
    BIOTYPE = r"[a-zA-Z]+",
    OUTDIR  = config["OUTDIR"]

########################################################################################################
# Target files
########################################################################################################
rule all:
    input:
        expand( # pseudo-cellranger for raw genome files
            "{OUTDIR}/{SPECIES}/{BIOTYPE}/pseudo_cellranger/fasta/genome.fa", 
            OUTDIR=config["OUTDIR"],
            BIOTYPE=["genome"],
            SPECIES=SPECIES
        ),
        expand( # kallisto-bustools reference(s)
            "{OUTDIR}/{SPECIES}/{BIOTYPE}/{WORKFLOW}/transcriptome.idx", 
            OUTDIR=config["OUTDIR"],
            WORKFLOW=["kb", "kb_velo", "kb_nuc"],
            BIOTYPE=["transcriptome"],
            SPECIES=SPECIES
        ),
        expand( # STAR reference
            "{OUTDIR}/{SPECIES}/{BIOTYPE}/STAR/Genome", 
            OUTDIR=config["OUTDIR"],
            BIOTYPE=["genome","rRNA"],
            SPECIES=SPECIES
        ),
        expand( # minimap2 index
            "{OUTDIR}/{SPECIES}/{BIOTYPE}/minimap2/target.mmi", 
            OUTDIR=config["OUTDIR"],
            BIOTYPE=["genome", "transcriptome"],
            SPECIES=SPECIES
        ),
        expand( # bwa-mem2 index
            "{OUTDIR}/{SPECIES}/{BIOTYPE}/bwa_mem2/ref.fa.gz{FILE}",
            OUTDIR=config["OUTDIR"],
            BIOTYPE=["genome","transcriptome","rRNA"],
            FILE = [".amb", ".ann", ".bwt.2bit.64", ".pac", ".0123"],
            SPECIES=SPECIES
        ),
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
        expand( # Raw data and metadata for each biotype
            "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/{FILE}", 
            OUTDIR=config["OUTDIR"],
            FILE = [
                "ref.fa.gz",
                "annotations.gtf.gz"
            ],
            BIOTYPE=["rRNA"], #TODO- miRNA, tRNA, etc.
            SPECIES=SPECIES
        ),
        [ # list of species supported by gget
            "resources/gget_species.txt"
        ]