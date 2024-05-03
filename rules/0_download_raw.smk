# Download the reference metadata
rule get_ref_metadata:
    input:
        SPECIES_LIST="resources/gget_species.txt",
    output:
        METADATA="{OUTDIR}/{SPECIES}/raw/metadata.json",
    log:
        log="{OUTDIR}/{SPECIES}/raw/metadata.log",
    threads: 1
    retries: config["GGET_RETRIES"]
    run:
        available_species = pd.read_csv(input.SPECIES_LIST, header=None)[
            0
        ].values.tolist()
        S = wildcards.SPECIES

        if S in available_species:
            print(
                f"Downloading metadata for *{S}* to `{OUTDIR}/{S}/raw/metadata.json`..."
            )
            # --which: gtf,dna,cdna,cds,cdrna,pep
            shell(
                f"""
                mkdir -p $(dirname {output.METADATA})

                {EXEC['GGET']} ref \
                    --which all \
                    --out  {output.METADATA} \
                    {S} \
                    2> {log.log}
                """
            )
        else:
            print(f"Species ({S}) not available from `gget`!")
            # TODO- add code to look for custom ref sequences here
            # OR - build json with similar structure to gget output, to simplify workflow



# Download the reference sequence and annotations
rule get_ref_files:
    input:
        SPECIES_LIST="resources/gget_species.txt",
        METADATA="{OUTDIR}/{SPECIES}/raw/metadata.json",
    output:
        DNA="{OUTDIR}/{SPECIES}/raw/genome.fa.gz",
        cDNA="{OUTDIR}/{SPECIES}/raw/transcriptome.fa.gz",
        GTF="{OUTDIR}/{SPECIES}/raw/annotations.gtf.gz",
        CDS="{OUTDIR}/{SPECIES}/raw/cds.fa.gz",
        ncRNA="{OUTDIR}/{SPECIES}/raw/ncrna.fa.gz",
        PEP="{OUTDIR}/{SPECIES}/raw/pep.fa.gz",
    threads: 1
    retries: config["GGET_RETRIES"]
    run:
        import json

        S = wildcards.SPECIES

        available_species = pd.read_csv(input.SPECIES_LIST, header=None)[
            0
        ].values.tolist()
        file_dict = {
            "genome_dna": output.DNA,
            "transcriptome_cdna": output.cDNA,
            "annotation_gtf": output.GTF,
            "coding_seq_cds": output.CDS,
            "non-coding_seq_ncRNA": output.ncRNA,
            "protein_translation_pep": output.PEP,
        }

        if S in available_species:
            print(f"Downloading genome and annotations for *{S}* to `{OUTDIR}/{S}/raw`...")

        meta = json.load(open(input.METADATA))[wildcards.SPECIES]

        for key, value in file_dict.items():
            shell(f"curl -o {value} {meta[key]['ftp']}")
        else:
            print("TODO")
            # Format stuff for custom refs here...


