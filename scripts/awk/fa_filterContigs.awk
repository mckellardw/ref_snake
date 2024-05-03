BEGIN {
    contig_file = ARGV[1]
    ARGV[1] = ""
}

# Read contig IDs from the specified file
NR == FNR {
    contigs[$0]
    next
}

# Start of a new FASTA entry
/^>/ {
    # Extract the contig name from the FASTA header
    split($0, parts, " ")
    contig_name = parts[1]
    sub(/^>/, "", contig_name)
    
    # Check if the contig name is in the list of contigs to keep
    if (contig_name in contigs) {
        print $0
        # Print the sequence lines until the next header
        while (getline > 0 && !/^>/) {
            print
        }
    } else {
        # Skip to the next FASTA entry
        while (getline > 0 && !/^>/) {}
    }
}
