# Download list of supported species
rule gget_species:
    output:
       SPECIES_LIST = "resources/gget_species.txt"
    threads:
        config["CORES"]
    log:
        "logs/gget_species.log"
    run:
        (
            f"""
            {GGET_EXEC} ref --list_species > {output.SPECIES_LIST}
            """
        )