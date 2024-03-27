# Download list of supported species
rule gget_species:
    output:
        SPECIES_LIST="resources/gget_species.txt",
    log:
        log="logs/gget_species.log",
    threads: config["CORES"]
    conda:
        f"{workflow.basedir}/envs/gget.yml"
    shell:
        """
        gget ref --list_species \
        > {output.SPECIES_LIST} \
        2> {log.log}
        """
        # {EXEC['GGET']}
