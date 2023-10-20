# Snakemake workflow to build and organize reference genomes for common alignment tools

# TODO
## Tools to add/support:
- bwa
- minimap2
- salmon

## Other features:
- Custom references
- GENCODE annotations!
- ref genome stats?

# Setup/install
1) Build conda environment (#TODO - automate this!)
   *Note* - installing `gget` with `pip` has given me issues, I recommend using `pip`
```
conda create --name ref_snake -c bioconda star kallisto bowtie bowtie2 minimap2
conda activate ref_snake
pip install gget snakemake
```

2) Modify `config.yaml` to include what species you want to build refs for

3) Run pipeline:
```
snakemake -j 4
```

# Downloads
## Download ensembl references w/ [`gget`](https://github.com/pachterlab/gget)
Download ensembl reference (for mouse):
```
gget ref -d  mus_musculus > gget.log
```
Note that this also saves the download info in `gget.log`, so you can easily see later on what version you downloded.

## Download GENCODE references w/ `wget`
```
wget -e robots=off --recursive --no-parent  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M33
```

## Example `gget` metadata output:
```
{
    "homo_sapiens": {
        "transcriptome_cdna": {
            "ftp": "http://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz",
            "ensembl_release": 110,
            "release_date": "2023-04-22",
            "release_time": "04:25",
            "bytes": "75M"
        },
        "genome_dna": {
            "ftp": "http://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz",
            "ensembl_release": 110,
            "release_date": "2023-04-21",
            "release_time": "17:28",
            "bytes": "841M"
        },
        "annotation_gtf": {
            "ftp": "http://ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/Homo_sapiens.GRCh38.110.gtf.gz",
            "ensembl_release": 110,
            "release_date": "2023-04-24",
            "release_time": "11:54",
            "bytes": "52M"
        },
        "coding_seq_cds": {
            "ftp": "http://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/cds/Homo_sapiens.GRCh38.cds.all.fa.gz",
            "ensembl_release": 110,
            "release_date": "2023-04-22",
            "release_time": "04:25",
            "bytes": "22M"
        },
        "non-coding_seq_ncRNA": {
            "ftp": "http://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/ncrna/Homo_sapiens.GRCh38.ncrna.fa.gz",
            "ensembl_release": 110,
            "release_date": "2023-04-22",
            "release_time": "06:22",
            "bytes": "18M"
        },
        "protein_translation_pep": {
            "ftp": "http://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/pep/Homo_sapiens.GRCh38.pep.all.fa.gz",
            "ensembl_release": 110,
            "release_date": "2023-04-22",
            "release_time": "04:25",
            "bytes": "14M"
        }
    }
}
```

# Useful links/resources:
- [`gget` documentation](https://github.com/pachterlab/gget)
- [ensembl]()
- [GENCODE ftp site]()