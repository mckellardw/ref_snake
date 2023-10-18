# Snakemake workflow to build reference genomes for common alignment pipelines in an organized manner

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

# Useful links/resources:
- [`gget` documentation](https://github.com/pachterlab/gget)
- [ensembl]()
- [GENCODE ftp site]()