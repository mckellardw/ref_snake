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
        expand(
            "{OUTDIR}/{SPECIES}/raw/metadata.json", 
            OUTDIR=config["OUTDIR"], 
            SPECIES=SPECIES
        ),
        expand( # list of species supported by gget
            'resources/gget_species.txt'
        )

# import rules
include: "rules/0_gget_species.smk"
include: "rules/0_download.smk"
# include: "rules/0_install_execs.smk" #TODO
# include: "1_bowtie.smk"
# include: "1_kallisto.smk"
# include: "1_star.smk"

