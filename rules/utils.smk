# util functions ---------------------------------------
def get_genomeSAindexNbases(w):
    try:
        # # biotype-specific params
        if "rRNA" in w.FA:
            if w.SPECIES == "mus_musculus":
                genomeSAindexNbases = 6
            elif w.SPECIES == "homo_sapiens":
                genomeSAindexNbases = 5
        else:  # standard genome ref
            genomeSAindexNbases = 14

    except:
        genomeSAindexNbases = 14

    # return genomeSAindexNbases value
    return genomeSAindexNbases

# util rules ---------------------------------------

rule index_fasta:
    input:
        DNA="{FASTA}.fa",
    output:
        DNA_IDX="{FASTA}.fai",
    run:
        shell(
            f"""
            {EXEC['SAMTOOLS']} faidx {input.DNA}
            """
        )

rule gzip_file:
    input: "{FILE}"
    output: "{FILE}.gz"
    wildcard_constraints:
        FILE=r"^(?!.*\.gz$).*"
    threads: config["CORES"]
    shell:
        """
        pigz \
            --force \
            --keep \
            -p{threads} \
            {input}
        """

rule gunzip_file:
    input: "{FILE}.gz"
    output: "{FILE}"
    wildcard_constraints:
        FILE=r"^(?!.*\.gz$).*"
    threads: config["CORES"]
    shell:
        """
        pigz \
            --decompress \
            --force \
            --keep \
            -p{threads} \
            {input}
        """