# Download list of supported species
rule gget_species:
    output:
       SPECIES_LIST = "resources/gget_species.txt"
    threads:
        config["CORES"]
    log:
        log = "logs/gget_species.log"
    run:
        (
            f"""
            {EXEC['GGET']} ref --list_species \
            > {output.SPECIES_LIST} \
            2> {log.log}
            """
        )