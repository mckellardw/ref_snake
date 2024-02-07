# Download the reference metadata
rule get_ref_metadata:
    input:
        SPECIES_LIST = "resources/gget_species.txt"
    output:
        METADATA = "{OUTDIR}/{SPECIES}/genome/raw/metadata.json"
    log:
        log = "{OUTDIR}/{SPECIES}/genome/raw/metadata.log"
    threads:
        1
    run:
        available_species = pd.read_csv(input.SPECIES_LIST, header=None)[0].values.tolist()
        S = wildcards.SPECIES

        if S in available_species:
            print(f"Downloading metadata for *{S}* to `{OUTDIR}/{S}/raw/metadata.json`...")
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
            #TODO- add code to look for custom ref sequences here
            #OR - build json with similar structure to gget output, to simplify workflow


# Download the reference sequence and annotations
rule get_ref_files:
    input:
        SPECIES_LIST = "resources/gget_species.txt",
        METADATA = "{OUTDIR}/{SPECIES}/genome/raw/metadata.json"
    output:
        DNA   = "{OUTDIR}/{SPECIES}/genome/raw/genome.fa.gz",
        cDNA  = "{OUTDIR}/{SPECIES}/genome/raw/cdna.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/genome/raw/annotations.gtf.gz",
        CDS   = "{OUTDIR}/{SPECIES}/genome/raw/cds.fa.gz",
        ncRNA = "{OUTDIR}/{SPECIES}/genome/raw/ncrna.fa.gz",
        PEP   = "{OUTDIR}/{SPECIES}/genome/raw/pep.fa.gz"
    threads:
        1
    run:
        import json

        available_species = pd.read_csv(input.SPECIES_LIST, header=None)[0].values.tolist()
        file_dict = {
            'genome_dna':output.DNA,
            'transcriptome_cdna':output.cDNA, 
            'annotation_gtf':output.GTF, 
            'coding_seq_cds':output.CDS, 
            'non-coding_seq_ncRNA':output.ncRNA, 
            'protein_translation_pep':output.PEP
        }

        S = wildcards.SPECIES
        
        if S in available_species:
            print(f"Downloading genome and annotations for *{S}* to `{OUTDIR}/{S}/raw`...")
            meta = json.load(open(input.METADATA))[wildcards.SPECIES]

            for key, value in file_dict.items():
                shell(f"curl -o {value} {meta[key]['ftp']}")
        else:
            print("TODO")
            # FOrmat stuff for custom refs here...


rule gunzip_genome:
    input:
        DNA = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa.gz"
    output:
        DNA = temp("{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa")
    run:
        shell(
            f"""
            pigz -d {input.DNA} 
            """
        )

rule index_genome:
    input:
        DNA = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa"
    output:
        FAI = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa.fai"
    run:
        shell(
            f"""
            {EXEC['SAMTOOLS']} faidx {input.DNA}
            """
        )


rule get_chrom_sizes:
    input:
        FAI = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa.fai"
    output:
        CHRSIZES="{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/chrom_sizes.tsv"
    run:
        shell(
            f"""
            cut -f1,2 {input.FAI} \
            | sort -V \
            > {output.CHRSIZES}
            """
        )

rule call_paftools:
    input:
        GTF = "{OUTDIR}/{SPECIES}/genome/raw/annotations.gtf.gz"
    output:
        BED = "{OUTDIR}/{SPECIES}/genome/raw/annotations.bed"
    log:
        log = "{OUTDIR}/{SPECIES}/genome/logs/gff2bed.log"
    run:
        shell(
            f"""
            {EXEC['K8']} scripts/js/paftools.js gff2bed \
                -j {input.GTF} \
                > {output.BED} \
                2> {log.log}
            """
        )