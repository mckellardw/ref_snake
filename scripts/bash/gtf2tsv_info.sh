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
        | awk -v feature="$FEATURE" 'BEGIN{FS="\t"}{split($9,a,";"); for(i in a) { if(a[i] ~ /gene_id/) gene_id=a[i]; if(a[i] ~ /gene_name/) gene_name=a[i];  if(a[i] ~ /gene_biotype/) gene_biotype=a[i]; } if($3~feature) print gene_id"\t"gene_name"\t"$1":"$4"-"$5"\t"gene_biotype"\t"$7}' \
        | sed 's/gene_id "//' \
        | sed 's/gene_source "//' \
        | sed 's/gene_biotype "//' \
        | sed 's/gene_name "//' \
        | sed 's/gene_type "//' \
        | sed 's/"//g' \
        | sed 's/ //g' \
        | sed '1iGeneID\tGeneSymbol\tChromosome\tBiotype\tStrand'
elif [ "$FEATURE" == "transcript" ]; then
    zcat "$GTF_IN" \
        | awk -v feature="$FEATURE" 'BEGIN{FS="\t"}{split($9,a,";"); for(i in a) { if(a[i] ~ /transcript_id/) transcript_id=a[i]; if(a[i] ~ /gene_id/) gene_id=a[i]; if(a[i] ~ /transcript_name/) transcript_name=a[i]; if(a[i] ~ /gene_name/) gene_name=a[i];  if(a[i] ~ /transcript_biotype/) transcript_biotype=a[i]; if(a[i] ~ /gene_biotype/) gene_biotype=a[i]; } if($3~feature) print transcript_id"\t"gene_id"\t"transcript_name"\t"gene_name"\t"$1":"$4"-"$5"\t"transcript_biotype"\t"gene_biotype"\t"$7}' \
        | sed 's/gene_id "//' \
        | sed 's/transcript_id "//' \
        | sed 's/gene_type "//' \
        | sed 's/transcript_name "//' \
        | sed 's/gene_name "//' \
        | sed 's/transcript_biotype "//' \
        | sed 's/gene_biotype "//' \
        | sed 's/"//g' \
        | sed 's/ //g' \
        | sed '1iTranscriptID\tGeneID\tTranscriptSymbol\tGeneSymbol\tChromosome\tTranscriptBiotype\tGeneBiotype\tStrand'
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