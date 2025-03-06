#!/bin/bash

# usage:
## ./process_gtf.sh input.GTF gene

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <GTF_IN> <FEATURE>"
    exit 1
fi

# Assign arguments to variables
GTF_IN="$1"
FEATURE="$2"

>&2 echo "GTF used: "${GTF_IN}
>&2 echo "FEATURE used: "${FEATURE}

# Process the GTF file and print the output to stdout
        # | awk -v feature="$FEATURE" 'BEGIN{FS="\t"}{split($9,a,";"); if($3~feature) print a[1]"\t"a[3]"\t"$1":"$4"-"$5"\t"a[5]"\t"$7}' \
if [ "$FEATURE" == "gene" ]; then
    zcat "$GTF_IN" \
        | awk 'BEGIN{FS="\t"}{split($9,a,";"); if($3~"gene") print a[1]"\t"a[3]"\t"$1":"$4"-"$5"\t"a[2]"\t"$7}' \
        | sed 's/gene_id "//' \
        | sed 's/gene_id "//' \
        | sed 's/gene_type "//' \
        | sed 's/gene_name "//' \
        | sed 's/gene_type "//' \
        | sed 's/"//g' \
        | sed 's/ //g' \
        | sed '1iGeneID\tGeneSymbol\tChromosome\tBiotype\tStrand'
elif [ "$FEATURE" == "transcript" ]; then
    zcat "$GTF_IN" \
        | awk 'BEGIN{FS="\t"}{split($9,a,";"); if($3~"transcript") print a[1]"\t"a[4]"\t"a[2]"\t"a[6]"\t"$1":"$4"-"$5"\t"a[3]"\t"$7}' \
        | sed 's/gene_id "//' \
        | sed 's/gene_id "//' \
        | sed 's/transcript_id "//' \
        | sed 's/transcript_name "//' \
        | sed 's/gene_type "//' \
        | sed 's/gene_name "//' \
        | sed 's/transcript_type "//' \
        | sed 's/"//g' \
        | sed 's/ //g' \
        | sed '1iGeneID\tGeneSymbol\tTranscriptID\tTranscriptSymbol\tChromosome\tBiotype\tStrand'
elif [ "$FEATURE" == "exon" ]; then
    # Add code for processing exons here
    echo "Don't know how to process exons yet..."
elif [ "$FEATURE" == "intron" ]; then
    # Add code for processing introns here
    echo "Don't know how to process introns yet..."
else
    echo "Unsupported feature type: $FEATURE"
    exit 1
fi