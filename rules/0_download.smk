# Download the reference sequence(s) and annotation(s) for each species

rule download_ref_data:
    input:
       SPECIES_LIST = "resources/gget_species.txt"
    output:
        REF = expand("{OUTDIR}/{SPECIES}/raw/metadata.json", OUTDIR=config["OUTDIR"], SPECIES=SPECIES)
    threads:
        config["CORES"]
    log:
        f"{OUTDIR}/download.log"
    run:
        # from pandas import read_csv
        available_species = pd.read_csv(input.SPECIES_LIST, header=None)[0].values.tolist()
        
        for S in SPECIES:
            if S in available_species:
                print(f"Downloading genome sequence and annotations for {S} to {OUTDIR}/{S}")
                shell(
                    f"""
                    mkdir -p {OUTDIR}/{S}/raw
                    cd {OUTDIR}/{S}/raw

                    gget ref \
                    --out {OUTDIR}/{S}/raw/metadata.json \
                    --which gtf,dna \
                    --download \
                    {S}

                    
                    """
                    # gunzip {OUTDIR}/{S}/raw/*.gz
                )
            else:
                print(f"Species ({S}) not available from `gget`!")
                #TODO- add code to look for custom ref sequences here