# Download the reference sequence(s) and annotation(s) for each species

rule download_ref_data:
    output:
        # REF_METADATA = expand("{REFDIR}/{SPECIES}/STAR/metadata.json", REFDIR=config["REFDIR"], SPECIES=SPECIES),
        REF = expand("{REFDIR}/{SPECIES}/STAR/Genome", REFDIR=config["REFDIR"], SPECIES=SPECIES) # Reference genomes
    threads:
        config["CORES_HI"]
    run:
        #TODO- import error from gget python module, although the command line tool works? Seems like it is a
        # from gget import ref
        # available_species = ref(species="NA", list_species=True)
        shell("{GGET_EXEC} ref -l > resources/gget_species.txt")

        from pandas import read_csv
        available_species = read_csv("resources/gget_species.txt",header=None)[0].values.tolist()

        for S in SPECIES:
            if S in available_species:
                print(f"Downloading genome sequence and annotations for {S} to {REFDIR}/{S}")
                shell(
                    f"""
                    mkdir -p {REFDIR}/{S}
                    cd {REFDIR}/{S}

                    {GGET_EXEC} ref \
                    --out {REFDIR}/{S}/metadata.json \
                    --which gtf,dna \
                    --download \
                    {S}

                    gunzip {REFDIR}/{S}/*.gz
                    """
                )