# Build reference for STAR/STARsolo

rule star:
    input:
        FASTAS = expand(),
        GTFS =  expand()
    output:
        # REF_METADATA = expand("{REFDIR}/{SPECIES}/STAR/metadata.json", REFDIR=config["REFDIR"], SPECIES=SPECIES),
        REF = expand("{REFDIR}/{SPECIES}/STAR/Genome", REFDIR=config["REFDIR"], SPECIES=SPECIES) # Reference genomes
    threads:
        config["CORES"]
    run:
        shell(
            f"""
            {EXEC['star']} \
            --runThreadN {threads} \
            --runMode genomeGenerate \
            --genomeDir {REFDIR}/{S}/STAR \
            --genomeFastaFiles $(ls -t {REFDIR}/{S}/*.fa) \
            --sjdbGTFfile $(ls -t {REFDIR}/{S}/*.gtf) \
            --sjdbGTFfeatureExon exon

            pigz -p {threads} $(ls -t {REFDIR}/{S}/*.fa)
            pigz -p {threads} $(ls -t {REFDIR}/{S}/*.gtf)
            """
        )