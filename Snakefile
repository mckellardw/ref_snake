# genomes

import pandas as pd

########################################################################################################
# Directories and locations
########################################################################################################
TMPDIR = config['TMPDIR']
OUTDIR = config['OUTDIR']


########################################################################################################
# Executables
########################################################################################################
BWA_EXEC = config['BWA_EXEC']
STAR_EXEC = config['STAR_EXEC']
KALLISTO_EXEC = config['KALLISTO_EXEC']


########################################################################################################
rule all:
    input:
        expand( #reference output for each species and tool combo
            '{OUTDIR}/{species}/{tool}',
            OUTDIR=config['OUTDIR'],
            TOOL=TOOL,
            SPECIES=SPECIES
        )

# import rules
include: "rules/0_download.smk"
include: "1_bowtie.smk"
include: "1_kallisto.smk"
include: "1_star.smk"

#TODO
# ref genome stats?