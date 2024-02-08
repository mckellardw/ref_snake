# Build reference for STAR/STARsolo
rule star:
    input:
        DNA   = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/genome.fa.gz",
        GTF   = "{OUTDIR}/{SPECIES}/{BIOTYPE}/raw/annotations.gtf.gz"
    output:
        REF = "{OUTDIR}/{SPECIES}/{BIOTYPE}/STAR/Genome",
        # TMPDIR = temp(directory("{OUTDIR}/{SPECIES}/{BIOTYPE}/STAR/_STARtmp")),
    threads:
        config["CORES"]
    run:
        # biotype-specific params
        if wildcards.BIOTYPE == "rRNA":
            if wildcards.SPECIES == "mus_musculus":
                genomeSAindexNbases=6
            elif wildcards.SPECIES == "homo_sapiens":
                genomeSAindexNbases=5
        else: # standard genome ref
            genomeSAindexNbases=14


        shell(
            f"""
            pigz \
                --decompress \
                --force \
                --keep \
                -p{threads} \
                {input.DNA} {input.GTF}

            mkdir -p $(dirname {output.REF})

            {EXEC['STAR']} \
                --runMode genomeGenerate \
                --outTmpDir $(dirname {output.REF})/_STARtmp \
                --limitBAMsortRAM {config["MEMLIMIT"]} \
                --runThreadN {threads} \
                --readFilesCommand zcat \
                --genomeDir $(dirname {output.REF}) \
                --genomeFastaFiles {input.DNA.replace(".gz","")} \
                --sjdbGTFfile {input.GTF.replace(".gz","")} \
                --sjdbGTFfeatureExon exon \
                --genomeSAindexNbases {genomeSAindexNbases}
            """
        )
            # rm {input.DNA.replace(".gz","")} {input.GTF.replace(".gz","")} 
            #  --outTmpDir {OUTDIR}/{wildcards.SPECIES}/_STARtmp \

# rule star_rRNA:
#     input:
#         DNA  = "{OUTDIR}/{SPECIES}/rRNA/raw/ncrna.fa.gz",
#         GTF   = "{OUTDIR}/{SPECIES}/rRNA/raw/annotations.gtf.gz"
#     output:
#         REF = "{OUTDIR}/{SPECIES}/rRNA/STAR/Genome"
#     threads:
#         config["CORES"]
#     run:
#         shell(
#             f"""
#             pigz \
#                 --decompress \
#                 --force \
#                 --keep \
#                 -p{threads} \
#                 {input.DNA} {input.GTF}

#             mkdir -p $(dirname {output.REF})

#             {EXEC['STAR']} \
#                 --runMode genomeGenerate \
#                 --outTmpDir $(dirname {output.REF})/_STARtmp \
#                 --limitBAMsortRAM {config["MEMLIMIT"]} \
#                 --runThreadN {threads} \
#                 --readFilesCommand zcat \
#                 --genomeDir $(dirname {output.REF}) \
#                 --genomeFastaFiles {input.DNA.replace(".gz","")} \
#                 --sjdbGTFfile {input.GTF.replace(".gz","")} \
#                 --sjdbGTFfeatureExon exon            
#             """
#         )