
# Download list of supported species
rule gget_species:
    output:
       SPECIES_LIST = "resources/gget_species.txt"
    threads:
        config["CORES"]
    run:
        shell(
            """
            gget ref --list_species > {output.SPECIES_LIST}
            """
        )