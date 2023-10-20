# genomes

import pandas as pd

########################################################################################################
# Config file
########################################################################################################
configfile:'config.yaml'

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
        expand( # STAR reference
            "{OUTDIR}/{SPECIES}/STAR/Genome", 
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
include: "rules/0_gget_species.smk"
include: "rules/0_download.smk"
# include: "rules/0_install_execs.smk" #TODO
# include: "rules/1_bowtie.smk"
# include: "rules/1_kallisto.smk"
include: "rules/1_star.smk"

