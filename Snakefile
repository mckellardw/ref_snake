# genomes

import pandas as pd

########################################################################################################
# Config file
########################################################################################################
configfile:'config.yml'

########################################################################################################
# Directories and locations
########################################################################################################
TMPDIR = config['TMPDIR']
OUTDIR = config['OUTDIR']

########################################################################################################
# Executables/aligners
########################################################################################################
EXEC = config['EXEC']
GGET_EXEC = config['GGET_EXEC']

SPECIES = config['SPECIES'].split()

########################################################################################################
rule all:
    input:
        # expand( #reference output for each species and tool combo
        #     '{OUTDIR}/{species}/{tool}',
        #     OUTDIR=config['OUTDIR'],
        #     TOOL=EXEC.keys(),
        #     SPECIES=SPECIES
        # ),
        expand( # pseudo-cellranger for raw genome files
            "{OUTDIR}/{SPECIES}/pseudo_cellranger/fasta/genome.fa", 
            OUTDIR=config["OUTDIR"],
            SPECIES=SPECIES
        ),
        expand( # kallisto-bustools reference(s)
            "{OUTDIR}/{SPECIES}/{WORKFLOW}/transcriptome.idx", 
            OUTDIR=config["OUTDIR"],
            WORKFLOW=["kb", "kb_velo", "kb_nuc"],
            SPECIES=SPECIES
        ),
        expand( # STAR reference
            "{OUTDIR}/{SPECIES}/STAR/Genome", 
            OUTDIR=config["OUTDIR"],
            SPECIES=SPECIES
        ),
        expand( # minimap2 index
            "{OUTDIR}/{SPECIES}/minimap2/target.mmi", 
            OUTDIR=config["OUTDIR"],
            SPECIES=SPECIES
        ),
        expand( # Raw data and metadata for each species
            "{OUTDIR}/{SPECIES}/raw/{FILES}", 
            OUTDIR=config["OUTDIR"],
            FILES = [
                'metadata.json',
                'genome.fa.gz',
                'cdna.fa.gz',
                'annotations.gtf.gz',
                'cds.fa.gz',
                'ncrna.fa.gz',
                'pep.fa.gz'
            ],
            SPECIES=SPECIES
        ),
        expand( # list of species supported by gget
            'resources/gget_species.txt'
        )

# import rules
## Pre-run set up
include: "rules/0_gget_species.smk"
include: "rules/0_download_raw.smk"

## Rules for each aligner
include: "rules/1_pseudo_cellranger.smk"
include: "rules/1_star.smk"
include: "rules/1_kallisto.smk"
# include: "rules/1_bowtie.smk"
include: "rules/1_minimap2.smk"

