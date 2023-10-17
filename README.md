# Snakemake workflow to build reference genomes for common alignment pipelines in an organized manner

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


# STAR
#TODO

# kallisto
#TODO

# bowtie/bowtie2
#TODO


